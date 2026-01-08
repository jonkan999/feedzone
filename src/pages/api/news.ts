import type { APIRoute } from 'astro';
import { createServerClient } from '../../lib/supabase';

export const prerender = false; // Ensure server-side rendering

export const GET: APIRoute = async ({ request }) => {
  try {
    const supabase = createServerClient();
    const url = new URL(request.url);
    const featured = url.searchParams.get('featured') === 'true';
    const limit = url.searchParams.get('limit');

    const nowISO = new Date().toISOString();
    let query = supabase.from('news').select('*').lte('published_at', nowISO);

    if (featured) {
      query = query.eq('featured', true);
    }

    if (limit) {
      query = query.limit(parseInt(limit));
    }

    const { data, error } = await query.order('published_at', { ascending: false }).order('created_at', { ascending: false });

    if (error) {
      console.error('Supabase error:', error);
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
    console.error('API Error:', error);
    return new Response(JSON.stringify({ error: 'Internal server error' }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
};

