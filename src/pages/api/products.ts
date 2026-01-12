import type { APIRoute } from 'astro';
import { createServerClient } from '../../lib/supabase';

export const prerender = false; // Ensure server-side rendering

type ProductRow = {
  id: string;
  name: string;
  description: string | null;
  price: number;
  category: string | null;
  categories: string[] | null;
  image_url: string | null;
  additional_images: string[] | null;
  group_id: string | null;
  variant_type: string | null;
  variant_value: string | null;
  variant_sort: number | null;
  featured: boolean;
  in_stock: boolean;
  inspiration_featured: number | null;
  product_groups?: { selection_label?: string | null; name?: string | null } | null;
};

type ListedProduct = ProductRow & {
  selection_label?: string | null;
  siblings?: Array<{
    id: string;
    name: string;
    price: number;
    image_url: string | null;
    variant_value: string | null;
    variant_type: string | null;
    variant_sort: number | null;
  }>;
};

const selectionLabelFallback = (variantType?: string | null) => {
  if (!variantType) return null;
  if (variantType === 'flavor') return 'Välj smak';
  if (variantType === 'size') return 'Välj storlek';
  if (variantType === 'quantity') return 'Välj mängd';
  return 'Välj alternativ';
};

export const GET: APIRoute = async ({ request }) => {
  try {
    const supabase = createServerClient();
    const url = new URL(request.url);
    const featured = url.searchParams.get('featured') === 'true';
    const category = url.searchParams.get('category');
    const brand = url.searchParams.get('brand');

    let query = supabase
      .from('products')
      .select('*, product_groups(selection_label,name)')
      .eq('in_stock', true);

    if (brand) {
      query = query.eq('brand', brand);
    }

    if (category) {
      query = query.or(`category.eq.${category},categories.cs.{${category}}`);
    }

    if (featured) {
      // Get featured products, limit to 4
      query = query.eq('featured', true).limit(4);
    }

    // Order by group then variant_sort then name for consistent grouping
    const { data, error } = await query
      .order('group_id', { nullsFirst: true })
      .order('variant_sort', { ascending: true, nullsFirst: true })
      .order('name');

    if (error) {
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { 'Content-Type': 'application/json' },
      });
    }

    const products = (data || []) as ProductRow[];
    const groupedMap = new Map<
      string,
      { canonical: ProductRow; siblings: ListedProduct['siblings']; selection_label?: string | null }
    >();

    for (const product of products) {
      const key = product.group_id || product.id;
      const selectionLabel =
        product.product_groups?.selection_label || selectionLabelFallback(product.variant_type);
      const siblingEntry = {
        id: product.id,
        name: product.name,
        price: product.price,
        image_url: product.image_url,
        variant_value: product.variant_value,
        variant_type: product.variant_type,
        variant_sort: product.variant_sort,
      };

      if (!groupedMap.has(key)) {
        groupedMap.set(key, {
          canonical: product,
          siblings: [siblingEntry],
          selection_label: selectionLabel,
        });
        continue;
      }

      const existing = groupedMap.get(key)!;
      existing.siblings?.push(siblingEntry);

      // Pick canonical as the lowest variant_sort (or keep existing)
      const currentSort = existing.canonical.variant_sort ?? Number.MAX_SAFE_INTEGER;
      const incomingSort = product.variant_sort ?? Number.MAX_SAFE_INTEGER;
      if (incomingSort < currentSort) {
        existing.canonical = product;
      }

      if (!existing.selection_label) {
        existing.selection_label = selectionLabel;
      }
    }

    const result: ListedProduct[] = Array.from(groupedMap.values()).map(
      ({ canonical, siblings, selection_label }) => ({
        ...canonical,
        categories:
          (canonical.categories && canonical.categories.length > 0
            ? canonical.categories
            : canonical.category
            ? [canonical.category]
            : null),
        selection_label,
        siblings: (siblings || []).sort(
          (a, b) => (a.variant_sort ?? 0) - (b.variant_sort ?? 0)
        ),
        product_groups: undefined,
      })
    );

    return new Response(JSON.stringify(result), {
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

