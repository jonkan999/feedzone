-- Insert all products for Feed Zone
-- Run this after running the migration to add image support

-- Clear existing placeholder products and groups
DELETE FROM products;
DELETE FROM product_groups;

-- Product groups (variant families)
INSERT INTO product_groups (id, name, selection_label) VALUES
  ('tailwind-drink-mix', 'Tailwind Drink Mix', 'Välj smak'),
  ('maurten-gel-100', 'Maurten Gel 100', 'Välj mängd'),
  ('hydrapak-gel-soft-flask', 'HydraPak Gel Soft Flask', 'Välj storlek');

-- Product 1: KQM Energy Gel (Refill, 1000ml)
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'kqm-energy-gel-1000ml',
  'KQM Energy Gel 1000ml',
  'KQM:s standardformel för energigel med optimal kolhydratförhållande 0.8:1 och elektrolyter (700mg natrium per 100g kolhydrater). Perfekt för långa löpningar och uthållighetsidrott. Denna refill-version ger dig 1000ml av vår premiumformel för att fylla på dina egna flaskor. Formeln är utvecklad för maximal absorption och minimerar magproblem under långa pass. Används tillsammans med våra mjuka gel-flaskor som <a href="/products/hydrapak-gel-soft-flask-250ml">HydraPak Gel Soft Flask 250ml</a> eller <a href="/products/hydrapak-gel-soft-flask-150ml">HydraPak Gel Soft Flask 150ml</a>. Där en fylld 150ml flask ger ca 100 g kolhydrater och 60 ml vatten och en fylld 250ml flask ger ca 180 g kolhydrater och 100 ml vatten. <br> 
  Gelen är packeterad i återvinningsbar och återförslutningsbar mjuk PET-påse. Öppnad påse förvaras kyld och kan användas upp till 4 veckor efter öppnnande.',
  199.00,
  'KQM',
  'carbs',
  ARRAY['carbs', 'gels'],
  true,
  true,
  1,
  '/images/products/kqm-energy-gel-1000ml/primary.jpg',
  '["/images/products/kqm-energy-gel-1000ml/secondary-1.jpg"]'::jsonb,
  NULL,
  NULL,
  NULL,
  0,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 2: Maurten Gel 100 (1 st)
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'maurten-gel-100',
  'Maurten Gel 100 (1 st)',
  'Energigel med Maurten:s patenterade Hydrogel Technology. Varje gel innehåller 25g kolhydrater och är gjord med bara sex ingredienser utan tillsatser av färgämnen, konserveringsmedel eller smakämnen. Den unika strukturen gör den lätt att konsumera under högintensiv träning och tävling. Perfekt för ultralöpning, cykling och andra uthållighetsgrenar.',
  39.00,
  'Maurten',
  'carbs',
  ARRAY['carbs', 'gels'],
  true,
  true,
  NULL,
  '/images/products/maurten-gel-100/primary.jpg',
  '["/images/products/maurten-gel-100/secondary-1.jpg"]'::jsonb,
  'maurten-gel-100',
  'quantity',
  '1 st',
  1,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 3: Maurten Gel 100 (12-pack)
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'maurten-gel-100-12-pack',
  'Maurten Gel 100 (12-pack)',
  'Energigel med Maurten:s patenterade Hydrogel Technology. 12-pack för dig som vill ladda upp inför race eller ha lager hemma. Varje gel innehåller 25g kolhydrater med samma rena ingredienslista som singel-förpackningen.',
  449.00,
  'Maurten',
  'carbs',
  ARRAY['carbs', 'gels'],
  true,
  true,
  NULL,
  '/images/products/maurten-gel-100/primary.jpg',
  '["/images/products/maurten-gel-100/secondary-1.jpg"]'::jsonb,
  'maurten-gel-100',
  'quantity',
  '12-pack',
  2,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 4: Maurten Drink Mix 320
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'maurten-drink-mix-320',
  'Maurten Drink Mix 320',
  'Komplett dryckesmix för uthållighetsidrottare med Maurten:s patenterade Hydrogel Technology. Maurten Drink Mix 320 innehåller en balanserad mix av kolhydrater, elektrolyter och näringsämnen för att hålla dig hydrerad och energifylld under långa träningspass. Formulerad för optimal absorption och smak.',
  39.00,
  'Maurten',
  'carbs',
  ARRAY['carbs'],
  true,
  true,
  NULL,
  '/images/products/maurten-drink-mix-320/primary.jpg',
  '["/images/products/maurten-drink-mix-320/secondary-1.jpg"]'::jsonb,
  NULL,
  NULL,
  NULL,
  0,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 5: Tailwind Drink Mix - Citron
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'tailwind-drink-mix-lemon',
  'Tailwind Drink Mix - Citron',
  'Tailwinds klassiska dryckesmix för uthållighet. Enkel formel med kolhydrater och elektrolyter utan onödiga tillsatser. Perfekt för långa löpningar, cykling och ultralöpning. Välj din favoritsmak nedan.',
  349.00,
  'Tailwind',
  'carbs',
  ARRAY['carbs'],
  true,
  true,
  NULL,
  '/images/products/tailwind-drink-mix/primary.jpg',
  '["/images/products/tailwind-drink-mix/secondary-1.jpg", "/images/products/tailwind-drink-mix/secondary-2.jpg", "/images/products/tailwind-drink-mix/secondary-3.jpg"]'::jsonb,
  'tailwind-drink-mix',
  'flavor',
  'Citron',
  1,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 6: Tailwind Drink Mix - Bär
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'tailwind-drink-mix-berry',
  'Tailwind Drink Mix - Bär',
  'Tailwinds klassiska dryckesmix för uthållighet. Enkel formel med kolhydrater och elektrolyter utan onödiga tillsatser. Perfekt för långa löpningar, cykling och ultralöpning. Välj din favoritsmak nedan.',
  349.00,
  'Tailwind',
  'carbs',
  ARRAY['carbs'],
  true,
  true,
  NULL,
  '/images/products/tailwind-drink-mix/primary.jpg',
  '["/images/products/tailwind-drink-mix/secondary-1.jpg", "/images/products/tailwind-drink-mix/secondary-2.jpg", "/images/products/tailwind-drink-mix/secondary-3.jpg"]'::jsonb,
  'tailwind-drink-mix',
  'flavor',
  'Bär',
  2,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 7: Tailwind Drink Mix - Naked (osmakad)
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'tailwind-drink-mix-naked',
  'Tailwind Drink Mix - Naked (osmakad)',
  'Tailwinds klassiska dryckesmix för uthållighet. Enkel formel med kolhydrater och elektrolyter utan onödiga tillsatser. Perfekt för långa löpningar, cykling och ultralöpning. Välj din favoritsmak nedan.',
  349.00,
  'Tailwind',
  'carbs',
  ARRAY['carbs'],
  true,
  true,
  NULL,
  '/images/products/tailwind-drink-mix/primary.jpg',
  '["/images/products/tailwind-drink-mix/secondary-1.jpg", "/images/products/tailwind-drink-mix/secondary-2.jpg", "/images/products/tailwind-drink-mix/secondary-3.jpg"]'::jsonb,
  'tailwind-drink-mix',
  'flavor',
  'Naked (osmakad)',
  3,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 8: Tailwind Drink Mix - DaWalter Vattenmelon
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'tailwind-drink-mix-dawalter-watermelon',
  'Tailwind Drink Mix - DaWalter Vattenmelon',
  'Tailwinds klassiska dryckesmix för uthållighet. Enkel formel med kolhydrater och elektrolyter utan onödiga tillsatser. Perfekt för långa löpningar, cykling och ultralöpning. Välj din favoritsmak nedan.',
  349.00,
  'Tailwind',
  'carbs',
  ARRAY['carbs'],
  true,
  true,
  NULL,
  '/images/products/tailwind-drink-mix/primary.jpg',
  '["/images/products/tailwind-drink-mix/secondary-1.jpg", "/images/products/tailwind-drink-mix/secondary-2.jpg", "/images/products/tailwind-drink-mix/secondary-3.jpg"]'::jsonb,
  'tailwind-drink-mix',
  'flavor',
  'DaWalter Vattenmelon',
  4,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 9: HydraPak Gel Soft Flask 250ml
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'hydrapak-gel-soft-flask-250ml',
  'HydraPak Gel Soft Flask 250ml',
  'HydraPaks populära mjuka vattenflaska i storlek 250ml. Perfekt för löpning och trailrunning. Den mjuka designen gör den lätt att bära och den tar minimal plats när den är tom. Används tillsammans med våra energigeler som <a href="/products/kqm-energy-gel-1000ml">KQM Energy Gel Refill</a>. En 250 ml flaska fylld med vår standardformula ger ca 180 g kolhydrater och 100 ml vatten. Idealisk för längre löpningar där du behöver extra mycket bränsle.',
  129.00,
  'HydraPak',
  'gear',
  ARRAY['gear'],
  true,
  true,
  2,
  '/images/products/hydrapak-gel-soft-flask-250ml/primary.jpg',
  '["/images/products/hydrapak-gel-soft-flask-250ml/secondary-1.jpg"]'::jsonb,
  'hydrapak-gel-soft-flask',
  'size',
  '250 ml',
  2,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 10: HydraPak Gel Soft Flask 150ml
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'hydrapak-gel-soft-flask-150ml',
  'HydraPak Gel Soft Flask 150ml',
  'HydraPaks kompakta mjuka vattenflaska i storlek 150ml. Perfekt för korta till medellånga löpningar där du vill ha minimal vikt och volym. Den mjuka designen gör den bekväm att bära och tar nästan ingen plats när den är tom. Används tillsammans med våra energigeler som <a href="/products/kqm-energy-gel-1000ml">KQM Energy Gel Refill</a>. En 150 ml flaska fylld med vår standardformula ger ca 100 g kolhydrater och 60 ml vatten.',
  109.00,
  'HydraPak',
  'gear',
  ARRAY['gear'],
  true,
  true,
  NULL,
  '/images/products/hydrapak-gel-soft-flask-150ml/primary.jpg',
  '["/images/products/hydrapak-gel-soft-flask-150ml/secondary-1.jpg"]'::jsonb,
  'hydrapak-gel-soft-flask',
  'size',
  '150 ml',
  1,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 11: Nomio ITC Shot
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'nomio-itc-shot',
  'Nomio ITC Shot',
  'Naturlig prestationsförbättrare som reducerar laktat under intensiv fysisk aktivitet. Nomio innehåller ITC (Isothiocyanates) från broccoligroddar och är kliniskt bevisad för att förbättra prestation och återhämtning. Varje 60ml shot ger optimal dos av ITC i en bekväm form. Bäst att ta 3 timmar före hårda träningspass för maximal effekt. Baserad på 8 års klinisk forskning vid Karolinska Institutet och GIH.',
  229.00,
  'Nomio',
  'pre-workout',
  ARRAY['pre-workout', 'kosttillskott'],
  true,
  true,
  3,
  '/images/products/nomio-itc-shot/primary.jpg',
  '["/images/products/nomio-itc-shot/secondary-1.jpg", "/images/products/nomio-itc-shot/secondary-2.jpg"]'::jsonb,
  NULL,
  NULL,
  NULL,
  0,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 12: Tailwind Recovery Mix
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'tailwind-recovery-mix',
  'Tailwind Recovery Mix',
  'Tailwinds återhämtningsmix designad för att hjälpa din kropp återhämta sig efter träning. Innehåller protein, kolhydrater och viktiga näringsämnen för muskelåterhämtning och glykogenåterställning. Perfekt efter långa löpningar eller intensiva träningspass.',
  349.00,
  'Tailwind',
  'recovery',
  ARRAY['recovery', 'protein'],
  true,
  true,
  NULL,
  '/images/products/tailwind-recovery-mix/primary.jpg',
  '[]'::jsonb,
  NULL,
  NULL,
  NULL,
  0,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 13: KQM Recovery Mix
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'kqm-recovery-mix',
  'KQM Recovery Mix',
  'KQM:s standardformel för återhämtning med högt fruktosinnehåll och chokladsmak. Denna unika mix kombinerar kolhydrater och protein för snabb återhämtning med en mix av fyra prestationshöjande svampar: <strong>cordyceps</strong> (stöttar arbetskapacitet och tolerans för hård belastning), <strong>reishi</strong> (stöd för att varva ned när nervsystemet står på högvarv), <strong>lion''s mane</strong> (kognitivt stöd) och <strong>chaga</strong> (stöttar immunförsvaret). Perfekt för efter träning när du behöver både fysisk återhämtning och mental återställning. Läs mer om funktionella svampar för löpare i vår artikel: <a href="/zone-news/mushrooms-run-faster-jeremy-miller">Svamp som verktyg för löpare</a>.',
  249.00,
  'KQM',
  'recovery',
  ARRAY['recovery', 'protein'],
  true,
  true,
  NULL,
  '/images/products/kqm-recovery-mix/primary.jpg',
  '[]'::jsonb,
  NULL,
  NULL,
  NULL,
  0,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;

