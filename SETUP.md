# Feed Zone - Quick Setup Guide

## Step 1: Install Dependencies

```bash
npm install
```

## Step 2: Set Up Supabase

1. Go to https://supabase.com and create a new project
2. Once your project is ready, go to **Settings > API**
3. Copy the following:
   - Project URL → `PUBLIC_SUPABASE_URL`
   - anon/public key → `PUBLIC_SUPABASE_ANON_KEY`
   - service_role key → `SUPABASE_SERVICE_ROLE_KEY` (keep this secret!)
4. Go to **SQL Editor** and run the SQL from `supabase-schema.sql`
5. This will create the tables and insert sample products

## Step 3: Set Up Stripe

1. Go to https://stripe.com and create an account
2. Go to **Developers > API keys**
3. Copy:
   - Publishable key → `PUBLIC_STRIPE_PUBLISHABLE_KEY`
   - Secret key → `STRIPE_SECRET_KEY`
4. For webhooks (production):
   - Go to **Developers > Webhooks**
   - Add endpoint: `https://feedzone.se/api/stripe/webhook`
   - Select event: `checkout.session.completed`
   - Copy the signing secret → `STRIPE_WEBHOOK_SECRET`

## Step 4: Set Up Resend (Email)

1. Go to https://resend.com and create an account
2. Verify your domain (or use the default for testing)
3. Go to **API Keys** and create a new key
4. Copy the API key → `RESEND_API_KEY`
5. Set `EMAIL_FROM` to your verified email address

## Step 5: Configure Environment Variables

1. Copy `.env.example` to `.env`
2. Fill in all the values from steps 2-4
3. Set `PUBLIC_SITE_URL` to your local URL (default: `http://localhost:4321`)

## Step 6: Run the Development Server

```bash
npm run dev
```

Visit http://localhost:4321 to see your site!

## Testing the Setup

1. **Test Authentication:**
   - Go to `/account/signup` and create an account
   - Sign in at `/account/login`

2. **Test Products:**
   - Visit `/products` to see the sample products
   - Click on a product to view details

3. **Test Cart:**
   - Add products to cart
   - Go to `/cart` to view your cart
   - Update quantities or remove items

4. **Test Checkout (Stripe Test Mode):**
   - Go to `/checkout` (must be signed in)
   - Fill in shipping information
   - Use Stripe test card: `4242 4242 4242 4242`
   - Any future expiry date and any CVC

5. **Test Orders:**
   - After checkout, go to `/account/orders`
   - View your order history
   - Click on an order to see details

## Customizing Colors

Edit `src/config/colors.ts` to change the color palette. The colors are applied via CSS variables, so you can easily swap out the entire palette.

## Troubleshooting

### Database Connection Issues
- Make sure your Supabase project is active
- Verify all environment variables are set correctly
- Check that you ran the SQL schema file

### Stripe Issues
- Make sure you're using test mode keys for development
- Verify webhook URL is correct (for production)
- Check Stripe dashboard for webhook delivery logs

### Email Not Sending
- Verify your Resend API key is correct
- Make sure `EMAIL_FROM` is a verified domain/email
- Check Resend dashboard for delivery logs

### Authentication Not Working
- Clear browser cookies and try again
- Make sure Supabase Auth is enabled in your project
- Check browser console for errors

## Next Steps

- Add your own products via Supabase dashboard
- Customize the color palette in `src/config/colors.ts`
- Add product images to `public/images/`
- Deploy to Vercel or Netlify

