import { createServerClient } from './supabase';
import type { APIContext } from 'astro';

/**
 * Get the authenticated user from the request
 * Checks both cookies and Authorization header
 */
export async function getAuthenticatedUser(context: APIContext) {
  const supabase = createServerClient();
  
  // Try to get token from cookie first
  const authToken = context.cookies.get('sb-access-token')?.value;
  
  if (authToken) {
    const { data: { user }, error } = await supabase.auth.getUser(authToken);
    if (!error && user) {
      return user;
    }
  }
  
  // Try Authorization header as fallback
  const authHeader = context.request.headers.get('Authorization');
  if (authHeader?.startsWith('Bearer ')) {
    const token = authHeader.substring(7);
    const { data: { user }, error } = await supabase.auth.getUser(token);
    if (!error && user) {
      return user;
    }
  }
  
  return null;
}

