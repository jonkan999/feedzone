# Product Images Directory

This directory contains product images organized by product ID.

## Directory Structure

```
public/images/products/
├── {product-id}/
│   ├── primary.jpg          # Main product image (used in product cards)
│   ├── secondary-1.jpg      # Additional images for product detail page
│   ├── secondary-2.jpg
│   └── ...
```

## Image Naming Convention

- **Primary image**: `{product-id}/primary.jpg` (or `.png`, `.webp`)
- **Secondary images**: `{product-id}/secondary-{number}.jpg`

## CDN Migration

When migrating to a CDN (e.g., Cloudflare, AWS CloudFront, or Supabase Storage):

1. Upload images to your CDN bucket/storage
2. Update `image_url` and `additional_images` in database to use CDN URLs
3. Example CDN URL format: `https://cdn.example.com/products/{product-id}/primary.jpg`

## Image Requirements

- **Primary image**: Recommended 800x800px, max 2MB
- **Secondary images**: Recommended 1200x1200px, max 3MB
- Formats: JPG, PNG, or WebP
- Optimize images before upload for better performance

## Current Products

See `../products.sql` for product IDs and image references.
