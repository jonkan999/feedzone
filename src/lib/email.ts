import { Resend } from 'resend';

const resendApiKey = import.meta.env.RESEND_API_KEY;
const emailFrom = import.meta.env.EMAIL_FROM || 'noreply@feedzone.se';

if (!resendApiKey) {
  throw new Error('Missing RESEND_API_KEY environment variable');
}

export const resend = new Resend(resendApiKey);

export interface OrderConfirmationEmail {
  to: string;
  orderId: string;
  orderDate: string;
  items: Array<{
    name?: string;
    product_name?: string;
    quantity: number;
    price: number;
  }>;
  total: number;
  shippingAddress: {
    name: string;
    street: string;
    city: string;
    state: string;
    zip: string;
  };
}

export async function sendOrderConfirmation(data: OrderConfirmationEmail) {
  const itemsList = data.items
    .map((item) => `${item.name || item.product_name || 'Product'} x${item.quantity} - ${item.price.toFixed(2)} SEK`)
    .join('\n');

  const html = `
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <style>
          body { font-family: system-ui, sans-serif; line-height: 1.6; color: #1A1A1A; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: #2C5F2D; color: white; padding: 20px; text-align: center; }
          .content { background: #FFFFFF; padding: 20px; }
          .order-details { background: #F5F5DC; padding: 15px; margin: 20px 0; }
          .footer { text-align: center; color: #666666; font-size: 12px; margin-top: 20px; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>Feed Zone</h1>
            <p>Order Confirmation</p>
          </div>
          <div class="content">
            <h2>Thank you for your order!</h2>
            <p>Your order has been received and is being processed.</p>
            
            <div class="order-details">
              <h3>Order Details</h3>
              <p><strong>Order ID:</strong> ${data.orderId}</p>
              <p><strong>Order Date:</strong> ${data.orderDate}</p>
              
              <h4>Items:</h4>
              <pre>${itemsList}</pre>
              
              <p><strong>Total: ${data.total.toFixed(2)} SEK</strong></p>
              
              <h4>Shipping Address:</h4>
              <p>
                ${data.shippingAddress.name}<br>
                ${data.shippingAddress.street}<br>
                ${data.shippingAddress.city}, ${data.shippingAddress.state} ${data.shippingAddress.zip}
              </p>
            </div>
            
            <p>You will receive another email when your order ships with tracking information.</p>
            <p>Expected delivery: 3-5 business days</p>
          </div>
          <div class="footer">
            <p>Feed Zone - Nutritional Supplements for Endurance Athletes</p>
          </div>
        </div>
      </body>
    </html>
  `;

  return await resend.emails.send({
    from: emailFrom,
    to: data.to,
    subject: `Order Confirmation - ${data.orderId}`,
    html,
  });
}

export interface ShippingNotificationEmail {
  to: string;
  orderId: string;
  trackingNumber?: string;
  estimatedDelivery: string;
}

export async function sendShippingNotification(data: ShippingNotificationEmail) {
  const html = `
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="utf-8">
        <style>
          body { font-family: system-ui, sans-serif; line-height: 1.6; color: #1A1A1A; }
          .container { max-width: 600px; margin: 0 auto; padding: 20px; }
          .header { background: #2C5F2D; color: white; padding: 20px; text-align: center; }
          .content { background: #FFFFFF; padding: 20px; }
          .shipping-info { background: #F5F5DC; padding: 15px; margin: 20px 0; }
          .footer { text-align: center; color: #666666; font-size: 12px; margin-top: 20px; }
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>Feed Zone</h1>
            <p>Your Order Has Shipped!</p>
          </div>
          <div class="content">
            <h2>Great news!</h2>
            <p>Your order ${data.orderId} has been shipped.</p>
            
            <div class="shipping-info">
              ${data.trackingNumber ? `<p><strong>Tracking Number:</strong> ${data.trackingNumber}</p>` : ''}
              <p><strong>Estimated Delivery:</strong> ${data.estimatedDelivery}</p>
            </div>
            
            <p>Thank you for shopping with Feed Zone!</p>
          </div>
          <div class="footer">
            <p>Feed Zone - Nutritional Supplements for Endurance Athletes</p>
          </div>
        </div>
      </body>
    </html>
  `;

  return await resend.emails.send({
    from: emailFrom,
    to: data.to,
    subject: `Your Feed Zone Order Has Shipped - ${data.orderId}`,
    html,
  });
}

