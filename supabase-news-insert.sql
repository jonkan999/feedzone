-- Clear existing placeholder news
DELETE FROM news;

-- News Article 6: Näringsstrategi för uthållighet
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale, related_products) VALUES
(
  'hogt-kolhydratintag-langpass',
  'Högt kolhydratintag förbättrar dina långpass',
  'Upptäck varför kolhydrater är nyckeln till att orka längre på dina långpass – och vilka produkter som hjälper dig göra det i praktiken.',
  '<p>Det finns en anledning till att många av de bästa maraton- och ultralöparna pratar mer om gram per timme än om nya skor: bränsle styr slutet av passet. När kolhydraterna tar slut sjunker farten, steget blir tyngre och pulsen känns plötsligt “dyrare”. Därför har modern uthållighetsstrategi rört sig mot högre intag under längre pass – inte som en nödlösning, utan som en plan.</p><p>Fysiologin är rätt enkel: mer tillgängliga kolhydrater betyder att du kan hålla en högre arbetsintensitet längre. För långvariga lopp kan intag upp till cirka 90 g/h vara relevant, särskilt när du använder blandade kolhydratkällor (till exempel glukos + fruktos) för att öka upptaget och minska risken att magen sätter stopp. Rekommendationen att skala upp intaget vid längre tävlingar och att använda “multiple transportable carbohydrates” stöds både av IOC:s konsensus och av stora översiktsartiklar inom sportnutrition.</p><p>Det praktiska guldet: börja tidigt, mata jämnt och träna magen. Under pass över 2,5–3 timmar blir bränslestrategin ofta skillnaden mellan att “överleva” och att springa starkt hela vägen in. Ett enkelt upplägg är att använda en flexibel gelbas som <a href="/products/kqm-energy-gel-refill-1000ml">KQM Energy Gel Refill</a> i en mjuk flaska som <a href="/products/hydrapak-gel-soft-flask-250ml">HydraPak Gel Soft Flask 250ml</a> och komplettera med färdiga portionsgeler som <a href="/products/maurten-gel-100">Maurten Gel 100</a> när det behöver gå snabbt.</p><p>Källor: <a href="https://stillmed.olympic.org/media/Document%20Library/OlympicOrg/IOC/Who-We-Are/Commissions/Medical-and-Scientific-Commission/EN-IOC-Consensus-Statement-on-Sports-Nutrition-2010.pdf" target="_blank" rel="noopener noreferrer">IOC Consensus Statement on Sports Nutrition (2010)</a> · <a href="https://pubmed.ncbi.nlm.nih.gov/21660838/" target="_blank" rel="noopener noreferrer">Burke et al. 2011</a> · <a href="https://drugfreesport.org.za/wp-content/uploads/2018/04/Position-stand-on-Nutrition-Athletic-Performance-ACSM-2016-1.pdf" target="_blank" rel="noopener noreferrer">ACSM Nutrition & Athletic Performance (2016)</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC6852172/" target="_blank" rel="noopener noreferrer">Fuchs et al. 2019 (glukos+fruktos)</a>.</p>',
  'Bränsle',
  'Näring',
  '/images/news/hogt-kolhydratintag-langpass/primary.jpg',
  '/zone-news/hogt-kolhydratintag-langpass',
  true,
  '2025-12-31T00:00:00Z',
  false,
  '["kqm-energy-gel-refill-1000ml", "hydrapak-gel-soft-flask-250ml", "maurten-gel-100"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  excerpt = EXCLUDED.excerpt,
  body = EXCLUDED.body,
  badge_text = EXCLUDED.badge_text,
  category = EXCLUDED.category,
  image_url = EXCLUDED.image_url,
  article_url = EXCLUDED.article_url,
  featured = EXCLUDED.featured,
  published_at = EXCLUDED.published_at,
  grayscale = EXCLUDED.grayscale,
  related_products = EXCLUDED.related_products;
  
-- News Article 5: Prestationshöjande dryck
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale, related_products) VALUES
(
  'nomio-battre-prestation',
  'Nomio – broccoligroddar som förbättrar din prestation',
  'En svenskutvecklad sportdryck med extrakt från broccoligroddar vill flytta gränsen för när du stumnar. Här är vad forskningen säger – och vad du kan kombinera den med.',
  '<p>Nomio bygger på bioaktiva ämnen från broccoligroddar (glukosinolater/isotiocyanater) som kan påverka hur kroppen hanterar fysisk stress. I praktiken handlar det om att hålla ihop när intensiteten skruvas upp. Forskning i <em>Redox Biology</em> (2023) rapporterade att glukosinolat-rika broccoligroddar i kombination med hård träning sänkte laktatackumulering och minskade oxidativ stress jämfört med placebo.</p><p>Ta Nomio ca 2–3 timmar före hårda pass och kombinera med en lättdoserad energigel för toppar under passet. Ett enkelt upplägg: <a href="/products/nomio-itc-shot">Nomio ITC Shot</a> i förväg och fyll på med <a href="/products/kqm-energy-gel-refill-1000ml">KQM Energy Gel Refill</a> för jämn energi.</p><p>Källor: <a href="https://pubmed.ncbi.nlm.nih.gov/37688976/" target="_blank" rel="noopener noreferrer">Flockhart et al., Redox Biology (2023)</a> · <a href="https://gih.diva-portal.org/smash/record.jsf?pid=diva2%3A1797461" target="_blank" rel="noopener noreferrer">GIH DiVA (2023)</a> · <a href="https://www.idrottsforskning.se/klara-hard-traning-battre-med-broccoligroddar/" target="_blank" rel="noopener noreferrer">Idrottsforskning.se (2023)</a> · <a href="https://thefeed.com/insider/nomio-the-secret-powers-of-broccoli" target="_blank" rel="noopener noreferrer">The Feed Insider (2025)</a>.</p>',
  'Prestationshöjare',
  'Nyhet',
  '/images/news/nomio-battre-prestation/primary.jpg',
  '/zone-news/nomio-battre-prestation',
  true,
  '2025-12-26T00:00:00Z',
  false,
  '["nomio-itc-shot", "kqm-energy-gel-refill-1000ml"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  excerpt = EXCLUDED.excerpt,
  body = EXCLUDED.body,
  badge_text = EXCLUDED.badge_text,
  category = EXCLUDED.category,
  image_url = EXCLUDED.image_url,
  article_url = EXCLUDED.article_url,
  featured = EXCLUDED.featured,
  published_at = EXCLUDED.published_at,
  grayscale = EXCLUDED.grayscale,
  related_products = EXCLUDED.related_products;

-- News Article 7: Återhämtning & Näring
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale, related_products) VALUES
(
  'fruktos-aterhamtning',
  'Varför fruktos i återhämtningsdryck kan ge snabbare återhämtning',
  'Alla kolhydrater jobbar inte lika efter ett hårt pass. En fruktosrik recovery-mix kan fylla på leverglykogen snabbare och göra dig redo för nästa runda – särskilt när tiden är knapp.',
  '<p>Efter intervaller, långpass eller tävling vill du framför allt återställa glykogen. Men glykogen är inte bara "muskel": leverglykogen spelar stor roll för att stabilisera blodsocker och hålla energin jämn, särskilt när du ska träna igen inom 24 timmar. Det är här fruktos kommer in, eftersom fruktos i hög grad metaboliseras i levern och kan prioritera leverns återfyllnad.</p><p>Forskningen pekar tydligt på att glukos + fruktos (eller vanligt socker/sackaros som ger båda) kan öka leverglykogeninlagringen under återhämtning. En översikt i <em>Sports Medicine</em> (Gonzalez & Betts, 2017) beskriver att kombinationen glukos+fruktos "starkt" kan förbättra leverglykogenpåfyllnad efter träning. I en kontrollerad studie (Décombaz et al., 2011) var maltodextrindrycker med tillsatt fruktos (eller galaktos) ungefär dubbelt så effektiva som enbart glukos för att återställa leverglykogen på kort sikt.</p><p>Praktiskt: en återhämtningsmix med blandade kolhydrater (och protein) hjälper både lever och muskler – testa <a href="/products/kqm-recovery-mix">KQM Recovery Mix</a> eller <a href="/products/tailwind-recovery-mix">Tailwind Recovery Mix</a> för att fylla på snabbt.</p><p>Källor: <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC5409683/" target="_blank" rel="noopener noreferrer">Gonzalez & Betts (2017)</a> · <a href="https://pubmed.ncbi.nlm.nih.gov/21407126/" target="_blank" rel="noopener noreferrer">Décombaz et al. (2011)</a> · <a href="https://journals.physiology.org/doi/full/10.1152/jappl.1996.81.4.1495" target="_blank" rel="noopener noreferrer">J Appl Physiol (1996)</a>.</p>',
  'Snabb återhämtning',
  'Näring',
  '/images/news/fruktos-aterhamtning/primary.jpg',
  '/zone-news/fruktos-aterhamtning',
  true,
  '2026-01-01T00:00:00Z',
  true,
  '["kqm-recovery-mix", "tailwind-recovery-mix"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  excerpt = EXCLUDED.excerpt,
  body = EXCLUDED.body,
  badge_text = EXCLUDED.badge_text,
  category = EXCLUDED.category,
  image_url = EXCLUDED.image_url,
  article_url = EXCLUDED.article_url,
  featured = EXCLUDED.featured,
  published_at = EXCLUDED.published_at,
  grayscale = EXCLUDED.grayscale,
  related_products = EXCLUDED.related_products;

-- News Article 8: Race nutrition (based on Tara Dower transcript)
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale, related_products) VALUES
(
  'tara-dower-havalina-nutrition-insights',
  'Tara Dowers Javelina-formel: flytande carbs, regelbundna sippar och koffein',
  'Hon satte banrekord och gjorde det utan någon vidare dramatik. Receptet: 60–75 g kolhydrater i timmen, flytande gels i gel-flaskor, regelbunden vätska och en tydlig koffeinplan. Här är de viktigaste insikterna från intervjun.',
  '<p>Det som sticker ut direkt i Tara Dowers race report är inte ett magiskt supertrick – det är hur friktionsfritt allt är. Hon beskriver hur hon bytte till mer "flytande" energi (energigels) och gjorde det enklare att få i sig genom att fylla flera gels i en och samma gel-flaska, istället för att krångla med paket och ta en gel i taget. Resultatet: jämn energi, mindre mental belastning och mindre risk att du hoppar över intag när det blir stökigt. Hon landade på cirka 60–75 g kolhydrater per timme och kompletterade med kolhydratdryck – en nivå som matchar det vi vet om att regelbundet kolhydratintag stöttar prestation vid långvarig uthållighet, och att blandade kolhydratkällor (glukos+fruktos) ofta används för att öka upptaget när man vill skruva upp intaget.</p><p>För att implementera hennes strategi kan du använda färdiga portionsgeler som <a href="/products/maurten-gel-100">Maurten Gel 100</a> när det behöver gå snabbt, eller ännu bättre: använd en refill-gel som <a href="/products/kqm-energy-gel-refill-1000ml">KQM Energy Gel Refill 1000ml</a> i en mjuk flaska. Om du vill anpassa kolhydratförhållandet, elektrolyter eller koffein efter dina behov kan du <a href="/kqm-custom-energy-gel">skapa din egen personanpassade gel</a>. För praktisk användning rekommenderar vi <a href="/products/hydrapak-gel-soft-flask-250ml">HydraPak Gel Soft Flask 250ml</a> eller den kompaktare <a href="/products/hydrapak-gel-soft-flask-150ml">HydraPak Gel Soft Flask 150ml</a> – båda gör det enkelt att få i sig regelbundet utan att behöva stoppa och öppna paket.</p><p>Hennes vätskestrategi är lika "odramatisk" – och kanske därför så effektiv. Hon beskriver att hon bar två flaskor och sippade hela tiden, till och med med en liten ritual: varje gång hon passerade en annan löpare tog hon en liten sip. Det är exakt den typ av mikrobeteende som bygger volym utan att du behöver tänka. I värme och vid långa lopp blir planerad vätska ofta mer relevant än att bara hoppas på att törsten ska styra allt perfekt, och Tara kopplar dessutom vätska till intern kylning (dricka för att få ner kroppstemperaturen). Hon jobbade också med elektrolyter: kolhydratdryck plus saltpiller när hon kände att "lown" var på väg – en pragmatisk signalstyrd modell snarare än att överstyra allt med matematik.</p><p>Sen kommer sista kickern: koffeinet. Tara säger att hon tog runt 900 mg totalt och att hon knappt sov efteråt – ett kvitto på att det verkligen bet. Forskningen är tydlig med att koffein kan ge en liten men verklig prestationsfördel i uthållighet, ofta vid moderata doser (typ 3–6 mg/kg) – men "mer" är inte automatiskt "bättre", och biverkningar (mage, hjärta, sömn, oro) blir snabbt en faktor. Det smarta i hennes upplägg är inte siffran i sig, utan att koffein ligger som en senare växel: först salt, sen koffein om det behövs. Det är också en påminnelse till oss andra: bygg din plan på träning, testa i långpass, och använd koffein som ett extra verktyg. </p><p>Källor: <a href="https://www.youtube.com/watch?v=3fQSn3Jb_Ak" target="_blank" rel="noopener noreferrer">Intervjun (YouTube)</a> · <a href="https://pubmed.ncbi.nlm.nih.gov/21660838/" target="_blank" rel="noopener noreferrer">Burke et al. 2011</a> · <a href="https://link.springer.com/article/10.1007/s40279-014-0148-z" target="_blank" rel="noopener noreferrer">Jeukendrup 2014</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC5790864/" target="_blank" rel="noopener noreferrer">Kenefick 2018 (vätskestrategier)</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC8955583/" target="_blank" rel="noopener noreferrer">Veniamakis 2022 (natrium i uthållighet)</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC7777221/" target="_blank" rel="noopener noreferrer">ISSN Position Stand: Caffeine (2021)</a>.</p>',
  'Race-day fuel',
  'Näring',
  'https://www.youtube.com/watch?v=3fQSn3Jb_Ak',
  '/zone-news/tara-dower-havalina-nutrition-insights',
  true,
  '2026-01-08T00:00:00Z',
  false,
  '["kqm-energy-gel-refill-1000ml", "hydrapak-gel-soft-flask-250ml", "hydrapak-gel-soft-flask-150ml", "maurten-gel-100"]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  excerpt = EXCLUDED.excerpt,
  body = EXCLUDED.body,
  badge_text = EXCLUDED.badge_text,
  category = EXCLUDED.category,
  image_url = EXCLUDED.image_url,
  article_url = EXCLUDED.article_url,
  featured = EXCLUDED.featured,
  published_at = EXCLUDED.published_at,
  grayscale = EXCLUDED.grayscale,
  related_products = EXCLUDED.related_products;
