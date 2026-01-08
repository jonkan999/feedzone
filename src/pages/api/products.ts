import type { APIRoute } from 'astro';
import { createServerClient } from '../../lib/supabase';

export const prerender = false; // Ensure server-side rendering

export const GET: APIRoute = async ({ request }) => {
  try {
    const supabase = createServerClient();
    const url = new URL(request.url);
    const featured = url.searchParams.get('featured') === 'true';
    const category = url.searchParams.get('category');

    let query = supabase
      .from('products')
      .select('*')
      .eq('in_stock', true);

    if (category) {
      query = query.eq('category', category);
    }

    if (featured) {
      // Get featured products, limit to 4
      query = query.eq('featured', true).limit(4);
    }

    const { data, error } = await query.order('name');

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    return new Response(JSON.stringify(data || []), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: 'Internal server error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
};

