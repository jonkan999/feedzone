import type { APIRoute } from 'astro';
import { createServerClient } from '../../../lib/supabase';

export const prerender = false;

export const POST: APIRoute = async ({ request }) => {
  try {
    const body = await request.json();
    const { email } = body;

    if (!email) {
      return new Response(JSON.stringify({ error: 'Email required' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const supabase = createServerClient();
    
    // Get site URL from environment - use production URL in production, localhost in dev
    // In production, this should be https://feedzone.se
    const siteUrl = import.meta.env.PUBLIC_SITE_URL || 
                    (import.meta.env.PROD ? "https://feedzone.se" : "http://localhost:4321");
    const redirectTo = `${siteUrl}/account/reset-password`;

    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo,
    });

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    // Always return success to prevent email enumeration
    return new Response(JSON.stringify({ 
      message: 'If an account exists with this email, a password reset link has been sent.' 
    }), {
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

