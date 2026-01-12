-- Clear existing placeholder news
DELETE FROM news;

-- News Article 6: Näringsstrategi för uthållighet
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale, related_products) VALUES
(
  'hogt-kolhydratintag-langpass',
  'Högt kolhydratintag förbättrar dina långpass',
  'Upptäck varför kolhydrater är nyckeln till att orka längre på dina långpass – och vilka produkter som hjälper dig göra det i praktiken.',
  '<p>Det finns en anledning till att många av de bästa maraton- och ultralöparna pratar mer om gram per timme än om nya skor: bränsle styr slutet av passet. När kolhydraterna tar slut sjunker farten, steget blir tyngre och pulsen känns plötsligt “dyrare”. Därför har modern uthållighetsstrategi rört sig mot högre intag under längre pass – inte som en nödlösning, utan som en plan.</p><p>Fysiologin är rätt enkel: mer tillgängliga kolhydrater betyder att du kan hålla en högre arbetsintensitet längre. För långvariga lopp kan intag upp till cirka 90 g/h vara relevant, särskilt när du använder blandade kolhydratkällor (till exempel glukos + fruktos) för att öka upptaget och minska risken att magen sätter stopp. Rekommendationen att skala upp intaget vid längre tävlingar och att använda “multiple transportable carbohydrates” stöds både av IOC:s konsensus och av stora översiktsartiklar inom sportnutrition.</p><p>Det praktiska guldet: börja tidigt, mata jämnt och träna magen. Under pass över 2,5–3 timmar blir bränslestrategin ofta skillnaden mellan att “överleva” och att springa starkt hela vägen in. Ett enkelt upplägg är att använda en flexibel gelbas som <a href="/products/kqm-energy-gel-1000ml">KQM Energy Gel Refill</a> i en mjuk flaska som <a href="/products/hydrapak-gel-soft-flask-250ml">HydraPak Gel Soft Flask 250ml</a> och komplettera med färdiga portionsgeler som <a href="/products/maurten-gel-100">Maurten Gel 100</a> när det behöver gå snabbt.</p><p>Källor: <a href="https://stillmed.olympic.org/media/Document%20Library/OlympicOrg/IOC/Who-We-Are/Commissions/Medical-and-Scientific-Commission/EN-IOC-Consensus-Statement-on-Sports-Nutrition-2010.pdf" target="_blank" rel="noopener noreferrer">IOC Consensus Statement on Sports Nutrition (2010)</a> · <a href="https://pubmed.ncbi.nlm.nih.gov/21660838/" target="_blank" rel="noopener noreferrer">Burke et al. 2011</a> · <a href="https://drugfreesport.org.za/wp-content/uploads/2018/04/Position-stand-on-Nutrition-Athletic-Performance-ACSM-2016-1.pdf" target="_blank" rel="noopener noreferrer">ACSM Nutrition & Athletic Performance (2016)</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC6852172/" target="_blank" rel="noopener noreferrer">Fuchs et al. 2019 (glukos+fruktos)</a>.</p>',
  'Bränsle',
  'Näring',
  '/images/news/hogt-kolhydratintag-langpass/primary.jpg',
  '/zone-news/hogt-kolhydratintag-langpass',
  true,
  '2025-12-31T00:00:00Z',
  false,
  '["kqm-energy-gel-1000ml", "hydrapak-gel-soft-flask-250ml", "maurten-gel-100"]'::jsonb
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
  '<p>Nomio bygger på bioaktiva ämnen från broccoligroddar (glukosinolater/isotiocyanater) som kan påverka hur kroppen hanterar fysisk stress. I praktiken handlar det om att hålla ihop när intensiteten skruvas upp. Forskning i <em>Redox Biology</em> (2023) rapporterade att glukosinolat-rika broccoligroddar i kombination med hård träning sänkte laktatackumulering och minskade oxidativ stress jämfört med placebo.</p><p>Ta Nomio ca 2–3 timmar före hårda pass och kombinera med en lättdoserad energigel för toppar under passet. Ett enkelt upplägg: <a href="/products/nomio-itc-shot">Nomio ITC Shot</a> i förväg och fyll på med <a href="/products/kqm-energy-gel-1000ml">KQM Energy Gel Refill</a> för jämn energi.</p><p>Källor: <a href="https://pubmed.ncbi.nlm.nih.gov/37688976/" target="_blank" rel="noopener noreferrer">Flockhart et al., Redox Biology (2023)</a> · <a href="https://gih.diva-portal.org/smash/record.jsf?pid=diva2%3A1797461" target="_blank" rel="noopener noreferrer">GIH DiVA (2023)</a> · <a href="https://www.idrottsforskning.se/klara-hard-traning-battre-med-broccoligroddar/" target="_blank" rel="noopener noreferrer">Idrottsforskning.se (2023)</a> · <a href="https://thefeed.com/insider/nomio-the-secret-powers-of-broccoli" target="_blank" rel="noopener noreferrer">The Feed Insider (2025)</a>.</p>',
  'Prestationshöjare',
  'Nyhet',
  '/images/news/nomio-battre-prestation/primary.jpg',
  '/zone-news/nomio-battre-prestation',
  true,
  '2025-12-26T00:00:00Z',
  false,
  '["nomio-itc-shot", "kqm-energy-gel-1000ml"]'::jsonb
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
  '<p>Det som sticker ut direkt i Tara Dowers race report är inte ett magiskt supertrick – det är hur friktionsfritt allt är. Hon beskriver hur hon bytte till mer "flytande" energi (energigels) och gjorde det enklare att få i sig genom att fylla flera gels i en och samma gel-flaska, istället för att krångla med paket och ta en gel i taget. Resultatet: jämn energi, mindre mental belastning och mindre risk att du hoppar över intag när det blir stökigt. Hon landade på cirka 60–75 g kolhydrater per timme och kompletterade med kolhydratdryck – en nivå som matchar det vi vet om att regelbundet kolhydratintag stöttar prestation vid långvarig uthållighet, och att blandade kolhydratkällor (glukos+fruktos) ofta används för att öka upptaget när man vill skruva upp intaget.</p><p>För att implementera hennes strategi kan du använda färdiga portionsgeler som <a href="/products/maurten-gel-100">Maurten Gel 100</a> när det behöver gå snabbt, eller ännu bättre: använd en refill-gel som <a href="/products/kqm-energy-gel-1000ml">KQM Energy Gel Refill 1000ml</a> i en mjuk flaska. Om du vill anpassa kolhydratförhållandet, elektrolyter eller koffein efter dina behov kan du <a href="/kqm-custom-energy-gel">skapa din egen personanpassade gel</a>. För praktisk användning rekommenderar vi <a href="/products/hydrapak-gel-soft-flask-250ml">HydraPak Gel Soft Flask 250ml</a> eller den kompaktare <a href="/products/hydrapak-gel-soft-flask-150ml">HydraPak Gel Soft Flask 150ml</a> – båda gör det enkelt att få i sig regelbundet utan att behöva stoppa och öppna paket.</p><p>Hennes vätskestrategi är lika "odramatisk" – och kanske därför så effektiv. Hon beskriver att hon bar två flaskor och sippade hela tiden, till och med med en liten ritual: varje gång hon passerade en annan löpare tog hon en liten sip. Det är exakt den typ av mikrobeteende som bygger volym utan att du behöver tänka. I värme och vid långa lopp blir planerad vätska ofta mer relevant än att bara hoppas på att törsten ska styra allt perfekt, och Tara kopplar dessutom vätska till intern kylning (dricka för att få ner kroppstemperaturen). Hon jobbade också med elektrolyter: kolhydratdryck plus saltpiller när hon kände att "lown" var på väg – en pragmatisk signalstyrd modell snarare än att överstyra allt med matematik.</p><p>Sen kommer sista kickern: koffeinet. Tara säger att hon tog runt 900 mg totalt och att hon knappt sov efteråt – ett kvitto på att det verkligen bet. Forskningen är tydlig med att koffein kan ge en liten men verklig prestationsfördel i uthållighet, ofta vid moderata doser (typ 3–6 mg/kg) – men "mer" är inte automatiskt "bättre", och biverkningar (mage, hjärta, sömn, oro) blir snabbt en faktor. Det smarta i hennes upplägg är inte siffran i sig, utan att koffein ligger som en senare växel: först salt, sen koffein om det behövs. Det är också en påminnelse till oss andra: bygg din plan på träning, testa i långpass, och använd koffein som ett extra verktyg. </p><p>Källor: <a href="https://www.youtube.com/watch?v=3fQSn3Jb_Ak" target="_blank" rel="noopener noreferrer">Intervjun (YouTube)</a> · <a href="https://pubmed.ncbi.nlm.nih.gov/21660838/" target="_blank" rel="noopener noreferrer">Burke et al. 2011</a> · <a href="https://link.springer.com/article/10.1007/s40279-014-0148-z" target="_blank" rel="noopener noreferrer">Jeukendrup 2014</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC5790864/" target="_blank" rel="noopener noreferrer">Kenefick 2018 (vätskestrategier)</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC8955583/" target="_blank" rel="noopener noreferrer">Veniamakis 2022 (natrium i uthållighet)</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC7777221/" target="_blank" rel="noopener noreferrer">ISSN Position Stand: Caffeine (2021)</a>.</p>',
  'Race-day fuel',
  'Näring',
  'https://www.youtube.com/watch?v=3fQSn3Jb_Ak',
  '/zone-news/tara-dower-havalina-nutrition-insights',
  true,
  '2026-01-08T00:00:00Z',
  false,
  '["kqm-energy-gel-1000ml", "hydrapak-gel-soft-flask-250ml", "hydrapak-gel-soft-flask-150ml", "maurten-gel-100"]'::jsonb
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

-- News Article 9: Adaptogens & mushrooms for runners (based on podcast transcript)
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale, related_products) VALUES
(
  'mushrooms-run-faster-jeremy-miller',
  'Svamp som verktyg för löpare: mindre brus, mer tryck',
  'I Jeremy Miller Podcast pratar Danielle Ryan Dawson om varför funktionella svampar blivit en seriös snackis bland uthållighetsidrottare: inte som magi, utan som en smart bas för avkoppling, återhämtning och prestation.',
  '<p>Det som gör samtalet intressant är att det inte säljs in som en "hack-lista" utan som ett system: <strong>defend, perform, restore</strong>. Poängen är enkel: du kan inte maxa prestation utan att först ha en kropp som faktiskt orkar ta emot träningen. Danielle beskriver hur många av hennes klienter fastnat i ett läge där vården inte hittar en tydlig diagnos, men där kroppen ändå signalerar att något skaver. Där blir tarmen och immunbalansen central (hon nämner att en stor del av immunförsvarets celler finns i tarmen, vilket stöds av översikter inom området), och tanken är att en stabil bas gör det lättare att "show up" som din bästa version – både i vardagen och på passet. Källor: <a href="https://www.youtube.com/watch?v=cycvd-h2oi4" target="_blank" rel="noopener noreferrer">YouTube-avsnittet</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC8001875/" target="_blank" rel="noopener noreferrer">Wiertsema et al. 2021 (70–80% av immunceller i tarmen)</a>.</p><p>För löpare är <strong>performance</strong>-delen den mest "känn"-bara. I avsnittet lyfts cordyceps som den klassiska prestationssvampen – inte för att den ersätter träning, utan för att den kan stötta arbetskapacitet och tolerans för hård belastning. Det finns studier på människor som visat förbättringar i träningsrelaterade utfall efter några veckor av cordyceps-tillskott i vissa grupper, och annan forskning som kopplar cordyceps till mekanismer som kan vara relevanta för uthållighet (till exempel syreutnyttjande och återhämtning). Senare undersökningar har även undersökt effekter på återhämtning efter träningsinducerad muskelskada. Det här är inte en garanti för alla, men det är precis därför upplägget som presenteras i podden landar i att: testa, mät, och håll det praktiskt. Källor: <a href="https://www.youtube.com/watch?v=cycvd-h2oi4" target="_blank" rel="noopener noreferrer">YouTube-avsnittet</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC3110835/" target="_blank" rel="noopener noreferrer">Chen et al. 2010 (dubbelblind studie, Cs-4)</a> · <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC5236007/" target="_blank" rel="noopener noreferrer">Hirsch et al. 2016 (cordyceps militaris, prestation/tolerans)</a> · <a href="https://pubs.rsc.org/en/content/articlehtml/2024/fo/d3fo03770c" target="_blank" rel="noopener noreferrer">Dewi et al. 2024 (human evidens, muskelåterhämtning)</a>.</p><p>Den mest användbara delen för den som vill börja är nästan shopping-checklistan: För <strong>recovery</strong> nämns reishi som en återhämtningskompis – inte som sömnpiller, utan som ett stöd för att varva ned när nervsystemet står på högvarv. Samma grej här: bygg rutinen så att du faktiskt tar det. Svamp som du glömmer i skafferiet ger exakt noll procent bättre löpning.</p><p>Praktiskt: för att kombinera svamparnas fördelar med återhämtning efter träning, testa <a href="/products/kqm-recovery-mix">KQM Recovery Mix</a> som är berikad med en mix av fyra prestationshöjande svampar (cordyceps, reishi, lions mane och chaga). Den kombinerar återhämtningskolhydrater och protein med adaptogena svampar för att stödja både fysisk återhämtning och mental återställning efter hårda pass.</p><p>Källor: <a href="https://www.youtube.com/watch?v=cycvd-h2oi4" target="_blank" rel="noopener noreferrer">YouTube-avsnittet</a> · <a href="https://open.spotify.com/episode/61qggupj4CjNKl49SHsMXM" target="_blank" rel="noopener noreferrer">Spotify-episoden</a> · <a href="https://www.danielleryanwellness.com/" target="_blank" rel="noopener noreferrer">Danielle Ryan Wellness</a>.</p>',
  'Adaptogen guide',
  'Näring',
  'https://www.youtube.com/watch?v=cycvd-h2oi4',
  '/zone-news/mushrooms-run-faster-jeremy-miller',
  true,
  '2026-12-08T00:00:00Z',
  false,
  '["kqm-recovery-mix"]'::jsonb
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


-- News Article: Kosttillskott som faktiskt kan flytta nålen (för löpning/kondition)
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale) VALUES
(
  'kosttillskott-som-funkar-lopning',
  'Fem kosttillskott som faktiskt kan förbättra din prestation (och vad som mest är hype)',
  'Marknaden är full av “mirakelburkar”, men när man skalar bort brus och marknadsföring återstår bara ett fåtal tillskott med robust stöd. Här är fem som forskningen återkommer till – och hur de kan passa dig som löptränar.',
  '<p>Det första som ofta glöms bort: tillskott är inte grunden – de är finjusteringen. Idrottsforskning.se sammanfattar det krasst: träning, vanlig mat och återhämtning betyder mer än alla prestationspulver tillsammans. Men om du jagar de där sista procenten finns det en shortlist som gång på gång dyker upp i evidensen: koffein, kreatin, nitrat, beta-alanin och bikarbonat. Det här är samma “topp fem” som lyfts i <a href="https://www.idrottsforskning.se/fem-kosttillskott-som-forbattrar-prestationsformagan/">Idrottsforskning.se</a> och i IOK:s konsensusrapport om kosttillskott för högpresterande idrottare (<a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC5867441/">IOC consensus statement</a>).</p><p>För löpare är koffein ofta den tydligaste “pang-effekten”: ungefär 3–6 mg per kilo kroppsvikt cirka 60 minuter före pass/lopp är ett vanligt upplägg, och högre doser ger sällan mer prestation – bara mer biverkningar. (Det stöds både av Idrottsforskning.se och IOC-konsensusen.) Nitro (ofta via rödbetsjuice) kan hjälpa i hårda block och relativt korta, intensiva uthållighetsinsatser – tänk tempo/VO2-pass och intensiva race-segment – medan beta-alanin och bikarbonat framför allt spelar i zonen där det bränner: hög intensitet från cirka 30 sekunder upp till några minuter, där buffring av “surhet” kan göra att du kan hålla trycket längre. Kreatin är mer känt för styrka/sprint, men kan ändå vara relevant för löpare som vill förbättra återkommande hårda insatser, styrketräning och “stuns” (och i vissa fall även återhämtning) (<a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC5867441/">IOC consensus statement</a>).</p><p>Men: marginalnytta kräver marginaldisciplin. Två av de fem (nitrat och bikarbonat) kan ge magstrul – och det kan sabba ett lopp snabbare än vilket tillskott som helst kan rädda det. Testa därför alltid i träning, i rätt intensitet och gärna med “tävlingslika” nerver. Och glöm inte riskerna som Idrottsforskning.se också flaggar för: kosttillskott kan vara kontaminerade och därmed innebära både hälso- och dopningsrisk, särskilt i produkter som marknadsförs för “energi”, “fettförbränning” eller “hormonboost” (<a href="https://www.idrottsforskning.se/fem-kosttillskott-som-forbattrar-prestationsformagan/">Idrottsforskning.se</a>). Kort sagt: välj få, välj rätt, välj testat – och låt sömn, mat och kontinuitet vara din riktiga superkraft.</p>',
  'Evidens',
  'Träning',
  '/images/news/kosttillskott-som-funkar-lopning/primary.jpg',
  '/zone-news/kosttillskott-som-funkar-lopning',
  true,
  '2026-01-15T00:00:00Z',
  false
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
  grayscale = EXCLUDED.grayscale;

  -- News Article 10: Nomio deep dive + testprotokoll (based on podcast transcript)
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale, related_products) VALUES
(
  'nomio-protokoll-nrf2-laktat',
  'Nomio, laktat och Nrf2: vad säger fysiologen – och hur testar du själv?',
  'De där små gröna shotsen syns överallt i proffscyklingen. Men är det “hype” eller en faktisk edge? Här är det som sägs i podden – plus ett konkret ABAB-protokoll för att se om Nomio funkar på dig.',
  '<p>Du har säkert sett dem: små gröna flaskor i stories från WorldTour-åkare. Snacket är att de hjälper dig ta i lite mer med samma ansträgning – och att laktatackumuleringen blir lägre vid samma belastning. I det här avsnittet går man rakt på sak med fysiologen bakom Nomio, Dr. Philip Larsen, för att reda ut vad som faktiskt är påståendet och hur det ska testas i verkligheten.</p>

  <div style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;border-radius:16px;margin:18px 0;">
    <iframe src="https://www.youtube.com/embed/cycvd-h2oi4" title="Nomio – science & test protocol" style="position:absolute;top:0;left:0;width:100%;height:100%;border:0;" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
  </div>

  <p><strong>Vad är Nomio?</strong> En stabiliserad shot baserad på extrakt från broccoligroddar (isotiocyanater), blandat med citrus och lite socker. Larsen beskriver att isotiocyanater är kopplade till en signalväg i kroppen som kallas <strong>Nrf2</strong> – ofta beskriven som en “master regulator” för kroppens antioxidativa försvar och stressrespons. Enkelt uttryckt: när Nrf2 “slås på” triggas en rad processer som hjälper kroppen hantera belastning och oxidativ stress. I podden är poängen inte att vi kan allt om mekanismen, utan att effekten i deras studier dykt upp som en praktisk prestationssignal: <em>lägre laktat vid samma arbete</em> och en känsla hos många deltagare att hårda block varit lättare att “absorbera”.</p>

  <p><strong>Mer är inte bättre.</strong> En av de mest intressanta takeaways i samtalet är att de sett en <em>optimal dos</em> i labbtest: en shot verkade ge bättre respons än två. Alltså: du vinner inte på att “dubbla bara för säkerhets skull”. Och tajmingen de pratar om är tydlig: <strong>cirka 3 timmar före</strong> hårt pass, när nivåerna i blodet peakar.</p>

  <p><strong>Det som gör det relevant för dig:</strong> Larsen återkommer till att detta verkar vara mest intressant när du <em>verkligen</em> stressar systemet – hårda pass, back-to-back, när återhämtningen faktiskt blir en begränsning. Tar du en shot och rullar två timmar lugnt? Då är det inte säkert att du känner något alls. Det här är en “edge” som ska synas när du pressar – inte när du joggar runt.</p>

  <p><strong>Så testar du själv: ABAB-protokollet (enkelt men brutalt)</strong><br/>
  Målet är att reducera brus (mat, sömn, tid på dygnet) och se om det finns en repeterbar skillnad.</p>

  <ul>
    <li><strong>Välj ett pass du kan standardisera.</strong> Exempel: <em>4×4 min VO2</em> eller annan hård intervall du kan köra “likadant” flera gånger.</li>
    <li><strong>Kör två hårda dagar i rad</strong> (back-to-back) för att utmana återhämtningen – där effekten enligt podden borde synas bäst.</li>
    <li><strong>Nomio-block (A):</strong> 1 shot <strong>3 timmar före</strong> passet + 1 shot <strong>innan läggdags</strong> (båda dagarna).</li>
    <li><strong>Placebo-/utan-block (B):</strong> gör exakt samma upplägg – men utan Nomio.</li>
    <li><strong>Washout:</strong> vila/normal vecka (eller två) mellan blocken så att du inte bara blir “bättre tränad” av första blocket.</li>
    <li><strong>Mät det du redan mäter:</strong> effekt/pace, puls, RPE, morgonpuls, HRV och sömn. Och skriv <em>notes</em> (stress, jobbdag, mat, mage).</li>
  </ul>

  <p><strong>En viktig brasklapp:</strong> Det här är exakt varför “N=1” är svårt – och exakt därför det är värt att göra ordentligt. Om du inte kontrollerar frukost, tidpunkt, koffein och stressnivå kan du alltid hitta en annan förklaring. Men om samma signal dyker upp flera gånger i ett ABAB-upplägg? Då har du plötsligt något som är <em>praktiskt</em> sant för dig.</p>

  <p>Vill du prova på riktigt: kör <a href="/products/nomio-itc-shot">Nomio ITC Shot</a> enligt protokollet ovan och gör det du redan vet är skillnaden mellan “snack” och resultat: testa i träning, inte på tävlingsdagen.</p>',
  'Testprotokoll',
  'Nyhet',
  '/images/news/nomio-protokoll-nrf2-laktat/primary.jpg',
  '/zone-news/nomio-protokoll-nrf2-laktat',
  true,
  '2026-01-22T00:00:00Z',
  false,
  '["nomio-itc-shot"]'::jsonb
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

-- News Article: Norska “singles”-upplägget (tröskel – men utan dubbelpass)
INSERT INTO news (id, title, excerpt, body, badge_text, category, image_url, article_url, featured, published_at, grayscale) VALUES
(
  'norska-singles-traskel',
  'Norska “singles”: tröskelträning som faktiskt går att leva med',
  'Du har hört om norrmännens dubbeltröskel. “Singles”-varianten är samma tänk – laktatkontroll, hög kvalitet och mycket lugnt runtom – men nedskalat till ett pass åt gången.',
  '<p>“Den norska modellen” har blivit ett meme. Alla pratar dubbeltröskel (två tröskelpass samma dag), Ingebrigtsen och laktatmätare. Men i praktiken är det <strong>singles</strong> som är den användbara idén för de flesta: ett <em>enda</em> tröskelpass åt gången, utfört på norskt sätt – dvs. <strong>kontrollerat, repeterbart och konsekvent</strong>, med mycket lågintensivt runtom.</p>

  <p>För att förstå varför singles funkar behöver du bara fatta en sak: norrmännen är inte besatta av att “gå i taket” – de är besatta av att <strong>kunna göra ett starkt pass igen om 24–48 timmar</strong>. Därför ligger tröskelpass ofta i en zon där laktat hålls relativt lågt och stabilt (i litteraturen beskrivs ofta ungefär 2–4,5 mmol/L beroende på upplägg och nivå), och volymen byggs via intervaller istället för ett långt “hänga-på-gränsen”-pass. :contentReference[oaicite:0]{index=0}</p>

  <p><strong>Så vad är “Norwegian singles”?</strong><br/>
  Det är inte en officiell term i forskningen – det är en modern, nedskalad tolkning: <strong>du gör ett tröskelpass per dag (singel)</strong>, men behåller principerna som gör norska upplägg smarta: laktat/effort-kontroll, hög total volym på låg intensitet och tydlig separation mellan hårt och lätt. Det är också exakt därför dubbeltröskel beskrivs som en <em>specifik</em> strategi för väldigt tränade atleter med enorm återhämtningskapacitet – singles ger samma motorbygge utan att spränga vardagen. :contentReference[oaicite:1]{index=1}</p>

  <p><strong>Nyckelprinciper (som gör skillnad direkt)</strong></p>
  <p><strong>1) Tröskel ska kännas “kontrollerat hårt”, inte panik</strong><br/>
  Om varje tröskelpass slutar i att du stapplar hem med syra i själen är du inte i norskt land – du är i “gråzon varje dag”-land. I norska passmodeller betonas ofta att intensiteten hålls under kontroll för att kunna stapla kvalitet över tid. :contentReference[oaicite:2]{index=2}</p>

  <p><strong>2) Intervaller > kontinuerligt</strong><br/>
  Många norska tröskelpass byggs som längre intervaller med kort vila, just för att hålla ett jämnt metabolic “tryck” utan att det glider iväg. Studier på vältränade löpare visar att laktatstyrda tröskelintervaller kan ge tydliga prestationsförbättringar över veckor – poängen är att det går att göra <em>mycket</em> tröskel utan att varje pass blir ett testlopp. :contentReference[oaicite:3]{index=3}</p>

  <p><strong>3) 80/20 är fortfarande grundplattan</strong><br/>
  Det norska är inte “tröskel hela tiden”. Elitdata från uthållighetsidrotter visar ofta en stor bas av lågintensiv träning och en mindre del högintensivt – det är den här separationen som gör att tröskelpassen kan vara vassa utan att du går sönder. :contentReference[oaicite:4]{index=4}</p>

  <p><strong>Hur gör man i praktiken?</strong></p>
  <p><strong>Singles-pass 1 (löpning):</strong> 5–8 × 6 min @ tröskelkänsla, 60–90 sek joggvila.<br/>
  <strong>Singles-pass 2 (cykel):</strong> 4–6 × 8 min @ tröskel, 2 min lätt tramp.<br/>
  <strong>Alternativ (klassiker):</strong> 3–4 × 10 min @ tröskel, 2 min vila.</p>

  <p><strong>Utan laktatmätare:</strong><br/>
  – Håll dig på en intensitet där du kan säga korta fraser (inte prata i meningar, men heller inte hyperventilera).<br/>
  – Pulsen ska stabiliseras (inte drifta upp till “race”).<br/>
  – Du ska kunna göra samma pass nästa vecka och bli lite bättre, inte behöva “överleva”.</p>

  <p><strong>Veckostruktur som funkar för vanliga liv</strong><br/>
  – 1–2 tröskel-singles/vecka i början.<br/>
  – 1 hårt pass/vecka (VO2/banintervaller) om du tål det.<br/>
  – Resten lugnt. Verkligen lugnt.<br/>
  När du har byggt tålighet kan du gå till 2–3 tröskelpass/vecka (men då måste lättvolymen och sömnen sitta). Poängen med singles är att du kan vara ambitiös utan att behöva vara proffs med två vilopass och nap-time mellan frukost och lunch.</p>

  <p><strong>Vanliga misstag (som sabbar hela idén)</strong><br/>
  1) Du gör tröskel för hårt → det blir “tempo-race” och återhämtningen kollapsar.<br/>
  2) Du gör för många trösklar men för lite lugnt → du tappar separationen, allt blir mellanmjölk.<br/>
  3) Du “jagar siffror” → tröskel är ett träningsverktyg, inte en identitet.</p>

  <p><strong>Bottom line:</strong> Norska singles är inte magi. Det är disciplin: <strong>kontrollerad tröskel + mycket lätt + konsekvens</strong>. Gör det i 8–12 veckor och du kommer märka att det som tidigare var “tempo” plötsligt känns… normalt.</p>

  <p>Källor: <a href="https://pmc.ncbi.nlm.nih.gov/articles/PMC11560996/" target="_blank" rel="noopener noreferrer">Tønnessen et al. (2024) – Training Session Models for Middle- and Long-Distance Running</a> · <a href="https://pubmed.ncbi.nlm.nih.gov/37220014/" target="_blank" rel="noopener noreferrer">Casado et al. (2023) – Laktatstyrd tröskelträning hos vältränade löpare</a> · <a href="https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0101796" target="_blank" rel="noopener noreferrer">Tønnessen et al. (2014) – träningens volym/intensitetsfördelning i uthållighetseliten</a> · <a href="https://www.mdpi.com/2075-4663/12/6/154" target="_blank" rel="noopener noreferrer">Översikt om dubbeltröskel och norska upplägg (2024)</a>.</p>',
  'Tröskel',
  'Träning',
  '/images/news/norska-singles-traskel/primary.jpg',
  '/zone-news/norska-singles-traskel',
  true,
  '2026-01-29T00:00:00Z',
  false
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
  grayscale = EXCLUDED.grayscale;