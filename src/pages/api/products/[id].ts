import type { APIRoute } from 'astro';
import { createServerClient } from '../../../lib/supabase';

export const prerender = false;

const selectionLabelFallback = (variantType?: string | null) => {
  if (!variantType) return null;
  if (variantType === 'flavor') return 'Välj smak';
  if (variantType === 'size') return 'Välj storlek';
  if (variantType === 'quantity') return 'Välj mängd';
  return 'Välj alternativ';
};

export const GET: APIRoute = async ({ params }) => {
  try {
    const supabase = createServerClient();
    const { id } = params;

    if (!id) {
      return new Response(JSON.stringify({ error: 'Product ID required' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const { data: product, error } = await supabase
      .from('products')
      .select('*, product_groups(selection_label,name)')
      .eq('id', id)
      .single();

    if (error || !product) {
      return new Response(JSON.stringify({ error: 'Product not found' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    let siblings: Array<{
      id: string;
      name: string;
      price: number;
      image_url: string | null;
      variant_value: string | null;
      variant_type: string | null;
      variant_sort: number | null;
    }> = [];

    if (product.group_id) {
      const { data: siblingData } = await supabase
        .from('products')
        .select('id,name,price,image_url,variant_value,variant_type,variant_sort')
        .eq('group_id', product.group_id)
        .order('variant_sort', { ascending: true, nullsFirst: true });

      siblings = (siblingData || []).map((s) => ({
        ...s,
      }));
    }

    const selection_label =
      product.product_groups?.selection_label || selectionLabelFallback(product.variant_type);

    const responseBody = {
      ...product,
      selection_label,
      siblings,
      product_groups: undefined,
    };

    return new Response(JSON.stringify(responseBody), {
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

