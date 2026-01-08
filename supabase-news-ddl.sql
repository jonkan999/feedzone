-- Final DDL for news table
-- Run this in Supabase SQL Editor

DROP TABLE IF EXISTS news;

CREATE TABLE news (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  excerpt TEXT NOT NULL,
  body TEXT,
  badge_text TEXT,
  category TEXT NOT NULL CHECK (category IN ('Nyhet', 'Näring', 'Utrustning', 'Träning', 'Produkt')),
  image_url TEXT,
  article_url TEXT,
  featured BOOLEAN DEFAULT false,
  grayscale BOOLEAN DEFAULT false,
  related_products JSONB DEFAULT '[]'::jsonb,
  published_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_news_featured ON news(featured) WHERE featured = true;
CREATE INDEX IF NOT EXISTS idx_news_category ON news(category);
CREATE INDEX IF NOT EXISTS idx_news_published_at ON news(published_at DESC);

-- Comments
COMMENT ON TABLE news IS 'News/articles for inspiration and zone-news pages';
COMMENT ON COLUMN news.category IS 'Category of the news item (Nyhet, Näring, Utrustning, Träning, Produkt)';
COMMENT ON COLUMN news.excerpt IS 'Short summary/excerpt displayed in cards and previews';
COMMENT ON COLUMN news.body IS 'Full article content (HTML or markdown supported)';
COMMENT ON COLUMN news.badge_text IS 'Short 1-2 word phrase displayed in overlay badge';
COMMENT ON COLUMN news.featured IS 'Whether the news item should appear as featured in inspiration sections';
COMMENT ON COLUMN news.article_url IS 'URL to the full article page (internal or external)';
COMMENT ON COLUMN news.grayscale IS 'If true, render image in grayscale';
COMMENT ON COLUMN news.published_at IS 'Publication date; items with future dates are hidden until reached';
COMMENT ON COLUMN news.related_products IS 'Array of product ids to recommend alongside the article';

