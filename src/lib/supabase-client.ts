// Client-side Supabase initialization
// This file is specifically for use in <script> tags in Astro components

import { createClient } from '@supabase/supabase-js';
import type { Database } from '../types/database.types';

// Initialize Supabase client for browser use
function initSupabaseClient() {
  const supabaseUrl = import.meta.env.PUBLIC_SUPABASE_URL;
  const supabaseAnonKey = import.meta.env.PUBLIC_SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseAnonKey) {
    console.warn('Missing Supabase environment variables. Please add PUBLIC_SUPABASE_URL and PUBLIC_SUPABASE_ANON_KEY to your .env file');
    // Return a mock client that won't crash but won't work either
    return {
      auth: {
        getSession: () => Promise.resolve({ data: { session: null }, error: { message: 'Missing Supabase config' } }),
        signInWithPassword: () => Promise.resolve({ data: null, error: { message: 'Missing Supabase config' } }),
        signOut: () => Promise.resolve({ error: null }),
      }
    } as any;
  }

  return createClient<Database>(supabaseUrl, supabaseAnonKey);
}

// Export a singleton instance for convenience (only in browser)
export const supabase = typeof window !== 'undefined' ? initSupabaseClient() : (() => {
  // Return a mock object in SSR context to prevent errors
  return {
    auth: {
      getSession: () => Promise.resolve({ data: { session: null }, error: null }),
      signInWithPassword: () => Promise.resolve({ data: null, error: { message: 'SSR context' } }),
      signOut: () => Promise.resolve({ error: null }),
    }
  } as any;
})();

