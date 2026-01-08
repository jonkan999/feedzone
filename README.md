# Feed Zone - E-commerce Site

Premium nutritional supplements and fueling products for endurance athletes, especially runners. Built with a retro bicycling aesthetic.

## Tech Stack

- **Frontend/Backend**: Astro (hybrid rendering)
- **Database & Auth**: Supabase (PostgreSQL + Authentication)
- **Payments**: Stripe
- **Email**: Resend
- **Styling**: Tailwind CSS

## Getting Started

### Prerequisites

- Node.js 18+ and npm
- A Supabase account (free tier works)
- A Stripe account (test mode is fine for development)
- A Resend account (free tier available)

### Installation

1. Clone the repository and install dependencies:

```bash
npm install
```

2. Set up environment variables:

Create a `.env` file in the root directory based on `.env.example`:

```env
# Supabase Configuration
PUBLIC_SUPABASE_URL=your_supabase_project_url
PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key

# Stripe Configuration
PUBLIC_STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
STRIPE_SECRET_KEY=your_stripe_secret_key
STRIPE_WEBHOOK_SECRET=your_stripe_webhook_secret

# Resend Email Configuration
RESEND_API_KEY=your_resend_api_key
EMAIL_FROM=noreply@feedzone.se

# Site Configuration
PUBLIC_SITE_URL=http://localhost:4321
```

### Database Setup

1. Create a new project in Supabase
2. Go to the SQL Editor in your Supabase dashboard
3. Run the SQL from `supabase-schema.sql` to create the tables and sample data
4. Copy your project URL and anon key from Settings > API
5. Copy your service role key from Settings > API (keep this secret!)

### Stripe Setup

1. Create a Stripe account at https://stripe.com
2. Get your API keys from the Stripe Dashboard (Developers > API keys)
3. For webhooks:
   - Go to Developers > Webhooks
   - Add endpoint: `https://feedzone.se/api/stripe/webhook`
   - Select event: `checkout.session.completed`
   - Copy the webhook signing secret

### Resend Setup

1. Create a Resend account at https://resend.com
2. Verify your domain (or use the default for testing)
3. Get your API key from the dashboard
4. Update `EMAIL_FROM` with your verified email address

### Supabase Authentication Setup

The site includes full authentication with email confirmation, password reset, and security notifications. Here's how to configure it:

#### 1. Configure Email Settings in Supabase Dashboard

Go to **Authentication → Emails** in your Supabase dashboard and enable:

- ✅ **Confirm sign up** - Requires email verification before login
- ✅ **Reset password** - Allows users to reset forgotten passwords
- ✅ **Change email address** - Requires verification when email changes
- ✅ **Reauthentication** - Extra security for sensitive actions
- ✅ **All Security Notifications** - Notify users of security changes

#### 2. Configure URL Settings

Go to **Authentication → URL Configuration**:

- **Site URL:** Set this to your production URL: `https://feedzone.se`
  - ⚠️ **Important:** Don't use `localhost` here! Use your production domain.
  - The code will automatically handle local development redirects
- **Redirect URLs:** Add:
  - `https://feedzone.se/**` (production)
  - `http://localhost:4321/**` (for local testing - only add if you need to test locally)

**For Local Development:**

