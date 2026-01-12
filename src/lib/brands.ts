export type BrandInfo = {
  slug: string;
  name: string;
  brandKey: string;
  logo: string;
  hero: string;
  description: string;
};

export const brands: BrandInfo[] = [
  {
    slug: 'kqm',
    name: 'KQM',
    brandKey: 'KQM',
    logo: '/images/brands/kqm/logo.jpg',
    hero: '/images/brands/kqm/hero.jpg',
    description:
      'Skräddarsydda energigeler och återhämtningsmixar utvecklade för löpare som vill styra kolhydratförhållande, elektrolyter och koffein efter sina lopp och pass.',
  },
  {
    slug: 'maurten',
    name: 'Maurten',
    brandKey: 'Maurten',
    logo: '/images/brands/maurten/logo.jpg',
    hero: '/images/brands/maurten/hero.jpg',
    description:
      'Hydrogel-baserade gels och drink mixes som levererar snabba kolhydrater med minimal risk för magen vid hög fart, perfekta för långlopp och race.',
  },
  {
    slug: 'hydrapak',
    name: 'HydraPak',
    brandKey: 'HydraPak',
    logo: '/images/brands/hydrapak/logo.jpg',
    hero: '/images/brands/hydrapak/hero.jpg',
    description:
      'Mjukflaskor och vätskesystem som gör det enkelt att bära energi under löpning och trail – smidigt, komprimerbart och byggt för tuffa förhållanden.',
  },
  {
    slug: 'tailwind',
    name: 'Tailwind',
    brandKey: 'Tailwind',
    logo: '/images/brands/tailwind/logo.jpg',
    hero: '/images/brands/tailwind/hero.jpg',
    description:
      'Enkla och rena drink mixes samt recovery som ger kolhydrater, elektrolyter och protein i ett steg – lätt att blanda, lätt för magen, lätt att använda under långa pass.',
  },
  {
    slug: 'nomio',
    name: 'Nomio',
    brandKey: 'Nomio',
    logo: '/images/brands/nomio/logo.jpg',
    hero: '/images/brands/nomio/hero.jpg',
    description:
      'Svenskutvecklad ITC-shot från broccoligroddar, framtagen för att sänka laktat och förbättra återhämtning före hårda träningspass.',
  },
];

export const findBrandBySlug = (slug?: string | null) =>
  slug ? brands.find((brand) => brand.slug === slug.toLowerCase()) : undefined;

