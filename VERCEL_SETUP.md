# Vercel Deployment Guide - Feed Zone

Complete step-by-step guide to deploy Feed Zone to Vercel.

## Prerequisites

- ✅ GitHub account (or GitLab/Bitbucket)
- ✅ Your code pushed to a Git repository
- ✅ All environment variables ready (from `.env` file)
- ✅ Domain `feedzone.se` ready to connect

## Step 1: Prepare Your Repository

Make sure your code is pushed to GitHub:

```bash
# If not already done
git add .
git commit -m "Prepare for Vercel deployment"
git push origin main
```

## Step 2: Sign Up / Login to Vercel

1. Go to https://vercel.com
2. Click **"Sign Up"** or **"Login"**
3. Choose **"Continue with GitHub"** (recommended)
4. Authorize Vercel to access your GitHub account

## Step 3: Create New Project

1. In Vercel Dashboard, click **"Add New Project"**
2. You'll see a list of your GitHub repositories
3. Find and select **"feedzone"** (or your repo name)
4. Click **"Import"**

## Step 4: Configure Project Settings

Vercel should auto-detect Astro, but verify these settings:

### Framework Preset

- **Framework Preset**: `Astro` (should be auto-detected)
- If not detected, select **"Other"** and we'll configure manually

### Build Settings

- **Root Directory**: `./` (leave as default)
- **Build Command**: `npm run build` (should be auto-filled)
- **Output Directory**: `dist` (should be auto-filled)
- **Install Command**: `npm install` (should be auto-filled)

### Environment Variables

**⚠️ IMPORTANT**: Add all your environment variables here!

Click **"Environment Variables"** and add each one:

#### Supabase Variables

```
PUBLIC_SUPABASE_URL = your_supabase_project_url
PUBLIC_SUPABASE_ANON_KEY = your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY = your_supabase_service_role_key
```

#### Stripe Variables (Use LIVE keys for production!)

```
PUBLIC_STRIPE_PUBLISHABLE_KEY = pk_live_...
STRIPE_SECRET_KEY = sk_live_...
STRIPE_WEBHOOK_SECRET = whsec_... (from production webhook)
```

#### Resend Variables

```
RESEND_API_KEY = re_...
EMAIL_FROM = noreply@feedzone.se
```

#### Site Configuration

```
PUBLIC_SITE_URL = https://feedzone.se
```

**Important Notes:**

- ✅ Use **LIVE mode** Stripe keys (not test keys!)
- ✅ Set `PUBLIC_SITE_URL` to `https://feedzone.se`
- ✅ Make sure `EMAIL_FROM` uses your verified domain
- ✅ You can add variables for different environments (Production, Preview, Development)

### Advanced Settings (Optional)

Click **"Show Advanced Settings"** if you need to:

- Change Node.js version (default is usually fine)
- Add build environment variables
- Configure headers/redirects

## Step 5: Deploy

1. Review all settings
2. Click **"Deploy"**
3. Wait for build to complete (usually 1-3 minutes)
4. You'll see build logs in real-time

## Step 6: Verify Deployment

After deployment completes:

1. **Check the deployment URL**:

   - Vercel provides a URL like `feedzone-abc123.vercel.app`
   - Click to visit your site
   - Test basic functionality

2. **Check build logs**:

   - Look for any errors or warnings
   - Common issues:
     - Missing environment variables
     - Build errors
     - Import errors

3. **Test API routes**:
   - Visit `/api/products` (should return JSON)
   - Check that API routes are working

## Step 7: Add Custom Domain

### Option A: Add Domain via Vercel (Recommended)

1. Go to your project in Vercel Dashboard
2. Click **"Settings"** → **"Domains"**
3. Enter your domain: `feedzone.se`
4. Click **"Add"**

### Option B: Add www Subdomain (Optional)

If you want `www.feedzone.se`:

1. Add `www.feedzone.se` as another domain
2. Vercel will handle redirects automatically

### DNS Configuration

Configure DNS using Vercel DNS:

1. In Vercel Dashboard → **Domains** → Click on `feedzone.se`
2. Look for **"DNS Records"** section
3. Vercel will show you the required DNS records:
   - **For root domain (`feedzone.se`)**:
     - Type: `A`
     - Name: `@` (or leave blank)
     - Value: `216.198.79.1` (or the IP Vercel shows)
   - **For www subdomain (`www.feedzone.se`)**:
     - Type: `CNAME`
     - Name: `www`
     - Value: `5e64b2ef00c80ec0.vercel-dns-017.com.` (or the CNAME Vercel shows)
