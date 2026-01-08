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
    const { items, shipping_address, shipping_method } = body;

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

    // Calculate shipping costs
    const shippingCost = 59; // PostNord shipping cost in SEK
    const freeShippingThreshold = 400;
    const qualifiesForFreeShipping = subtotal >= freeShippingThreshold;
    const finalShippingCost = qualifiesForFreeShipping ? 0 : shippingCost;

    const siteUrl = import.meta.env.PUBLIC_SITE_URL || 'http://localhost:4321';

    // Create Stripe checkout session line items
    const lineItems = items.map((item: any, index: number) => {
      const productData = productDataArray[index];
      const itemPrice = productData?.price ?? item.price;
      return {
      price_data: {
          currency: 'sek',
        product_data: {
          name: item.product_name,
        },
          unit_amount: Math.round(itemPrice * 100), // Convert to öre (Swedish cents)
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

