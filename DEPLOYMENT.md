# Deployment Guide - Feed Zone

## Recommended Hosting Platforms

For your Astro e-commerce site with API routes, webhooks, and server-side rendering, here are the best options:

## 🥇 Top Recommendation: Vercel

**Why Vercel is perfect for your site:**

- ✅ **Excellent Astro support** - Built by the same team, seamless integration
- ✅ **Serverless functions** - Perfect for API routes (Stripe webhooks, auth endpoints)
- ✅ **Automatic HTTPS** - SSL certificates included
- ✅ **Edge network** - Fast global CDN
- ✅ **Free tier** - Generous limits for small/medium sites
- ✅ **Easy deployment** - Connect GitHub, auto-deploy on push
- ✅ **Environment variables** - Easy to configure
- ✅ **Custom domains** - Easy to add `feedzone.se`
- ✅ **Preview deployments** - Test before production

**Free Tier Limits:**

- 100GB bandwidth/month
- 100 serverless function executions/day
- Unlimited static assets
- Perfect for starting out

**Pricing:** Free → $20/month (Pro) when you need more

### Setup Steps for Vercel:

1. **Install Vercel CLI** (optional, for local testing):

   ```bash
   npm i -g vercel
   ```

2. **Deploy via Dashboard** (recommended):

   - Go to https://vercel.com
   - Sign up/login with GitHub
   - Click "Add New Project"
   - Import your repository
   - Configure:
     - **Framework Preset**: Astro
     - **Build Command**: `npm run build`
     - **Output Directory**: `dist`
     - **Install Command**: `npm install`
   - Add environment variables (see below)
   - Click "Deploy"

3. **Add Environment Variables** in Vercel Dashboard:

   - Go to Project → Settings → Environment Variables
   - Add all variables from your `.env` file:
     ```
     PUBLIC_SUPABASE_URL
     PUBLIC_SUPABASE_ANON_KEY
     SUPABASE_SERVICE_ROLE_KEY
     PUBLIC_STRIPE_PUBLISHABLE_KEY
     STRIPE_SECRET_KEY
     STRIPE_WEBHOOK_SECRET
     RESEND_API_KEY
     EMAIL_FROM
     PUBLIC_SITE_URL
     ```
   - Set `PUBLIC_SITE_URL=https://feedzone.se` for production

4. **Add Custom Domain**:

   - Go to Project → Settings → Domains
   - Add `feedzone.se`
   - Follow DNS instructions (add CNAME record)
   - Vercel handles SSL automatically

5. **Update Stripe Webhook**:
   - Stripe Dashboard → Webhooks
   - Update endpoint to: `https://feedzone.se/api/stripe/webhook`

**Vercel Configuration File** (optional, create `vercel.json`):

```json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "astro",
  "rewrites": [
    {
      "source": "/api/:path*",
      "destination": "/api/:path*"
    }
  ]
}
```

---

## 🥈 Alternative: Netlify

**Why Netlify is also great:**

- ✅ Excellent Astro support
- ✅ Serverless functions for API routes
- ✅ Free tier with good limits
- ✅ Easy GitHub integration
- ✅ Built-in form handling (if needed later)
- ✅ Edge functions support

**Free Tier Limits:**

- 100GB bandwidth/month
- 125,000 serverless function invocations/month
- 300 build minutes/month

**Pricing:** Free → $19/month (Pro)

### Setup Steps for Netlify:

1. **Create `netlify.toml`** in project root:

   ```toml
   [build]
     command = "npm run build"
     publish = "dist"

   [[plugins]]
     package = "@astrojs/netlify"
   ```

2. **Install Netlify adapter**:

   ```bash
   npm install @astrojs/netlify
   ```

3. **Update `astro.config.mjs`**:

   ```js
   import netlify from "@astrojs/netlify";

   export default defineConfig({
     output: "server",
     adapter: netlify(),
     // ... rest of config
   });
   ```

4. **Deploy**:
   - Go to https://netlify.com
   - Sign up/login with GitHub
   - Click "Add new site" → "Import an existing project"
   - Select your repository
   - Add environment variables
   - Click "Deploy site"

---

## 🥉 Alternative: Cloudflare Pages

**Why Cloudflare Pages:**