4. Go to your domain registrar (where you bought `feedzone.se`)
5. Find **Nameservers** settings
6. Update nameservers to Vercel's nameservers (Vercel will show these in the DNS section, typically something like `ns1.vercel-dns.com`, `ns2.vercel-dns.com`)
7. Save changes at your registrar

**Note**: Nameserver changes can take up to 48 hours to propagate, but usually complete within a few hours.

### Verify Domain

1. After adding DNS records, go back to Vercel
2. Click **"Refresh"** next to your domain
3. Wait for verification (usually a few minutes)
4. Once verified, you'll see a green checkmark ✅
5. SSL certificate is automatically provisioned (can take a few minutes)

### Configure Resend DNS Records (For Email)

To send emails from `noreply@feedzone.se`, you need to add DNS records for Resend:

1. Go to **Resend Dashboard** → **Domains** → Select `feedzone.se`
2. You'll see DNS records that need to be added. Add these records at your DNS provider:

#### Domain Verification

- **Type**: `TXT`
- **Name**: `@` (or root/blank)
- **Content**: (Get the exact value from Resend Dashboard - it will be unique for your domain)
- **TTL**: Auto (or 3600)

**Note**: The domain verification TXT record content will be shown in your Resend Dashboard. Copy it exactly as shown.

#### DKIM (DomainKeys Identified Mail)

- **Type**: `TXT`
- **Name**: `resend._domainkey`
- **Content**: `p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCx54PWasBQVVuo4TiBJ2pQYl/pCXeGDQTwUL5bvb8CzzQhuRCpYyt/zcSNpsns92OTpMmOZKKiLLlFic1I1bX0QaI/2b+yGUOVype2u5pGGm3dvYDQx5Efhr81xLgqHbnvqdlz6MmRP+NPVYhrO85hm+7C4gKucmMpbIZJ6qxU1wIDAQAB`
- **TTL**: Auto (or 3600)

**⚠️ Note**: When adding this record in Vercel DNS, you may see a warning about "Wildcard Domain Override". This is **normal and safe to proceed** - it's just informing you that this specific record will take precedence over any wildcard records (like `*._domainkey.feedzone.se`). Since you're setting up Resend for the first time and don't have other services using wildcard DKIM records, you can safely click **"Continue"** or **"Add Record"**.

#### SPF (Sender Policy Framework) - Enable Sending

- **Type**: `TXT`
- **Name**: `send`
- **Content**: `v=spf1 include:amazonses.com ~all`
- **TTL**: Auto (or 3600)

#### MX Record - Enable Receiving (Optional, if you want to receive emails)

- **Type**: `MX`
- **Name**: `send`
- **Content**: `feedback-smtp.eu-west-1.amazonses.com`
- **Priority** (or **MX Priority**): `10`
- **TTL**: Auto (or 3600)

**Note**: In Vercel DNS, make sure to fill in the **Priority** field (sometimes labeled as **MX Priority**). If you see an error about "missing required property `mxPriority`", ensure the Priority field is set to `10`.

**Important Notes:**

- Add these records in **Vercel Dashboard** → **Domains** → `feedzone.se` → **DNS Records**
- After adding records, go back to Resend Dashboard and click **"Verify"** or **"Refresh"**
- Verification usually takes a few minutes to a few hours
- Once verified, you'll see green checkmarks ✅ next to each record in Resend

## Step 8: Update Stripe Webhook

Now that your site is live, update Stripe webhook:

1. Go to Stripe Dashboard → **Developers** → **Event destinations** (or **Webhooks**)
2. Find your production webhook endpoint
3. Edit the endpoint URL:
   - **Old**: `https://your-domain.com/api/stripe/webhook`
   - **New**: `https://feedzone.se/api/stripe/webhook`
4. Save changes
5. Test the webhook (Stripe has a "Send test webhook" button)

## Step 9: Test Everything

Run through this checklist:

### Basic Functionality

- [ ] Homepage loads correctly
- [ ] Products page loads
- [ ] Product detail pages work
- [ ] Cart functionality works
- [ ] Checkout page loads

### Authentication

- [ ] Sign up works
- [ ] Login works
- [ ] Account page accessible

### Payments (Use Test Mode First!)

- [ ] Add products to cart
- [ ] Go to checkout
- [ ] Fill in shipping info
- [ ] Complete test payment (use Stripe test card: `4242 4242 4242 4242`)
- [ ] Verify redirect to success page
- [ ] Check that order was created in Supabase
- [ ] Verify email was sent (check Resend dashboard)

### API Routes

- [ ] `/api/products` returns products
- [ ] `/api/products/[id]` returns single product
- [ ] Stripe webhook receives events (check Stripe dashboard)

### Email

- [ ] Order confirmation emails are sending
- [ ] Check Resend dashboard → Logs for delivery status
- [ ] Verify emails aren't going to spam

