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
