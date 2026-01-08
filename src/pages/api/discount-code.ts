import type { APIRoute } from 'astro';
import { createServerClient } from '../../lib/supabase';

export const prerender = false;

export const GET: APIRoute = async ({ url }) => {
  const code = (url.searchParams.get('code') || '').trim().toUpperCase();

  if (!code) {
    return new Response(JSON.stringify({ error: 'Code required' }), {
      status: 400,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  const supabase = createServerClient();

  const { data, error } = await supabase
    .from('discount_codes')
    .select('*')
    .eq('code', code)
    .eq('active', true)
    .maybeSingle();

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  if (!data) {
    return new Response(JSON.stringify({ error: 'Ogiltig eller inaktiv kod' }), {
      status: 404,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  if (data.expires_at && new Date(data.expires_at) < new Date()) {
    return new Response(JSON.stringify({ error: 'Koden har gått ut' }), {
      status: 410,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  return new Response(JSON.stringify({
    code: data.code,
    type: data.type,
    value: Number(data.value || 0),
  }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
};

