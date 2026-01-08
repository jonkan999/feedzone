# News Article Images

This directory contains images for news articles displayed in the inspiration section of the homepage.

## Directory Structure

News article images should be organized by article ID or slug:

```
public/images/news/
├── traningstips-uthallighetsidrottare/
│   └── primary.jpg
├── branslestrategier-langa-lopningar/
│   └── primary.jpg
├── viktig-utrustning-lopare/
│   └── primary.jpg
└── bygga-traningsvolym/
    └── primary.jpg
```

## Image Naming Convention

- **Primary image**: `primary.jpg` - Main image displayed in the inspiration card
- Use the article slug (from `article_url`) as the directory name
- Images should be optimized for web (recommended: 640x480px or 800x600px)
- Supported formats: JPG, PNG, WebP

## Database Configuration

In the `news` table, set the fields as follows:

**Image URL:**
```sql
image_url = '/images/news/{article-slug}/primary.jpg'
```

**Body Content:**
The `body` field stores the full article content. It can contain:
- HTML markup (recommended for rich formatting)
- Plain text
- Markdown (if you implement a markdown parser)

For example:
- Article slug: `traningstips-uthallighetsidrottare`
- Image URL: `/images/news/traningstips-uthallighetsidrottare/primary.jpg`
- Body: Full HTML content with headings, paragraphs, lists, etc.

## Image Requirements

- **Aspect Ratio**: 16:9 or 4:3 recommended
- **Dimensions**: Minimum 640x480px, recommended 800x600px or 1200x900px
- **File Size**: Keep under 200KB for optimal loading
- **Format**: JPG for photos, PNG for graphics with transparency

## Usage in Code

News article images are automatically loaded from the database `image_url` field and displayed in:
- Homepage inspiration section (side scroller)
- News article detail pages (when implemented)

## Fallback Behavior

If an image URL is not set or the image file doesn't exist, the system will:
1. Display a gray placeholder with the article category name
2. Use the card hover overlay effect for visual feedback