- ✅ Excellent performance (edge network)
- ✅ Free tier with generous limits
- ✅ Built-in DDoS protection
- ✅ Workers for API routes
- ⚠️ Requires Cloudflare Workers adapter setup

**Free Tier Limits:**

- Unlimited bandwidth
- 100,000 requests/day (Workers)
- Great for high traffic

**Pricing:** Free → $5/month (Workers paid)

### Setup Steps for Cloudflare Pages:

1. **Install Cloudflare adapter**:

   ```bash
   npm install @astrojs/cloudflare
   ```

2. **Update `astro.config.mjs`**:

   ```js
   import cloudflare from "@astrojs/cloudflare";

   export default defineConfig({
     output: "server",
     adapter: cloudflare(),
     // ... rest of config
   });
   ```

3. **Deploy via Cloudflare Dashboard**:
   - Connect GitHub repository
   - Configure build settings
   - Add environment variables

---

## Comparison Table

| Feature                  | Vercel     | Netlify    | Cloudflare Pages |
| ------------------------ | ---------- | ---------- | ---------------- |
| **Astro Support**        | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐         |
| **Ease of Setup**        | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐   | ⭐⭐⭐           |
| **Free Tier**            | Excellent  | Excellent  | Excellent        |
| **Performance**          | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐   | ⭐⭐⭐⭐⭐       |
| **Serverless Functions** | ✅         | ✅         | ✅ (Workers)     |
| **Custom Domain**        | ✅ Easy    | ✅ Easy    | ✅ Easy          |
| **SSL/HTTPS**            | ✅ Auto    | ✅ Auto    | ✅ Auto          |
| **Git Integration**      | ✅         | ✅         | ✅               |
| **Preview Deploys**      | ✅         | ✅         | ✅               |

## My Recommendation

**Start with Vercel** because:

1. Best Astro integration (made by same team)
2. Easiest setup - no adapter needed for basic SSR
3. Perfect for e-commerce with API routes
4. Excellent free tier
5. Easy to migrate later if needed

## Environment Variables Checklist

Make sure to set these in your hosting platform:

### Required for All Environments:

```env
PUBLIC_SUPABASE_URL=your_supabase_url
PUBLIC_SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_live_...  # Use live keys for production
STRIPE_SECRET_KEY=sk_live_...  # Use live keys for production
STRIPE_WEBHOOK_SECRET=whsec_...  # From production webhook
RESEND_API_KEY=re_...
EMAIL_FROM=noreply@feedzone.se
PUBLIC_SITE_URL=https://feedzone.se
```

### Important Notes:

1. **Use Live Mode Stripe Keys** in production (not test keys!)
2. **Set `PUBLIC_SITE_URL`** to `https://feedzone.se` for production
3. **Update Stripe Webhook** to point to production URL
4. **Verify Domain in Resend** before going live

## Post-Deployment Checklist

- [ ] Domain (`feedzone.se`) connected and SSL active
- [ ] All environment variables set correctly
- [ ] Stripe webhook updated to production URL
- [ ] Test checkout flow with test card
- [ ] Verify order confirmation emails are sending
- [ ] Check Resend dashboard for email delivery
- [ ] Test guest checkout
- [ ] Test logged-in checkout
- [ ] Monitor error logs for first few days

## DNS Configuration

For `feedzone.se`:

**If using Vercel:**

- Add CNAME record: `feedzone.se` → `cname.vercel-dns.com`
- Or A record: Point to Vercel's IP (check Vercel dashboard)

**If using Netlify:**

- Add CNAME record: `feedzone.se` → `your-site.netlify.app`

**If using Cloudflare Pages:**

- Add CNAME record: `feedzone.se` → `your-site.pages.dev`

## Monitoring & Analytics

Consider adding:

- **Vercel Analytics** (built-in, free tier available)
- **Sentry** (error tracking)
- **Google Analytics** (if needed)
- **Resend Dashboard** (email delivery monitoring)
- **Stripe Dashboard** (payment monitoring)

## Need Help?

- **Vercel Docs**: https://vercel.com/docs
- **Astro Deployment**: https://docs.astro.build/en/guides/deploy/
- **Netlify Docs**: https://docs.netlify.com/
- **Cloudflare Pages**: https://developers.cloudflare.com/pages/
