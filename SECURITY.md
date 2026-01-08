# Security Guide - API Keys & Secrets

## Local Development

### 1. Create Your `.env` File

Create a `.env` file in the root directory (it's already in `.gitignore`):

```bash
cp .env.example .env
```

Then fill in your actual keys. **Never commit this file to git!**

### 2. Verify `.env` is Ignored

The `.env` file is already in `.gitignore`. Verify it's not tracked:

```bash
git status
```

You should NOT see `.env` in the list. If you do, it was committed before being ignored. Remove it:

```bash
git rm --cached .env
```

### 3. File Permissions (Linux/Mac)

Make your `.env` file readable only by you:

```bash
chmod 600 .env
```

## Key Security Best Practices

### Supabase Keys

- **PUBLIC_SUPABASE_URL** & **PUBLIC_SUPABASE_ANON_KEY**: 
  - Safe to expose in client-side code (they're public)
  - Still, keep them in `.env` for consistency
  
- **SUPABASE_SERVICE_ROLE_KEY**: 
  - ⚠️ **NEVER expose this in client-side code!**
  - This key bypasses Row Level Security
  - Only use in server-side API routes
  - Treat this like a password

### Stripe Keys

- **PUBLIC_STRIPE_PUBLISHABLE_KEY**: 
  - Safe to expose (it's public)
  - Used in client-side code
  
- **STRIPE_SECRET_KEY**: 
  - ⚠️ **NEVER expose in client-side code!**
  - Only use in server-side API routes
  
- **STRIPE_WEBHOOK_SECRET**: 
  - ⚠️ **Keep secret!**
  - Used to verify webhook requests are from Stripe

### Resend Key

- **RESEND_API_KEY**: 
  - ⚠️ **Keep secret!**
  - Only use in server-side code

## Production Deployment

### Vercel

1. Go to your project settings
2. Navigate to **Environment Variables**
3. Add each variable from your `.env` file
4. Set them for the appropriate environments (Production, Preview, Development)

### Netlify

1. Go to **Site settings**
2. Navigate to **Environment variables**
3. Add each variable
4. Set scope (Build-time, Runtime, or both)

### Railway / Other Platforms

Add environment variables in your platform's dashboard. Never hardcode them in your code!

## Checking for Exposed Keys

Before committing code, check for accidentally exposed secrets:

```bash
# Search for common patterns
grep -r "STRIPE_SECRET_KEY\|SUPABASE_SERVICE_ROLE_KEY\|RESEND_API_KEY" src/ --exclude-dir=node_modules
```

You should find nothing. If you do, remove those hardcoded values immediately!

## If Keys Are Compromised

1. **Supabase**: Regenerate service role key in Supabase dashboard
2. **Stripe**: Regenerate secret key in Stripe dashboard (old one will be revoked)
3. **Resend**: Regenerate API key in Resend dashboard
4. Update all environments (local `.env` and production)

## Additional Security Tips

1. **Use different keys for development and production**
   - Stripe has test mode keys (use these for development)
   - Supabase projects can be separate for dev/prod

2. **Rotate keys periodically**
   - Especially if team members leave
   - Or if you suspect any compromise

3. **Limit key permissions**
   - Use the least privilege principle
   - Stripe: Use restricted API keys when possible
   - Supabase: RLS policies limit what the anon key can do

4. **Monitor usage**
   - Check Stripe dashboard for unusual activity
   - Monitor Supabase logs
   - Watch Resend email delivery logs

## Your Current Setup

✅ `.env` is in `.gitignore` - Good!
✅ `.env.example` exists as a template - Good!
✅ Server-side keys only used in API routes - Good!

Just make sure:
- Your `.env` file exists with real keys
- Never commit `.env` to git
- Use environment variables in production hosting

