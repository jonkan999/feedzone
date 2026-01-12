-- Final DDL for products + grouping/variant support
-- Run this in Supabase SQL Editor

-- Drop in dependency order
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS product_groups;

-- Group metadata (labels for variant selection)
CREATE TABLE product_groups (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  selection_label TEXT NOT NULL
);

-- Products table
CREATE TABLE products (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10, 2) NOT NULL,
  brand TEXT,
  category TEXT,
  categories TEXT[],
  image_url TEXT,
  additional_images JSONB DEFAULT '[]'::jsonb,
  variants JSONB DEFAULT NULL,
  -- Variant grouping
  group_id TEXT REFERENCES product_groups(id),
  variant_type TEXT,     -- e.g., flavor | size | quantity
  variant_value TEXT,    -- e.g., Citron | 250 ml | 12-pack
  variant_sort INTEGER DEFAULT 0,
  in_stock BOOLEAN DEFAULT true,
  featured BOOLEAN DEFAULT false,
  inspiration_featured INTEGER,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_brand ON products(brand);
CREATE INDEX IF NOT EXISTS idx_products_categories_gin ON products USING GIN (categories);
CREATE INDEX IF NOT EXISTS idx_products_in_stock ON products(in_stock);
CREATE INDEX IF NOT EXISTS idx_products_featured ON products(featured) WHERE featured = true;
CREATE INDEX IF NOT EXISTS idx_products_inspiration_featured ON products(inspiration_featured);
CREATE INDEX IF NOT EXISTS idx_products_group ON products(group_id);

-- Uniqueness for variant values within a group
CREATE UNIQUE INDEX IF NOT EXISTS idx_products_group_variant
  ON products(group_id, variant_value)
  WHERE group_id IS NOT NULL;

-- Comments
COMMENT ON TABLE products IS 'Products for the Feed Zone store';
COMMENT ON COLUMN products.image_url IS 'Primary product image (used in product cards)';
COMMENT ON COLUMN products.additional_images IS 'Array of additional image URLs for product detail page';
COMMENT ON COLUMN products.featured IS 'Whether product should appear on homepage featured products';
COMMENT ON COLUMN products.inspiration_featured IS 'Numeric order for Inspiration & Nyheter carousel (lower number = earlier)';
COMMENT ON COLUMN products.categories IS 'Array of categories to allow multi-category placement (supersedes single category)';
COMMENT ON COLUMN products.variants IS 'Product variants (legacy JSON payload; prefer group-based variants)';
COMMENT ON TABLE product_groups IS 'Shared metadata for grouped products (flavor/size/quantity)';
COMMENT ON COLUMN products.group_id IS 'Foreign key to product_groups when product is part of a variant family';
COMMENT ON COLUMN products.variant_type IS 'Dimension of the variant (flavor, size, quantity, etc.)';
COMMENT ON COLUMN products.variant_value IS 'Human-friendly label for this variant (e.g., Citron, 250 ml)';
COMMENT ON COLUMN products.variant_sort IS 'Ordering for sibling variants within a group';

