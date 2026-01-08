import type { APIRoute } from "astro";
import { createServerClient } from "../../../lib/supabase";

export const prerender = false;

export const POST: APIRoute = async ({ request, cookies }) => {
  try {
    const body = await request.json();
    const { email, password } = body;

    if (!email || !password) {
      return new Response(
        JSON.stringify({ error: "Email and password required" }),
        {
          status: 400,
          headers: { "Content-Type": "application/json" },
        }
      );
    }

    if (password.length < 6) {
      return new Response(
        JSON.stringify({ error: "Password must be at least 6 characters" }),
        {
          status: 400,
          headers: { "Content-Type": "application/json" },
        }
      );
    }

    const supabase = createServerClient();

    // Get site URL from environment - use production URL in production, localhost in dev
    // In production, this should be https://feedzone.se
    const siteUrl =
      import.meta.env.PUBLIC_SITE_URL ||
      (import.meta.env.PROD ? "https://feedzone.se" : "http://localhost:4321");
    // Redirect to confirmation handler page after email confirmation
    const redirectTo = `${siteUrl}/account/confirm`;

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: redirectTo,
      },
    });

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), {
        status: 400,
        headers: { "Content-Type": "application/json" },
      });
    }

    if (data.session) {
      cookies.set("sb-access-token", data.session.access_token, {
        path: "/",
        maxAge: 60 * 60 * 24 * 7, // 7 days
        httpOnly: true,
        secure: import.meta.env.PROD,
        sameSite: "lax",
      });
    }

    return new Response(
      JSON.stringify({
        user: data.user,
        session: data.session,
      }),
      {
        status: 201,
        headers: { "Content-Type": "application/json" },
      }
    );
  } catch (error) {
    return new Response(JSON.stringify({ error: "Internal server error" }), {
      status: 500,
      headers: { "Content-Type": "application/json" },
    });
  }
};
