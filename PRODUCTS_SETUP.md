# Products Setup Guide

This guide will help you set up all products in your Feed Zone store.

## Step 1: Database Migration

First, run the migration to add support for multiple images and product variants:

```sql
-- Run this in Supabase SQL Editor
-- File: supabase-migration-add-images.sql
```

This migration adds:
- `additional_images` (JSONB) - Array of additional image URLs
- `featured` (BOOLEAN) - Flag for homepage display
- `variants` (JSONB) - Product variants (flavors, sizes, etc.)

## Step 2: Insert Products

Run the product inserts SQL file:

```sql
-- Run this in Supabase SQL Editor
-- File: supabase-products-insert.sql
```

This will create all 9 products:
1. **KQM Energy Gel Refill 100ml** - Carbs (Featured)
2. **Mouth and Yell 100** - Carbs
3. **Morten Drink Mix 360** - Carbs (Featured)
4. **Tailwind Drink Mix** - Carbs (Featured, with flavors)
5. **HydraPak GL Soft Flask 250ml** - Gear
6. **HydraPak GL Soft Flask 150ml** - Gear
7. **Gnomeo Broccoli Sprout Shot** - Pre-workout
8. **Tailwind Recovery Mix** - Recovery (Featured)
9. **KQM Recovery Mix** - Recovery

## Step 3: Add Product Images

### Directory Structure

Create the following directory structure in `public/images/products/`:

```
public/images/products/
├── kqm-energy-gel-refill-100ml/
│   ├── primary.jpg
│   ├── secondary-1.jpg
│   └── secondary-2.jpg
├── mouth-and-yell-100/
│   ├── primary.jpg
│   └── secondary-1.jpg
├── morten-drink-mix-360/
│   ├── primary.jpg
│   ├── secondary-1.jpg
│   └── secondary-2.jpg
├── tailwind-drink-mix/
│   ├── primary.jpg
│   ├── secondary-1.jpg
│   ├── secondary-2.jpg
│   ├── flavor-lemon.jpg
│   ├── flavor-berry.jpg
│   └── flavor-naked.jpg
├── hydrapak-gl-soft-flask-250ml/
│   ├── primary.jpg
│   └── secondary-1.jpg
├── hydrapak-gl-soft-flask-150ml/
│   ├── primary.jpg
│   └── secondary-1.jpg
├── gnomeo-broccoli-sprout-shot/
│   ├── primary.jpg
│   └── secondary-1.jpg
├── tailwind-recovery-mix/
│   ├── primary.jpg
│   └── secondary-1.jpg
└── kqm-recovery-mix/
    ├── primary.jpg
    ├── secondary-1.jpg
    └── secondary-2.jpg
```

### Image Requirements

- **Primary images**: 800x800px recommended, max 2MB
- **Secondary images**: 1200x1200px recommended, max 3MB
- **Formats**: JPG, PNG, or WebP
- **Optimize**: Compress images before upload for better performance

### Placeholder Images

Until you have actual product images, you can:
1. Use `/images/placeholder.jpg` (already exists)
2. Create product-specific placeholder images
3. Use a service like Unsplash or Pexels for temporary images

## Step 4: CDN Setup (Optional, for Production)

When ready to use a CDN:

1. **Upload images to your CDN**:
   - Cloudflare: Upload to R2 or use their CDN
   - AWS: Upload to S3 and use CloudFront
   - Supabase: Use Supabase Storage
   - Other: Your preferred CDN provider

2. **Update environment variables**:
   ```env
   PUBLIC_USE_CDN=true
   PUBLIC_CDN_BASE_URL=https://your-cdn-url.com
   ```

3. **Update database image URLs**:
   ```sql
   UPDATE products 
   SET image_url = REPLACE(image_url, '/images/', 'https://your-cdn-url.com/images/'),
       additional_images = (
         SELECT jsonb_agg(REPLACE(value::text, '/images/', 'https://your-cdn-url.com/images/')::text)
         FROM jsonb_array_elements_text(additional_images)
       );
   ```

## Step 5: Verify Products

1. Check that products appear on `/products`
2. Verify featured products show on homepage
3. Test product detail pages (`/products/{product-id}`)
4. Test image gallery on product pages
5. Test flavor selection for Tailwind Drink Mix
6. Verify cart functionality with variants

## Product Variants

The Tailwind Drink Mix product includes flavor variants:
- **Citron** (lemon)
- **Bär** (berry)
- **Naked** (unflavored)

Variants are stored in the `variants` JSONB column and displayed as a dropdown on the product page.

## Troubleshooting

### Images not showing
- Check file paths match exactly (case-sensitive)
- Verify images exist in `public/images/products/`
- Check browser console for 404 errors

### Variants not working
- Verify `variants` JSONB column exists
- Check variant structure matches expected format
- Test cart with variant selection

### Featured products not showing
- Verify `featured` column exists
- Check products have `featured = true`
- Verify API query filters correctly

## Next Steps

- Add more product images
- Optimize images for web
- Set up CDN for production
- Add product reviews/ratings
- Add product specifications/details

