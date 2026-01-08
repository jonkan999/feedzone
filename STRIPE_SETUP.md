# Stripe Checkout Setup Guide

## Current Order Flow

Here's what happens when an order is placed:

### 1. **Checkout Page** (`/checkout`)

- User fills in shipping information (email, name, address)
- Order summary shows items, subtotal, shipping cost (59 SEK, free over 400 SEK)
- User clicks "Fortsätt till betalning"

### 2. **Create Checkout Session** (`/api/stripe/create-checkout`)

- Fetches product data from database to get accurate prices
- Calculates subtotal and shipping costs
- Creates a Stripe Checkout Session with:
  - Line items (products + shipping if applicable)
  - Customer email
  - Metadata (shipping address, user_id if logged in)
  - Success URL: `/checkout/success?session_id={CHECKOUT_SESSION_ID}`
  - Cancel URL: `/cart`
- Returns Stripe checkout URL

### 3. **Stripe Checkout**

- User is redirected to Stripe's hosted checkout page
- User enters payment details (card: `4242 4242 4242 4242` for test mode)
- Stripe processes payment

### 4. **After Payment Success**

- User is redirected to `/checkout/success`
- Cart is cleared from localStorage
- Success page shows confirmation

### 5. **Webhook Handler** (`/api/stripe/webhook`)

- Stripe sends `checkout.session.completed` event to webhook
- Webhook verifies signature
- Creates order in Supabase `orders` table
- Creates order items in `order_items` table
- Sends confirmation email (if email service configured)

## ✅ Guest Checkout Support (Fixed)

Guest checkout is now supported! The system will:

- Store `customer_email` for guest orders
- Make `user_id` nullable (only set if user is logged in)
- Allow webhook to create orders without requiring authentication

## Stripe Dashboard Setup

### 1. Get Your API Keys

1. Go to https://stripe.com and sign in
2. Navigate to **Developers** → **API keys**
3. Copy your keys:
   - **Publishable key** → `PUBLIC_STRIPE_PUBLISHABLE_KEY`
   - **Secret key** → `STRIPE_SECRET_KEY` (starts with `sk_`)

### 2. Set Up Webhook Endpoint (Event Destination)

1. In Stripe Dashboard, go to **Developers** → **Event destinations** (or **Webhooks** → **Add endpoint**)
2. Click **Create an event destination** (or **Add endpoint**)
3. **Select events**:
   - Choose "Selected events"
   - Select `checkout.session.completed`
   - Click **Continue**
4. **Choose destination type**:
   - Select **Webhook endpoint** (or **API endpoint**)
   - Click **Continue**
5. **Configure your destination**:
   - **Endpoint URL**:
     - **Local development**: Use Stripe CLI (see below) - the CLI will provide a URL
     - **Production**: `https://feedzone.se/api/stripe/webhook`
   - **Description** (optional): "Feed Zone order webhook"
   - Click **Add destination** (or **Add endpoint**)
6. **Copy the Signing secret**:
   - After creating, click on the webhook endpoint
   - Find **Signing secret** → `STRIPE_WEBHOOK_SECRET` (starts with `whsec_`)
   - Or: In the webhook details, look for "Signing secret" section

### 3. Test Mode vs Live Mode

Stripe has two separate modes with different API keys:

#### Test Mode (Development)

- **Purpose**: Safe testing without real charges
- **Keys start with**:
  - `pk_test_...` (Publishable key)
  - `sk_test_...` (Secret key)
  - `whsec_...` (Webhook secret - same format for both)
- **Test cards**: Use `4242 4242 4242 4242` or other test cards
- **Where to get**: Stripe Dashboard → Developers → API keys (toggle "Test mode" ON)

#### Live Mode (Production)

- **Purpose**: Real payments with real money
- **Keys start with**:
  - `pk_live_...` (Publishable key)
  - `sk_live_...` (Secret key)
  - `whsec_...` (Webhook secret - different from test mode)
- **Real cards**: Actual customer payment methods
- **Where to get**: Stripe Dashboard → Developers → API keys (toggle "Test mode" OFF)

#### How to Switch Modes

1. In Stripe Dashboard, look for the toggle switch in the top right
2. **Test mode**: Toggle ON (blue) - shows "Test mode" badge
3. **Live mode**: Toggle OFF - shows "Live mode" badge
4. Each mode has its own set of keys and webhooks

## Environment Variables

### For Local Development (Test Mode)

Add these to your `.env` file (use **test mode** keys):

```env
# Stripe Keys (TEST MODE - for development)
PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Site URL (for redirects)
PUBLIC_SITE_URL=http://localhost:4321
```

### For Production (Live Mode)

When deploying to production, use **live mode** keys in your hosting platform's environment variables:

```env
# Stripe Keys (LIVE MODE - for production)
PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...  # Different from test mode!

# Site URL (for redirects)
PUBLIC_SITE_URL=https://feedzone.se
```

### Best Practice: Separate Keys Per Environment

**Recommended approach:**

- **Local `.env`**: Use test mode keys (`pk_test_...`, `sk_test_...`)
- **Staging/Preview**: Use test mode keys (if you have a staging environment)
- **Production**: Use live mode keys (`pk_live_...`, `sk_live_...`)

