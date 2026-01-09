# Supabase Authentication Email Configuration Guide

This guide explains how to configure Supabase authentication email settings for Feed Zone.

## Recommended Settings for E-commerce

### Email Confirmation (Confirm sign up)

**✅ ENABLE** - Ask users to confirm their email address after signing up

**Why:**

- Ensures valid email addresses (critical for order confirmations)
- Reduces fake/spam accounts
- Better security practices
- Required for password reset to work properly

**Important:** When enabled, users won't be able to log in until they confirm their email. You'll need to update your signup flow to handle this (see "Code Changes Required" below).

### Magic Link

**Optional** - Allow users to sign in via a one-time link sent to their email

**Why:**

- Convenient passwordless login option
- Good UX for users who forget passwords
- Reduces support requests

**Recommendation:** Enable if you want to offer passwordless login as an alternative.

### Password Reset

**✅ ENABLE** - Allow users to reset their password if they forget it

**Why:**

- Essential feature - users will forget passwords
- Standard expectation for any auth system
- Required for good UX

### Email Change Verification

**✅ ENABLE** - Ask users to verify their new email address after changing it

**Why:**

- Prevents account hijacking
- Ensures order confirmations go to correct email
- Security best practice

### Reauthentication

**✅ ENABLE** - Ask users to re-authenticate before performing sensitive actions

**Why:**

- Extra security layer for sensitive operations (e.g., changing password, deleting account)
- Prevents unauthorized changes if session is hijacked

### Security Notifications

**✅ ENABLE ALL** - Notify users about security-sensitive actions

Enable all security notification emails:

- Password changed
- Email address changed
- Phone number changed (if you add phone auth later)
- Identity linked/unlinked
- Multi-factor authentication method added/removed

**Why:**

- Users should know if their account security changes
- Helps detect unauthorized access
- Industry best practice

## Code Changes Required

### If Email Confirmation is Enabled

Your current signup flow assumes users get a session immediately. With email confirmation enabled, users need to confirm their email first. Update your signup flow:

**File: `src/pages/account/signup.astro`**

```typescript
// After successful signup, check if email confirmation is required
if (response.ok) {
  const data = await response.json();

  // If no session, email confirmation is required
  if (!data.session) {
    // Show success message asking user to check email
    if (errorMessage) {
      errorMessage.classList.remove("hidden");
      errorMessage.classList.remove("text-red-600");
      errorMessage.classList.add("text-green-600");
      errorMessage.textContent =
        "Ett bekräftelsemail har skickats till din e-postadress. Klicka på länken i mailet för att aktivera ditt konto.";
    }
    return;
  }

  // If session exists, sign in immediately
  const { error } = await supabase.auth.signInWithPassword({ email, password });
  if (error) {
    throw error;
  }
  window.location.href = "/account";
}
```

### Email Confirmation Redirect URL

**⚠️ CRITICAL:** Supabase uses the **Site URL** from the dashboard as the base for email redirects. The `emailRedirectTo` parameter in code only works if the URL is in the allowed redirect URLs list.

In Supabase Dashboard:

1. Go to **Authentication** → **URL Configuration**
2. Set **Site URL** to: `https://feedzone.se`
   - ⚠️ **MUST be your production domain**, NOT `localhost` or `localhost:3000`
   - This is the base URL Supabase uses for all email links
3. Set **Redirect URLs** to include (these allow the `emailRedirectTo` parameter to work):
   - `https://feedzone.se/**` (production - REQUIRED)
   - `http://localhost:4321/**` (only if you need to test locally)
   - Make sure `https://feedzone.se/account/confirm` is covered by the wildcard pattern

**Important Notes:**

- The Site URL should ALWAYS be your production domain (`https://feedzone.se`)
- The code will use `PUBLIC_SITE_URL` from your environment variables
- In production, set `PUBLIC_SITE_URL=https://feedzone.se` in your Vercel/environment settings
- The redirect URLs list controls which URLs are allowed for the `emailRedirectTo` parameter

**For Local Development:**

