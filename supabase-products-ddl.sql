-- Final DDL for products table
-- Run this in Supabase SQL Editor

DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  category TEXT,
  image_url TEXT,
  additional_images JSONB DEFAULT '[]'::jsonb,
  variants JSONB DEFAULT NULL,
  in_stock BOOLEAN DEFAULT true,
  featured BOOLEAN DEFAULT false,
  inspiration_featured INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_in_stock ON products(in_stock);
CREATE INDEX IF NOT EXISTS idx_products_featured ON products(featured) WHERE featured = true;
CREATE INDEX IF NOT EXISTS idx_products_inspiration_featured ON products(inspiration_featured);

-- Comments
COMMENT ON TABLE products IS 'Products for the Feed Zone store';
COMMENT ON COLUMN products.image_url IS 'Primary product image (used in product cards)';
COMMENT ON COLUMN products.additional_images IS 'Array of additional image URLs for product detail page';
COMMENT ON COLUMN products.featured IS 'Whether product should appear on homepage featured products';
COMMENT ON COLUMN products.inspiration_featured IS 'Numeric order for Inspiration & Nyheter carousel (lower number = earlier)';
COMMENT ON COLUMN products.variants IS 'Product variants (e.g., flavors, sizes) as JSON object';