- Make sure your dev server is running (`npm run dev`) before clicking confirmation links
- Or use a tool like [ngrok](https://ngrok.com) to create a public URL for local testing
- The confirmation email will redirect to `PUBLIC_SITE_URL` from your `.env` file

#### 3. Set Up Custom SMTP (Production)

For production, configure custom SMTP instead of Supabase's built-in service:

1. Go to **Authentication → Emails → SMTP Settings**
2. Click **Set up SMTP**
3. Configure with Resend:
   - **Host:** `smtp.resend.com`
   - **Port:** `465` (SSL) or `587` (TLS)
   - **Username:** `resend`
   - **Password:** Your Resend API key
   - **Sender email:** `noreply@feedzone.se` (must be verified in Resend)
   - **Sender name:** `Feed Zone`

#### 4. Customize Email Templates

Supabase allows you to customize email templates. Go to **Authentication → Emails → Templates** and customize:

**Confirm sign up email:**

```
Subject: Bekräfta din e-postadress för Feed Zone

Hej!

Tack för att du registrerade dig på Feed Zone. Klicka på länken nedan för att bekräfta din e-postadress och aktivera ditt konto:

{{ .ConfirmationURL }}

Om du inte registrerade dig på Feed Zone kan du ignorera detta meddelande.

Med vänliga hälsningar,
Feed Zone Team
```

**Reset password email:**

```
Subject: Återställ ditt lösenord för Feed Zone

Hej!

Du har begärt att återställa ditt lösenord för Feed Zone. Klicka på länken nedan för att skapa ett nytt lösenord:

{{ .ConfirmationURL }}

Om du inte begärde detta kan du ignorera detta meddelande. Ditt lösenord kommer inte att ändras.

Länken är giltig i 24 timmar.

Med vänliga hälsningar,
Feed Zone Team
```

**Change email address email:**

```
Subject: Bekräfta din nya e-postadress för Feed Zone

Hej!

Du har begärt att ändra din e-postadress för Feed Zone. Klicka på länken nedan för att bekräfta din nya e-postadress:

{{ .ConfirmationURL }}

Om du inte begärde detta kan du ignorera detta meddelande. Din e-postadress kommer inte att ändras.

Med vänliga hälsningar,
Feed Zone Team
```

**Password changed notification:**

```
Subject: Ditt lösenord har ändrats

Hej!

Ditt lösenord för Feed Zone har ändrats.

Om du inte gjorde denna ändring, kontakta oss omedelbart på support@feedzone.se.

Med vänliga hälsningar,
Feed Zone Team
```

**Email address changed notification:**

```
Subject: Din e-postadress har ändrats

Hej!

Din e-postadress för Feed Zone har ändrats till: {{ .NewEmail }}

Om du inte gjorde denna ändring, kontakta oss omedelbart på support@feedzone.se.

Med vänliga hälsningar,
Feed Zone Team
```

**Magic link email (if enabled):**

```
Subject: Din inloggningslänk för Feed Zone

Hej!

Klicka på länken nedan för att logga in på Feed Zone:

{{ .ConfirmationURL }}

Om du inte begärde detta kan du ignorera detta meddelande.

Länken är giltig i 1 timme.

Med vänliga hälsningar,
Feed Zone Team
```

#### 5. Available Authentication Routes

The site includes the following authentication pages:

- `/account/login` - User login
- `/account/signup` - User registration
- `/account/confirm` - Email confirmation handler (accessed via email link)
- `/account/forgot-password` - Request password reset
- `/account/reset-password` - Reset password (accessed via email link)
- `/account` - User account dashboard
- `/account/orders` - Order history
- `/account/orders/[id]` - Individual order details

#### 6. Testing Authentication

1. **Test Signup:**

   - Go to `/account/signup`
   - Create a new account
   - Check email inbox (and spam folder) for confirmation email
   - Click confirmation link
   - Verify redirect works and user can log in

2. **Test Password Reset:**

   - Go to `/account/login`
   - Click "Glömt lösenord?"
   - Enter email address
   - Check email for reset link
   - Complete password reset flow

3. **Test Email Confirmation:**
   - Sign up with a new email
   - Verify confirmation email is sent
   - Try logging in before confirmation (should fail)
   - Confirm email and verify login works

### Running the Development Server

```bash
npm run dev
```

Visit `http://localhost:4321` to see your site.

### Building for Production

```bash
npm run build
```

The built site will be in the `dist/` directory.

## Project Structure

```
feedzone/
├── src/
│   ├── layouts/          # Page layouts
│   ├── pages/            # Astro pages (routes)
│   │   ├── api/          # API endpoints
│   │   ├── products/     # Product pages
│   │   └── account/      # Account pages
│   ├── components/       # Reusable components
│   ├── lib/              # Utility functions
│   ├── config/           # Configuration files
│   └── styles/           # Global styles
├── public/               # Static assets
│   ├── images/
│   │   ├── products/     # Product images (see products/README.md)
│   │   └── news/         # News article images (see news/README.md)
└── supabase-schema.sql   # Database schema
```

## News Articles & Images

News articles are stored in the `news` table and displayed in the inspiration section on the homepage.

### Image Structure

News article images follow this structure:

```
public/images/news/
├── {article-slug}/
│   └── primary.jpg
```

Where `{article-slug}` matches the slug from the `article_url` field in the database.

**Example:**

- Article URL: `/zone-news/traningstips-uthallighetsidrottare`
- Image path: `/images/news/traningstips-uthallighetsidrottare/primary.jpg`
- Database `image_url`: `/images/news/traningstips-uthallighetsidrottare/primary.jpg`

See `public/images/news/README.md` for detailed image requirements and setup instructions.

### Setting Up News Articles

1. Run the news table migration:

   ```sql
   -- Run: supabase-migration-add-news.sql
   ```

2. Insert sample news articles:

   ```sql
   -- Run: supabase-news-insert.sql
   ```

3. Add images to `public/images/news/{article-slug}/primary.jpg`

4. Update `image_url` in the database to match the file path

## Features

- User authentication (sign up, sign in, sign out)
- Product catalog with categories
- Shopping cart (localStorage-based)
- Stripe checkout integration
- Order management and history
- Email notifications (order confirmations, shipping updates)
- Responsive design with retro bicycling theme
- Configurable color palette

## Customizing Colors

Edit `src/config/colors.ts` to change the color palette. The colors are applied via CSS variables in `src/styles/global.css`.

## Deployment

### Vercel

1. Push your code to GitHub
2. Import your repository in Vercel
3. Add your environment variables
4. Deploy!

### Netlify

1. Push your code to GitHub
2. Import your repository in Netlify
3. Build command: `npm run build`
4. Publish directory: `dist`
5. Add your environment variables
6. Deploy!

## License

MIT
