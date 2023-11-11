-- FINALNI DOTAZ - dve varianty, obe vedou ke stejnemu zaveru
-- VARIANTA A
SELECT DISTINCT nazev_zbozi,(((vyse_cen/vyse_cen_prev_year)*100)-100) AS procentualni_zmena_ceny,rok
FROM t_tatana_dudackova_project_sql_primary_final
WHERE ((vyse_cen/vyse_cen_prev_year)*100 -100) IS NOT NULL AND ((vyse_cen/vyse_cen_prev_year)*100 -100) > 0
ORDER BY procentualni_zmena_ceny
LIMIT 1;

-- VARIANTA B

SELECT DISTINCT nazev_zbozi, min((((vyse_cen/vyse_cen_prev_year)*100)-100)) AS minimalni_procentualni_zmena_ceny,rok 
FROM t_tatana_dudackova_project_sql_primary_final
WHERE ((vyse_cen/vyse_cen_prev_year)*100 -100) IS NOT NULL AND ((vyse_cen/vyse_cen_prev_year)*100 -100) > 0
GROUP BY nazev_zbozi,rok 
ORDER BY minimalni_procentualni_zmena_ceny; 

