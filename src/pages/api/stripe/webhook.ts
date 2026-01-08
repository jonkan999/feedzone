import type { APIRoute } from 'astro';
import { stripe } from '../../../lib/stripe';
import { createServerClient } from '../../../lib/supabase';
import { sendOrderConfirmation } from '../../../lib/email';

export const prerender = false; // Ensure server-side rendering

export const POST: APIRoute = async ({ request }) => {
  try {
    const webhookSecret = import.meta.env.STRIPE_WEBHOOK_SECRET;
    
    if (!webhookSecret) {
      return new Response(JSON.stringify({ error: 'Webhook secret not configured' }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const body = await request.text();
    const signature = request.headers.get('stripe-signature');

    if (!signature) {
      return new Response(JSON.stringify({ error: 'No signature' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    let event;
    try {
      event = stripe.webhooks.constructEvent(body, signature, webhookSecret);
    } catch (err: any) {
      return new Response(JSON.stringify({ error: `Webhook signature verification failed: ${err.message}` }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const supabase = createServerClient();

    // Handle the checkout.session.completed event
    if (event.type === 'checkout.session.completed') {
      const session = event.data.object as any;

      // Get the session details to retrieve line items
      const sessionWithLineItems = await stripe.checkout.sessions.retrieve(session.id, {
        expand: ['line_items.data.price.product'],
      });

      const lineItems = sessionWithLineItems.line_items?.data || [];
      const shippingAddress = JSON.parse(session.metadata?.shipping_address || '{}');
      const userId = session.metadata?.user_id;
      const customerEmail = session.customer_email || shippingAddress.email;
      const discountCode = session.metadata?.discount_code || null;
      const discountValue = session.metadata?.discount_value ? Number(session.metadata.discount_value) : 0;
      const discountAmountApplied = session.metadata?.discount_amount_applied ? Number(session.metadata.discount_amount_applied) : 0;

      // Validate that we have either user_id or email
      if (!userId && !customerEmail) {
        return new Response(JSON.stringify({ error: 'User ID or customer email required' }), {
          status: 400,
          headers: { 'Content-Type': 'application/json' },
        });
      }

      // Calculate total
      const total_amount = session.amount_total ? session.amount_total / 100 : 0;

      // Create order
      const orderItems = lineItems
        .filter((item: any) => !item.description?.includes('Frakt')) // Exclude shipping line item
        .map((item: any) => {
          const productMeta = (item.price?.product as any)?.metadata || {};
          const configStr = productMeta.config as string | undefined;
          let configSummary = '';
          if (configStr) {
            try {
              const cfg = JSON.parse(configStr);
              configSummary = Object.entries(cfg)
                .filter(([, v]) => v !== undefined && v !== null && v !== '')
                .map(([k, v]) => `${k}:${v}`)
                .join(' | ');
            } catch (e) {
              configSummary = '';
            }
          }

          const productId =
            (productMeta.product_id as string | undefined) ||
            (item.price?.product as string | undefined) ||
            'unknown';

          return {
            product_id: productId,
            product_name: configSummary
              ? `${item.description || 'Unknown Product'} | ${configSummary}`
              : item.description || 'Unknown Product',
            quantity: item.quantity || 1,
            price: (item.price?.unit_amount || 0) / 100,
          };
        });

      const { data: order, error: orderError } = await supabase
        .from('orders')
        .insert({
          user_id: userId || null,
          customer_email: customerEmail || null,
          stripe_payment_intent_id: session.payment_intent as string,
          status: 'paid',
          total_amount,
          discount_code: discountCode,
          discount_amount: discountAmountApplied || discountValue || 0,
          shipping_address: shippingAddress,
        })
        .select()
        .single();

      if (orderError || !order) {
        console.error('Error creating order:', orderError);
        return new Response(JSON.stringify({ error: 'Failed to create order' }), {
          status: 500,
          headers: { 'Content-Type': 'application/json' },
        });
      }

      // Create order items
      const itemsToInsert = orderItems.map((item: any) => ({
        order_id: order.id,
        product_id: item.product_id,
        product_name: item.product_name,
        quantity: item.quantity,
        price: item.price,
      }));

      await supabase.from('order_items').insert(itemsToInsert);

      // Get user email - try from session first, then from Supabase, then from order
      let userEmail = session.customer_email || customerEmail;
      
      if (!userEmail && userId) {
        try {
          // Try to get user email from Supabase
          const { data: { user } } = await supabase.auth.admin.getUserById(userId);
          userEmail = user?.email;
        } catch (error) {
          console.error('Error fetching user email:', error);
        }
      }

      // Send confirmation email
      if (userEmail) {
        try {
          await sendOrderConfirmation({
            to: userEmail,
            orderId: order.id,
            orderDate: new Date(order.created_at).toLocaleDateString(),
            items: orderItems,
            total: total_amount,
            shippingAddress: {
              name: shippingAddress.name || '',
              street: shippingAddress.street || '',
              city: shippingAddress.city || '',
              state: shippingAddress.state || '',
              zip: shippingAddress.zip || '',
            },
          });
        } catch (emailError) {
          console.error('Error sending email:', emailError);
          // Don't fail the webhook if email fails
        }
      }
    }

    return new Response(JSON.stringify({ received: true }), {
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

