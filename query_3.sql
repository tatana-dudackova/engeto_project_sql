SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;

SELECT DISTINCT category_code,(((vyse_cen_prev_year/vyse_cen)*100)-100) AS procentualni_zmena_ceny,rok,ctvrtleti,mesic,tyden
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
WHERE ((vyse_cen_prev_year/vyse_cen)*100 -100) IS NOT NULL AND ((vyse_cen_prev_year/vyse_cen)*100 -100) > 0
ORDER BY procentualni_zmena_ceny
LIMIT 1;

-- tohle je nejaky divny :( - jeste promyslet tu granularitu, ktera mi tam zustala z tabulky czechia price
-- jinak jsem ale vybrala prislusne sloupce, podminka, ze to musi byt vetsi nez nula znamena, ze to zbozi vubec zdrazuje, pri zapornych hodnotach to zbozi zlevnuje
-- jeste by asi chtelo presne zjistit nazev polozky