**Why separate keys?**

- Test mode: Safe to experiment, no real charges, separate data
- Live mode: Real payments, real money, production data
- Prevents accidentally charging real cards during development
- Stripe keeps test and live data completely separate

### Getting Both Sets of Keys

1. **Test Mode Keys** (for development):

   - Stripe Dashboard → Toggle "Test mode" ON
   - Developers → API keys
   - Copy `pk_test_...` and `sk_test_...`
   - Set up webhook → copy `whsec_...` (test mode webhook)

2. **Live Mode Keys** (for production):
   - Stripe Dashboard → Toggle "Test mode" OFF
   - Developers → API keys
   - Copy `pk_live_...` and `sk_live_...`
   - Set up webhook → copy `whsec_...` (live mode webhook - different!)

**Important**: Test and live mode webhooks are separate! You need to create webhook endpoints for both modes.

## Local Development with Stripe CLI

For local development, use Stripe CLI to forward webhooks (works with test mode):

1. Install Stripe CLI: https://stripe.com/docs/stripe-cli
2. Login: `stripe login`
3. Forward webhooks: `stripe listen --forward-to localhost:4321/api/stripe/webhook`
   - This automatically uses **test mode** webhooks
4. **Copy the webhook signing secret** from the CLI output (look for `whsec_...`) → use as `STRIPE_WEBHOOK_SECRET` in your `.env` file
5. The CLI will show something like:
   ```
   > Ready! Your webhook signing secret is whsec_xxxxxxxxxxxxx
   ```
   Copy that `whsec_...` value to your `.env` file

**Note**: Stripe CLI uses test mode by default. For live mode webhooks, you'll need to set up a webhook endpoint in the Stripe Dashboard (see "Set Up Webhook Endpoint" above).

## Testing the Flow

1. Add products to cart
2. Go to `/checkout`
3. Fill in shipping information
4. Click "Fortsätt till betalning"
5. Use test card: `4242 4242 4242 4242`
   - Expiry: Any future date (e.g., `12/34`)
   - CVC: Any 3 digits (e.g., `123`)
   - ZIP: Any 5 digits (e.g., `12345`)
6. Complete payment
7. Check:
   - Redirected to `/checkout/success`
   - Cart is cleared
   - Order appears in Stripe Dashboard → **Payments**
   - Webhook event appears in Stripe Dashboard → **Developers** → **Event destinations** (or **Webhooks**) → Click on your endpoint → **Events** tab
   - Order created in Supabase (if webhook works)

**Note**: If using Stripe CLI locally, you'll see webhook events in your terminal. Check the terminal output for any errors.

## Database Migration Required

**⚠️ IMPORTANT**: You need to run the updated `supabase-schema.sql` to support guest checkout:

1. Go to Supabase Dashboard → SQL Editor
2. Run the updated `supabase-schema.sql` script
3. This will:
   - Make `user_id` nullable
   - Add `customer_email` column
   - Update RLS policies for guest orders
   - Add service role policies for webhook

## Production Deployment Checklist

When deploying to production:

1. **Switch to Live Mode Keys**:

   - Get live mode keys from Stripe Dashboard (toggle test mode OFF)
   - Update environment variables in your hosting platform:
     - `PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...`
     - `STRIPE_SECRET_KEY=sk_live_...`
     - `STRIPE_WEBHOOK_SECRET=whsec_...` (from live mode webhook)
   - Update `PUBLIC_SITE_URL=https://feedzone.se`

2. **Set Up Production Webhook**:

   - Stripe Dashboard → Toggle to "Live mode"
   - Developers → Event destinations → Create endpoint
   - Endpoint URL: `https://feedzone.se/api/stripe/webhook`
   - Select event: `checkout.session.completed`
   - Copy the signing secret → use as `STRIPE_WEBHOOK_SECRET`

3. **Verify Test Mode is Disabled**:
   - Double-check your production environment variables use `pk_live_` and `sk_live_`
   - Never use test keys in production!

## What Still Needs Configuration

1. **Email Service**: Configure email service (Resend/SendGrid) for order confirmations
2. **Error Handling**: Add better error messages and logging
3. **Order Tracking**: Add order status updates (shipped, delivered)
4. **Monitoring**: Set up error tracking (Sentry, etc.) for production

## Quick Reference: Test vs Live

| Aspect          | Test Mode              | Live Mode              |
| --------------- | ---------------------- | ---------------------- |
| **Key Prefix**  | `pk_test_`, `sk_test_` | `pk_live_`, `sk_live_` |
| **Purpose**     | Development & testing  | Real payments          |
| **Charges**     | No real charges        | Real money             |
| **Cards**       | Test cards (4242...)   | Real customer cards    |
| **Data**        | Separate test data     | Production data        |
| **Webhook**     | Separate test webhook  | Separate live webhook  |
| **When to use** | Local dev, staging     | Production only        |

## Next Steps

1. ✅ Fix guest checkout support (already done)
2. Set up email service for order confirmations
3. Test complete flow end-to-end with test mode
4. When ready for production:
   - Get live mode keys from Stripe
   - Set up production webhook endpoint
   - Update production environment variables
   - Test with small real transaction first
5. Monitor production for errors
