# Resend Email Setup Guide

## Overview

Resend is used to send transactional emails for Feed Zone:

- **Order confirmations**: Sent automatically when a customer completes checkout
- **Shipping notifications**: Sent when orders are shipped (future feature)

## Step 1: Create Resend Account

1. Go to https://resend.com
2. Sign up for a free account (no credit card required)
3. Verify your email address

## Step 2: Get Your API Key

1. In Resend Dashboard, go to **API Keys**
2. Click **Create API Key**
3. Give it a name (e.g., "Feed Zone Production" or "Feed Zone Development")
4. Select permissions:
   - **Sending access**: Full access (for sending emails)
5. Click **Add**
6. **Copy the API key immediately** (you won't be able to see it again!)
   - It starts with `re_...`
   - Format: `re_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx`

## Step 3: Verify Your Domain (Recommended for Production)

For production, you should verify your own domain. For development/testing, you can use Resend's default domain.

### Option A: Use Default Domain (Quick Start - Development)

Resend provides a default domain for testing: `onboarding@resend.dev`

**Limitations:**

- Only works for testing
- Emails may go to spam
- Not suitable for production

**Setup:**

- Use `EMAIL_FROM=onboarding@resend.dev` in your `.env` file

### Option B: Verify Your Domain (Production)

1. In Resend Dashboard, go to **Domains**
2. Click **Add Domain**
3. Enter your domain (e.g., `feedzone.se`)
4. Resend will provide DNS records to add:
   - **SPF record**: `v=spf1 include:resend.com ~all`
   - **DKIM record**: A TXT record with a specific value
   - **DMARC record** (optional but recommended)
5. Add these records to your domain's DNS settings
6. Wait for verification (usually takes a few minutes)
7. Once verified, you can use emails like `noreply@feedzone.se`

**Setup:**

- Use `EMAIL_FROM=noreply@feedzone.se` in your `.env` file

## Step 4: Configure Environment Variables

Add these to your `.env` file:

```env
# Resend Email Configuration
RESEND_API_KEY=re_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
EMAIL_FROM=noreply@feedzone.se  # or onboarding@resend.dev for testing
```

### For Different Environments

**Local Development:**

```env
RESEND_API_KEY=re_...  # Your Resend API key
EMAIL_FROM=onboarding@resend.dev  # Use default domain for testing
```

**Production:**

```env
RESEND_API_KEY=re_...  # Same or different API key (your choice)
EMAIL_FROM=noreply@feedzone.se  # Use your verified domain
```

## Step 5: Test Email Sending

### Test Order Confirmation Email

1. Complete a test checkout (use Stripe test mode)
2. Check your email inbox for the order confirmation
3. Check Resend Dashboard → **Logs** to see email delivery status

### Manual Test (Optional)

You can test the email function directly by creating a test script:

```typescript
// test-email.ts (temporary file for testing)
import { sendOrderConfirmation } from "./src/lib/email";

sendOrderConfirmation({
  to: "your-email@example.com",
  orderId: "test-order-123",
  orderDate: new Date().toLocaleDateString(),
  items: [{ product_name: "Test Product", quantity: 1, price: 99.0 }],
  total: 99.0,
  shippingAddress: {
    name: "Test User",
    street: "123 Test St",
    city: "Test City",
    state: "",
    zip: "12345",
  },
})
  .then(() => {
    console.log("Email sent!");
  })
  .catch((error) => {
    console.error("Error:", error);
  });
```

## How It Works

### Order Confirmation Flow

1. Customer completes checkout
2. Stripe webhook (`/api/stripe/webhook`) receives `checkout.session.completed` event
3. Webhook creates order in database
4. Webhook calls `sendOrderConfirmation()` from `src/lib/email.ts`
5. Email is sent via Resend API
6. Customer receives order confirmation email

### Email Templates

The current implementation includes:

1. **Order Confirmation Email** (`sendOrderConfirmation`)

   - Sent automatically after successful checkout
   - Includes order details, items, total, shipping address
   - HTML formatted with Feed Zone branding

2. **Shipping Notification Email** (`sendShippingNotification`)
   - Ready for future use
   - Will be sent when order status changes to "shipped"
   - Includes tracking information

## Troubleshooting

### Email Not Sending

1. **Check API Key**:

   - Verify `RESEND_API_KEY` is correct in `.env`
   - Make sure there are no extra spaces or quotes

2. **Check From Address**:

   - For development: Use `onboarding@resend.dev`
   - For production: Use verified domain (e.g., `noreply@feedzone.se`)
   - Unverified domains will fail

3. **Check Resend Dashboard**:

   - Go to **Logs** in Resend Dashboard
   - Look for failed deliveries
   - Check error messages

4. **Check Webhook Logs**:
   - If email fails, webhook will log error but won't fail
   - Check server logs for email errors
   - Email failures don't prevent order creation

### Common Errors

**"Invalid API key"**

- Verify your API key is correct
- Make sure it starts with `re_`
- Check for typos or extra spaces

**"Domain not verified"**

- Use `onboarding@resend.dev` for testing
- Or verify your domain in Resend Dashboard

**"Email address is not allowed"**

- Resend free tier has restrictions
- Make sure recipient email is valid
- Check Resend dashboard for sending limits

**"Rate limit exceeded"**

- Free tier: 100 emails/day
- Upgrade plan for more emails
- Check usage in Resend Dashboard

## Resend Free Tier Limits

- **100 emails per day**
- **3,000 emails per month**
- Default domain available for testing
- Full API access

For production, consider upgrading if you expect more volume.

## Production Checklist

- [ ] Create Resend account
- [ ] Get API key
- [ ] Verify your domain (recommended)
- [ ] Add `RESEND_API_KEY` to production environment variables
- [ ] Add `EMAIL_FROM` with verified domain to production environment variables
- [ ] Test order confirmation email
- [ ] Monitor Resend Dashboard → Logs for delivery issues
- [ ] Set up email monitoring/alerts if needed

## Security Notes

- **Never commit API keys to git** (`.env` is already in `.gitignore`)
- **Use different API keys for dev/prod** (optional but recommended)
- **Rotate API keys periodically** (Resend Dashboard → API Keys)
- **Monitor email logs** for suspicious activity

## Next Steps

1. Set up Resend account and get API key
2. Add keys to `.env` file
3. Test with a test order
4. Verify domain for production
5. Monitor email delivery in Resend Dashboard

## Additional Resources

- Resend Documentation: https://resend.com/docs
- Resend API Reference: https://resend.com/docs/api-reference
- Email Best Practices: https://resend.com/docs/send-with-best-practices