-- Product 14: KQM Custom Energy Gel
INSERT INTO products (id, name, description, price, brand, category, categories, in_stock, featured, inspiration_featured, image_url, additional_images, group_id, variant_type, variant_value, variant_sort, variants) VALUES
(
  'custom-gel',
  'KQM Custom Energy Gel',
  'Bygg din egen energigel. Anpassa kolhydratförhållande, elektrolyter, koffein och smak för att passa just dig och ditt pass eller lopp. Gelen är 1000ml och anpassad för att användas som refill tillsammans med våra mjuka gel-flaskor. Välj mellan olika kolhydratförhållanden (1:2, 0.8:1 eller 1:1), elektrolythalt (ingen, låg, måttlig eller hög), koffein, och om du önskar hydrogel och vilken smak du vill. Gelen är packeterad i återvinningsbar och återförslutningsbar mjuk PET-påse. Öppnad påse förvaras kyld och kan användas upp till 4 veckor efter öppnnande.',
  199.00,
  'KQM',
  'carbs',
  ARRAY['carbs', 'gels'],
  true,
  true,
  NULL,
  '/images/products/custom-gel/primary.jpg',
  '[]'::jsonb,
  NULL,
  NULL,
  NULL,
  0,
  NULL
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  category = EXCLUDED.category,
  categories = EXCLUDED.categories,
  in_stock = EXCLUDED.in_stock,
  featured = EXCLUDED.featured,
  inspiration_featured = EXCLUDED.inspiration_featured,
  image_url = EXCLUDED.image_url,
  additional_images = EXCLUDED.additional_images,
  group_id = EXCLUDED.group_id,
  variant_type = EXCLUDED.variant_type,
  variant_value = EXCLUDED.variant_value,
  variant_sort = EXCLUDED.variant_sort,
  variants = EXCLUDED.variants;


