SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;


-- FINALNI DOTAZ - dve varianty, na zaklade obou jsem ale dosla ke stejnemu zaveru, tak tady nechavam pro jistotu obe
-- VARIANTA A

SELECT DISTINCT category_code,(((vyse_cen/vyse_cen_prev_year)*100)-100) AS procentualni_zmena_ceny,rok
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
WHERE ((vyse_cen/vyse_cen_prev_year)*100 -100) IS NOT NULL AND ((vyse_cen/vyse_cen_prev_year)*100 -100) > 0
ORDER BY procentualni_zmena_ceny
LIMIT 1;


-- jeste idealne prijoinovat nazvy polozek
-- jinak jsem ale vybrala prislusne sloupce, podminka, ze to musi byt vetsi nez nula znamena, ze to zbozi vubec zdrazuje, pri zapornych hodnotach to zbozi zlevnuje
-- mozna nevypisovat uplne vsechny sloupce???

-- VARIANTA B

SELECT DISTINCT category_code, min((((vyse_cen/vyse_cen_prev_year)*100)-100)) AS minimalni_procentualni_zmena_ceny,rok 
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
WHERE ((vyse_cen/vyse_cen_prev_year)*100 -100) IS NOT NULL AND ((vyse_cen/vyse_cen_prev_year)*100 -100) > 0
GROUP BY category_code,rok 
ORDER BY minimalni_procentualni_zmena_ceny; -- asi vyslo stejne, jako pomoci dotazu viz vyse