## Step 10: Monitor & Optimize

### Vercel Dashboard

Monitor your deployment:

- **Deployments**: See all deployments and their status
- **Analytics**: View traffic, performance metrics (if enabled)
- **Logs**: Check serverless function logs
- **Settings**: Manage environment variables, domains, etc.

### Enable Vercel Analytics (Optional)

1. Go to Project → **Analytics**
2. Enable **Web Analytics** (free tier available)
3. Get insights into:
   - Page views
   - Unique visitors
   - Performance metrics
   - Top pages

### Set Up Monitoring

Consider adding:

- **Sentry** for error tracking
- **Vercel Speed Insights** for performance monitoring
- **Resend Dashboard** for email monitoring
- **Stripe Dashboard** for payment monitoring

## Troubleshooting

### Build Fails

**Error: Missing environment variables**

- Solution: Add all required env vars in Vercel Dashboard

**Error: Build command failed**

- Check build logs for specific errors
- Common issues:
  - Missing dependencies
  - TypeScript errors
  - Import errors

**Error: Function timeout**

- Increase timeout in Vercel settings (if needed)
- Optimize slow API routes

### Domain Not Working

**DNS not propagating**

- Wait up to 48 hours
- Check DNS propagation: https://dnschecker.org
- Verify DNS records are correct

**SSL certificate not issued**

- Wait a few minutes after domain verification
- Check Vercel dashboard for SSL status
- Contact Vercel support if stuck

### API Routes Not Working

**404 on API routes**

- Verify routes have `export const prerender = false;`
- Check Vercel function logs
- Ensure routes are in `src/pages/api/` directory

**Webhook not receiving events**

- Verify webhook URL is correct: `https://feedzone.se/api/stripe/webhook`
- Check Stripe dashboard for webhook delivery logs
- Check Vercel function logs for errors

### Emails Not Sending

**Check Resend Dashboard**

- Go to Resend → Logs
- Look for failed deliveries
- Check error messages

**Common issues:**

- Invalid API key
- Domain not verified
- Rate limit exceeded (free tier: 100/day)

## Environment Variables Reference

Quick reference for all variables needed:

```env
# Supabase
PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Stripe (LIVE MODE for production!)
PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...
STRIPE_SECRET_KEY=sk_live_...
STRIPE_WEBHOOK_SECRET=whsec_...

# Resend
RESEND_API_KEY=re_...
EMAIL_FROM=noreply@feedzone.se

# Site
PUBLIC_SITE_URL=https://feedzone.se
```

## Vercel CLI (Optional)

For advanced users, you can also deploy via CLI:

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel

# Deploy to production
vercel --prod
```

## Continuous Deployment

Vercel automatically deploys when you push to your main branch:

1. **Automatic Deployments**:

   - Push to `main` → Production deployment
   - Push to other branches → Preview deployment

2. **Preview Deployments**:

   - Every branch gets its own URL
   - Perfect for testing before merging
   - Share preview URLs with team

3. **Deploy Hooks** (Optional):
   - Create webhook URLs for manual deployments
   - Useful for CI/CD integration

## Vercel Free Tier Limits

**What's included:**

- ✅ 100GB bandwidth/month
- ✅ 100 serverless function invocations/day
- ✅ Unlimited static assets
- ✅ Automatic SSL certificates
- ✅ Custom domains
- ✅ Preview deployments

**When you might need to upgrade:**

- More than 100 function invocations/day
- More than 100GB bandwidth/month
- Need team collaboration features
- Need more build minutes

**Pricing**: Free → $20/month (Pro) → Custom (Enterprise)

## Next Steps

After deployment:

1. ✅ Test everything thoroughly
2. ✅ Monitor for errors in first few days
3. ✅ Set up error tracking (Sentry)
4. ✅ Enable analytics if desired
5. ✅ Set up monitoring alerts
6. ✅ Document any custom configurations

## Getting Help

- **Vercel Docs**: https://vercel.com/docs
- **Vercel Support**: https://vercel.com/support
- **Astro Deployment**: https://docs.astro.build/en/guides/deploy/vercel/
- **Community**: https://github.com/vercel/vercel/discussions

## Quick Checklist

Before going live:

- [ ] All environment variables set
- [ ] Using LIVE Stripe keys (not test!)
- [ ] Domain connected and SSL active
- [ ] Stripe webhook updated to production URL
- [ ] Resend domain verified
- [ ] Test checkout completed successfully
- [ ] Order confirmation emails working
- [ ] All pages loading correctly
- [ ] Mobile responsive design verified

---

**You're all set!** Your Feed Zone site should now be live at `https://feedzone.se` 🚀