- Make sure your dev server is running (`npm run dev`) before clicking confirmation links
- The confirmation email will redirect to the URL specified in your `.env` file's `PUBLIC_SITE_URL`
- If you get "connection refused" errors, ensure:
  1. Your dev server is running on port 4321
  2. Your `.env` file has `PUBLIC_SITE_URL=http://localhost:4321`
  3. Or use [ngrok](https://ngrok.com) for a public URL during testing

This ensures confirmation links redirect back to your site.

## SMTP Configuration (Production)

For production, you should set up custom SMTP instead of using Supabase's built-in email service (which has rate limits).

### Option 1: Use Resend (Recommended)

Since you're already using Resend for order confirmations, you can use it for auth emails too:

1. Go to **Authentication** → **Emails** → **SMTP Settings**
2. Click **Set up SMTP**
3. Configure:
   - **Host:** `smtp.resend.com`
   - **Port:** `465` (SSL) or `587` (TLS)
   - **Username:** `resend`
   - **Password:** Your Resend API key
   - **Sender email:** `noreply@feedzone.se` (must be verified in Resend)
   - **Sender name:** `Feed Zone`

### Option 2: Use Supabase's Built-in Service (Development Only)

For development/testing, you can use Supabase's built-in email service, but be aware:

- Rate limits apply (limited emails per hour)
- Emails come from `noreply@mail.app.supabase.io`
- Not suitable for production

## Styled Email Templates (HTML)

Use these improved templates in **Supabase → Authentication → Emails → Templates**. Set the content type to **HTML** (Supabase keeps a plain-text fallback automatically). All links use `{{ .ConfirmationURL }}` so they keep tracking and redirect behavior intact.

### Confirm sign up

Subject: **Bekräfta din e-postadress för Feed Zone**

```html
<!DOCTYPE html>
<html>
  <body
    style="background:#f7f7f7;padding:24px;font-family:Arial,sans-serif;color:#0f172a;"
  >
    <table
      role="presentation"
      width="100%"
      cellpadding="0"
      cellspacing="0"
      style="max-width:560px;margin:0 auto;background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;"
    >
      <tr>
        <td style="padding:24px;">
          <p style="font-size:16px;margin:0 0 12px 0;">Hej!</p>
          <p style="font-size:16px;margin:0 0 18px 0;">
            Tack för att du registrerade dig på Feed Zone. Klicka på knappen
            nedan för att bekräfta din e-postadress och aktivera ditt konto.
          </p>
          <p style="text-align:center;margin:0 0 18px 0;">
            <a
              href="{{ .ConfirmationURL }}"
              style="display:inline-block;padding:12px 18px;background:#0f766e;color:#ffffff;text-decoration:none;border-radius:8px;font-weight:600;"
              >Bekräfta e-post</a
            >
          </p>
          <p style="font-size:14px;margin:0 0 8px 0;">
            Eller kopiera länken om knappen inte fungerar:
          </p>
          <p style="font-size:14px;word-break:break-all;margin:0 0 18px 0;">
            <a href="{{ .ConfirmationURL }}" style="color:#0f766e;"
              >{{ .ConfirmationURL }}</a
            >
          </p>
          <p style="font-size:14px;margin:0 0 16px 0;">
            Om du inte registrerade dig på Feed Zone kan du ignorera detta
            meddelande.
          </p>
          <p style="font-size:14px;margin:0;">
            Med vänliga hälsningar,<br />Feed Zone Team
          </p>
        </td>
      </tr>
    </table>
  </body>
</html>
```

### Reset password

Subject: **Återställ ditt lösenord för Feed Zone**

```html
<!DOCTYPE html>
<html>
  <body
    style="background:#f7f7f7;padding:24px;font-family:Arial,sans-serif;color:#0f172a;"
  >
    <table
      role="presentation"
      width="100%"
      cellpadding="0"
      cellspacing="0"
      style="max-width:560px;margin:0 auto;background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;"
    >
      <tr>
        <td style="padding:24px;">
          <p style="font-size:16px;margin:0 0 12px 0;">Hej!</p>
          <p style="font-size:16px;margin:0 0 18px 0;">
            Vi fick en begäran om att återställa ditt lösenord för Feed Zone.
            Klicka på knappen nedan för att skapa ett nytt lösenord.
          </p>
          <p style="text-align:center;margin:0 0 18px 0;">
            <a
              href="{{ .ConfirmationURL }}"
              style="display:inline-block;padding:12px 18px;background:#0f766e;color:#ffffff;text-decoration:none;border-radius:8px;font-weight:600;"
              >Återställ lösenord</a
            >
          </p>
          <p style="font-size:14px;margin:0 0 8px 0;">
            Om knappen inte fungerar, kopiera länken:
          </p>
          <p style="font-size:14px;word-break:break-all;margin:0 0 18px 0;">
            <a href="{{ .ConfirmationURL }}" style="color:#0f766e;"
              >{{ .ConfirmationURL }}</a
            >
          </p>
          <p style="font-size:14px;margin:0 0 8px 0;">
            Länken är giltig i 24 timmar.
          </p>
          <p style="font-size:14px;margin:0;">
            Om du inte begärde detta kan du ignorera meddelandet. Ditt lösenord
            kommer inte att ändras.
          </p>
          <p style="font-size:14px;margin:16px 0 0 0;">
            Med vänliga hälsningar,<br />Feed Zone Team
          </p>
        </td>
      </tr>
    </table>
  </body>
</html>
```

### Change email address

Subject: **Bekräfta din nya e-postadress för Feed Zone**

```html
<!DOCTYPE html>
<html>
  <body
    style="background:#f7f7f7;padding:24px;font-family:Arial,sans-serif;color:#0f172a;"
  >
    <table
      role="presentation"
      width="100%"
      cellpadding="0"
      cellspacing="0"
      style="max-width:560px;margin:0 auto;background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;"
    >
      <tr>
        <td style="padding:24px;">
          <p style="font-size:16px;margin:0 0 12px 0;">Hej!</p>
          <p style="font-size:16px;margin:0 0 18px 0;">
            Du har begärt att ändra din e-postadress för Feed Zone till
            <strong>{{ .NewEmail }}</strong>. Bekräfta ändringen med knappen
            nedan.
          </p>
          <p style="text-align:center;margin:0 0 18px 0;">
            <a
              href="{{ .ConfirmationURL }}"
              style="display:inline-block;padding:12px 18px;background:#0f766e;color:#ffffff;text-decoration:none;border-radius:8px;font-weight:600;"
              >Bekräfta ny e-post</a
            >
          </p>
          <p style="font-size:14px;margin:0 0 8px 0;">
            Om knappen inte fungerar, kopiera länken:
          </p>
          <p style="font-size:14px;word-break:break-all;margin:0 0 18px 0;">
            <a href="{{ .ConfirmationURL }}" style="color:#0f766e;"
              >{{ .ConfirmationURL }}</a
            >
          </p>
          <p style="font-size:14px;margin:0;">
            Om du inte begärde detta kan du ignorera meddelandet. Din
            e-postadress ändras inte utan din bekräftelse.
          </p>
          <p style="font-size:14px;margin:16px 0 0 0;">
            Med vänliga hälsningar,<br />Feed Zone Team
          </p>
        </td>
      </tr>
    </table>
  </body>
</html>
```

### Password changed notification

Subject: **Ditt lösenord har ändrats**

```html
<!DOCTYPE html>
<html>
  <body
    style="background:#f7f7f7;padding:24px;font-family:Arial,sans-serif;color:#0f172a;"
  >
    <table
      role="presentation"
      width="100%"
      cellpadding="0"
      cellspacing="0"
      style="max-width:560px;margin:0 auto;background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;"
    >
      <tr>
        <td style="padding:24px;">
          <p style="font-size:16px;margin:0 0 12px 0;">Hej!</p>
          <p style="font-size:16px;margin:0 0 12px 0;">
            Ditt lösenord för Feed Zone har ändrats.
          </p>
          <p style="font-size:14px;margin:0 0 16px 0;">
            Om det inte var du som gjorde ändringen, kontakta oss omedelbart på
            <a href="mailto:support@feedzone.se" style="color:#0f766e;"
              >support@feedzone.se</a
            >.
          </p>
          <p style="font-size:14px;margin:0;">
            Med vänliga hälsningar,<br />Feed Zone Team
          </p>
        </td>
      </tr>
    </table>
  </body>
</html>
```

### Email address changed notification

Subject: **Din e-postadress har ändrats**

```html
<!DOCTYPE html>
<html>
  <body
    style="background:#f7f7f7;padding:24px;font-family:Arial,sans-serif;color:#0f172a;"
  >
    <table
      role="presentation"
      width="100%"
      cellpadding="0"
      cellspacing="0"
      style="max-width:560px;margin:0 auto;background:#ffffff;border:1px solid #e2e8f0;border-radius:12px;"
    >
      <tr>
        <td style="padding:24px;">
          <p style="font-size:16px;margin:0 0 12px 0;">Hej!</p>
          <p style="font-size:16px;margin:0 0 12px 0;">
            Din e-postadress för Feed Zone har ändrats till
            <strong>{{ .NewEmail }}</strong>.
          </p>
          <p style="font-size:14px;margin:0 0 16px 0;">
            Om det inte var du som gjorde ändringen, kontakta oss omedelbart på
            <a href="mailto:support@feedzone.se" style="color:#0f766e;"
              >support@feedzone.se</a
            >.
          </p>
          <p style="font-size:14px;margin:0;">
            Med vänliga hälsningar,<br />Feed Zone Team
          </p>
        </td>
      </tr>
    </table>
  </body>
</html>
```

## Testing Email Configuration

1. **Test Signup:**

   - Create a new account
   - Check email inbox (and spam folder)
   - Click confirmation link
   - Verify redirect works

2. **Test Password Reset:**

   - Click "Forgot password" on login page
   - Check email for reset link
   - Complete password reset flow

3. **Test Magic Link (if enabled):**
   - Use magic link login option
   - Verify email arrives and link works

## Current Configuration Status

Based on your code, you're currently:

- ✅ Using email/password authentication
- ✅ Setting up sessions via cookies
- ⚠️ Assuming immediate session after signup (needs update if email confirmation enabled)

## Recommended Final Configuration

For Feed Zone e-commerce site:

| Setting                    | Status      | Reason                           |
| -------------------------- | ----------- | -------------------------------- |
| Confirm sign up            | ✅ Enable   | Valid emails critical for orders |
| Magic link                 | ⚪ Optional | Nice UX feature                  |
| Reset password             | ✅ Enable   | Essential feature                |
| Change email address       | ✅ Enable   | Security best practice           |
| Reauthentication           | ✅ Enable   | Extra security layer             |
| All Security Notifications | ✅ Enable   | User awareness & security        |

## Quick Setup Checklist

1. **In Supabase Dashboard → Authentication → Emails:**

   - ✅ Enable "Confirm sign up"
   - ✅ Enable "Reset password"
   - ✅ Enable "Change email address"
   - ✅ Enable "Reauthentication"
   - ✅ Enable all Security Notifications

2. **In Supabase Dashboard → Authentication → URL Configuration:**

   - Set **Site URL:** `https://feedzone.se` (or `http://localhost:4321` for dev)
   - Add **Redirect URLs:**
     - `https://feedzone.se/**`
     - `http://localhost:4321/**`

3. **For Production (SMTP Settings):**

   - Go to Authentication → Emails → SMTP Settings
   - Set up custom SMTP with Resend (see details above)

4. **Code Updates:**
   - ✅ Signup flow updated to handle email confirmation
   - ⚠️ **TODO:** Add password reset UI (`/account/reset-password` page)
   - ⚠️ **TODO:** Add "Forgot password?" link on login page

## Next Steps

1. **Enable email confirmation** in Supabase Dashboard
2. **Update signup flow** to handle confirmation requirement (see code above)
3. **Set up SMTP** with Resend for production
4. **Configure redirect URLs** in Supabase
5. **Test** the full signup → confirmation → login flow
6. **Add password reset UI** if not already present

## Troubleshooting

**Users not receiving emails:**

- Check spam folder
- Verify SMTP settings if using custom SMTP
- Check Supabase rate limits if using built-in service
- Verify email domain is configured correctly

**Confirmation links not working:**

- Verify redirect URLs are configured in Supabase
- Check that Site URL matches your domain
- Ensure links aren't expired (default: 24 hours)

**Session issues after confirmation:**

- Verify redirect URL includes proper token handling
- Check that cookies are being set correctly
- Ensure `PUBLIC_SITE_URL` matches your domain
