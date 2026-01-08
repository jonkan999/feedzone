import type { APIRoute } from 'astro';
import { createServerClient } from '../../lib/supabase';

export const prerender = false; // Ensure server-side rendering

export const GET: APIRoute = async ({ request }) => {
  try {
    const supabase = createServerClient();
    
    // Fetch featured products for inspiration (order by inspiration_featured if set)
    const { data: products, error: productsError } = await supabase
      .from('products')
      .select('*')
      .eq('in_stock', true)
      .or('featured.eq.true,inspiration_featured.not.is.null')
      .order('inspiration_featured', { ascending: true, nullsFirst: false })
      .order('created_at', { ascending: false })
      .limit(6);

    if (productsError) {
      console.error('Error fetching products:', productsError);
    }

    // Fetch featured news articles (only published_at up to now)
    const nowISO = new Date().toISOString();
    const { data: news, error: newsError } = await supabase
      .from('news')
      .select('*')
      .eq('featured', true)
      .lte('published_at', nowISO)
      .limit(5)
      .order('published_at', { ascending: false })
      .order('created_at', { ascending: false });

    if (newsError) {
      console.error('Error fetching news:', newsError);
    }

    // Combine and format items
    const productItems: any[] = [];
    const newsItems: any[] = [];

    // Add products as "Produkt" type items
    if (products) {
      products.forEach((product) => {
        // Create a clean excerpt from description (strip HTML and truncate)
        let excerpt = product.description || '';
        // Strip HTML tags
        excerpt = excerpt.replace(/<[^>]*>/g, '');
        // Truncate to ~150 characters
        if (excerpt.length > 150) {
          excerpt = excerpt.substring(0, 150).trim() + '...';
        }
        
        productItems.push({
          id: product.id,
          type: 'product',
          category: 'Produkt',
          title: product.name,
          excerpt: excerpt,
          image_url: product.image_url,
          link: `/products/${product.id}`,
          created_at: product.created_at,
          inspiration_featured: product.inspiration_featured,
        });
      });
    }

    // Add news articles
    if (news) {
      news.forEach((article) => {
        newsItems.push({
          id: article.id,
          type: 'news',
          category: article.category,
          title: article.title,
          excerpt: article.excerpt,
          badge_text: article.badge_text,
          image_url: article.image_url,
          link: article.article_url || `/zone-news/${article.id}`,
          created_at: article.created_at,
          published_at: article.published_at,
        });
      });
    }

    // Mix items: alternate between news and products
    const mixedItems: any[] = [];
    const maxLength = Math.max(productItems.length, newsItems.length);
    
    for (let i = 0; i < maxLength; i++) {
      // Alternate: start with news, then product, then news, etc.
      if (i < newsItems.length) {
        mixedItems.push(newsItems[i]);
      }
      if (i < productItems.length) {
        mixedItems.push(productItems[i]);
      }
    }

    // Limit total items
    return new Response(JSON.stringify(mixedItems.slice(0, 8)), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    console.error('API Error:', error);
    return new Response(JSON.stringify({ error: 'Internal server error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
};

