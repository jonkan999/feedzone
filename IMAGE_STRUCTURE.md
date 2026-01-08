# Image Structure & CDN Guide

## Current Structure

Images are stored in `public/images/products/` with the following organization:

```
public/images/products/
├── {product-id}/
│   ├── primary.jpg          # Main image (used in product cards)
│   ├── secondary-1.jpg      # Additional images for detail page
│   ├── secondary-2.jpg
│   └── ...
```

## Image URLs in Database

- **`image_url`**: Primary image path (e.g., `/images/products/kqm-energy-gel-refill-100ml/primary.jpg`)
- **`additional_images`**: JSONB array of additional image paths
  ```json
  [
    "/images/products/kqm-energy-gel-refill-100ml/secondary-1.jpg",
    "/images/products/kqm-energy-gel-refill-100ml/secondary-2.jpg"
  ]
  ```

## CDN Migration Strategy

### Phase 1: Local Development (Current)
- Images served from `public/images/`
- URLs: `/images/products/{product-id}/primary.jpg`

### Phase 2: CDN Preparation
1. **Upload images to CDN**:
   - Maintain same directory structure
   - Use same naming convention
   - Optimize images (compress, WebP format)

2. **Update environment variables**:
   ```env
   PUBLIC_USE_CDN=true
   PUBLIC_CDN_BASE_URL=https://cdn.example.com
   ```

3. **Use CDN helper function**:
   ```typescript
   import { getImageUrl } from '@/config/cdn';
   const imageUrl = getImageUrl(product.image_url);
   ```

### Phase 3: Database Migration
When ready to switch to CDN:

```sql
-- Update image URLs to CDN
UPDATE products 
SET 
  image_url = REPLACE(image_url, '/images/', 'https://cdn.example.com/images/'),
  additional_images = (
    SELECT jsonb_agg(
      REPLACE(value::text, '/images/', 'https://cdn.example.com/images/')
    )
    FROM jsonb_array_elements_text(additional_images)
  );
```

## CDN Options

### Option 1: Supabase Storage
```typescript
// Upload to Supabase Storage bucket
const { data } = await supabase.storage
  .from('product-images')
  .upload(`${productId}/primary.jpg`, file);

// URL format: https://{project}.supabase.co/storage/v1/object/public/product-images/{productId}/primary.jpg
```

### Option 2: Cloudflare R2
- Compatible with S3 API
- No egress fees
- Easy integration

### Option 3: AWS CloudFront + S3
- Industry standard
- Global CDN
- Pay-as-you-go pricing

### Option 4: Vercel/Netlify Assets
- Built-in CDN
- Automatic optimization
- Easy deployment

## Image Optimization

### Before Upload
1. **Resize**: 
   - Primary: 800x800px
   - Secondary: 1200x1200px
2. **Compress**: Use tools like TinyPNG, ImageOptim
3. **Format**: Prefer WebP for better compression

### Recommended Tools
- **Squoosh** (Google): Web-based image optimizer
- **ImageOptim**: Mac app for batch optimization
- **Sharp**: Node.js library for programmatic optimization

## Implementation Example

```typescript
// In product component
import { getImageUrl } from '@/config/cdn';

const primaryImage = getImageUrl(product.image_url);
const additionalImages = product.additional_images?.map(getImageUrl) || [];
```

## Future Enhancements

1. **Image lazy loading**: Use `loading="lazy"` attribute
2. **Responsive images**: Use `srcset` for different screen sizes
3. **Blur placeholders**: Show blurred version while loading
4. **Image optimization API**: Use Next.js Image or similar
5. **Automatic WebP conversion**: Serve WebP to supporting browsers

