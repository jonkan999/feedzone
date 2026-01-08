import type { APIRoute } from 'astro';
import { stripe, stripePublishableKey } from '../../../lib/stripe';
import { createServerClient } from '../../../lib/supabase';

export const prerender = false;

async function fetchProductData(productId: string, supabase: any) {
  try {
    const { data, error } = await supabase
      .from('products')
      .select('*')
      .eq('id', productId)
      .single();
    return error ? null : data;
  } catch (error) {
    console.error('Error fetching product:', error);
    return null;
  }
}

export const POST: APIRoute = async ({ request, cookies }) => {
  try {
    const authToken = cookies.get('sb-access-token')?.value;
    let user = null;
    const supabase = createServerClient();

    // Try to get user if logged in, but don't require it
    if (authToken) {
      const { data: { user: authUser }, error: authError } = await supabase.auth.getUser(authToken);
      if (!authError && authUser) {
        user = authUser;
      }
    }

    const body = await request.json();
    const { items, shipping_address, shipping_method, discount_code } = body;

    if (!items || !Array.isArray(items) || items.length === 0) {
      return new Response(JSON.stringify({ error: 'Items required' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    if (!shipping_address?.email) {
      return new Response(JSON.stringify({ error: 'Email required' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    // Fetch product data for all items to get accurate prices
    const productDataPromises = items.map((item: any) => fetchProductData(item.product_id, supabase));
    const productDataArray = await Promise.all(productDataPromises);

    // Calculate subtotal using product prices where available, fallback to cart item price
    const subtotal = items.reduce((sum: number, item: any, index: number) => {
      const productData = productDataArray[index];
      const itemPrice = productData?.price ?? item.price;
      return sum + (itemPrice * item.quantity);
    }, 0);

    // Validate discount code (optional)
    let discount: { code: string; type: 'percent' | 'free_shipping' | 'fixed_amount'; value: number } | null = null;
    if (discount_code) {
      const { data: discountRow, error: discountError } = await supabase
        .from('discount_codes')
        .select('*')
        .eq('code', discount_code.toUpperCase())
        .eq('active', true)
        .maybeSingle();

      if (discountError) {
        return new Response(JSON.stringify({ error: 'Kunde inte validera rabattkod' }), {
          status: 500,
          headers: { 'Content-Type': 'application/json' },
        });
      }

      if (!discountRow) {
        return new Response(JSON.stringify({ error: 'Ogiltig rabattkod' }), {
          status: 400,
          headers: { 'Content-Type': 'application/json' },
        });
      }

      if (discountRow.expires_at && new Date(discountRow.expires_at) < new Date()) {
        return new Response(JSON.stringify({ error: 'Rabattkoden har gått ut' }), {
          status: 400,
          headers: { 'Content-Type': 'application/json' },
        });
      }

      discount = {
        code: discountRow.code,
        type: discountRow.type,
        value: Number(discountRow.value || 0),
      };
    }

    // Calculate shipping costs
    // Check if this is a test product (free shipping)
    const isTestProduct = items.some((item: any) => item.product_id === 'test-product-1sek');
    const shippingCost = 59; // PostNord shipping cost in SEK
    const freeShippingThreshold = 400;
    const qualifiesForFreeShipping = subtotal >= freeShippingThreshold || isTestProduct || discount?.type === 'free_shipping';
    const finalShippingCost = qualifiesForFreeShipping ? 0 : shippingCost;

    // Compute discount impact on items only
    const rawSubtotal = subtotal;
    const appliedPercent = discount?.type === 'percent' ? Math.min(Math.max(discount.value, 0), 100) / 100 : 0;
    const appliedFixed = discount?.type === 'fixed_amount' ? Math.max(discount.value, 0) : 0;
    const percentSubtotal = rawSubtotal * (1 - appliedPercent);
    const fixedDiscount = discount?.type === 'fixed_amount' ? Math.min(appliedFixed, rawSubtotal - percentSubtotal) : 0;
    const discountedSubtotal = rawSubtotal - (rawSubtotal * appliedPercent) - fixedDiscount;
    const stripeMinimum = 3; // Stripe minimum in SEK
    const totalForStripe = discountedSubtotal + finalShippingCost;

    if (totalForStripe < stripeMinimum) {
      return new Response(JSON.stringify({ error: `Stripe kräver minst ${stripeMinimum} SEK för betalning. Lägg till fler varor för att fortsätta.` }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const siteUrl = import.meta.env.PUBLIC_SITE_URL || 'http://localhost:4321';

    // Create Stripe checkout session line items
    const lineItems = items.map((item: any, index: number) => {
      const productData = productDataArray[index];
      const itemPrice = productData?.price ?? item.price;
      let discountedPrice = itemPrice;

      // Apply percent
      if (appliedPercent > 0) {
        discountedPrice = itemPrice * (1 - appliedPercent);
      }
      // Apply fixed amount proportionally by item contribution
      if (fixedDiscount > 0 && rawSubtotal > 0) {
        const itemShare = (itemPrice * item.quantity) / rawSubtotal;
        const itemFixed = fixedDiscount * itemShare;
        const perUnitFixed = itemFixed / item.quantity;
        discountedPrice = Math.max(0, discountedPrice - perUnitFixed);
      }

      // Pass any custom config (e.g., custom gel) through metadata for order capture
      const config = {
        ratio: item.ratio,
        electrolytes: item.electrolytes,
        caffeine: item.caffeine,
        hydrogel: item.hydrogel,
        flavor: item.flavor,
        signature: item.signature,
      };
      const hasConfig = Object.values(config).some((v) => v !== undefined && v !== null);
      const configSummary = hasConfig
        ? Object.entries(config)
            .filter(([, v]) => v !== undefined && v !== null)
            .map(([k, v]) => `${k}:${v}`)
            .join(' | ')
        : '';

      return {
        price_data: {
          currency: 'sek',
          product_data: {
            name: item.product_name,
            description: configSummary || undefined,
            metadata: {
              product_id: item.product_id,
              ...(hasConfig ? { config: JSON.stringify(config) } : {}),
            },
          },
          unit_amount: Math.round(discountedPrice * 100), // Convert to öre (Swedish cents)
        },
        quantity: item.quantity,
      };
    });

    // Add shipping as a line item if applicable
    if (finalShippingCost > 0) {
      lineItems.push({
        price_data: {
          currency: 'sek',
          product_data: {
            name: 'Frakt - PostNord',
          },
          unit_amount: Math.round(finalShippingCost * 100),
        },
        quantity: 1,
      });
    }

    const sessionMetadata: Record<string, string> = {
      shipping_address: JSON.stringify(shipping_address),
      shipping_method: shipping_method || 'postnord',
    };

    if (user) {
      sessionMetadata.user_id = user.id;
    }

    if (discount) {
      sessionMetadata.discount_code = discount.code;
      sessionMetadata.discount_type = discount.type;
      sessionMetadata.discount_value = discount.value.toString();
      sessionMetadata.discount_amount_applied = (rawSubtotal - discountedSubtotal).toFixed(2);
    }

    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: lineItems,
      mode: 'payment',
      success_url: `${siteUrl}/checkout/success?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${siteUrl}/cart`,
      customer_email: shipping_address.email,
      metadata: sessionMetadata,
    });

    return new Response(JSON.stringify({ 
      sessionId: session.id,
      url: session.url 
    }), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error: any) {
    return new Response(JSON.stringify({ error: error.message || 'Internal server error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
};

