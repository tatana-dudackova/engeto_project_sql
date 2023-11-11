(SELECT round (avg(vyse_mezd)) AS prumerne_ctvrtletni_mzdy_vsechna_odvetvi,round(avg(vyse_cen),2) AS prumerna_cena_ctvrtleti,nazev_zbozi,rok,ctvrtleti,round(avg(vyse_mezd)/avg(vyse_cen),2) AS vypocet,
CASE 
	WHEN nazev_zbozi LIKE '%chleb%' THEN 'kg chleba'
	ELSE 'litru mleka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final
WHERE vyse_cen IS NOT NULL AND nazev_zbozi LIKE '%chleb%' OR nazev_zbozi LIKE '%mleko%'
GROUP BY nazev_zbozi,rok,ctvrtleti
ORDER BY rok,ctvrtleti
LIMIT 2)
UNION 
(SELECT round(avg(vyse_mezd)) AS prumerne_ctvrtletni_mzdy_vsechna_odvetvi,round(avg(vyse_cen),2) AS prumerna_cena_ctvrtleti,nazev_zbozi,rok,ctvrtleti,round(avg(vyse_mezd)/avg(vyse_cen),2) AS vypocet,
CASE 
	WHEN nazev_zbozi LIKE '%chleb%' THEN 'kg chleba'
	ELSE 'litru mleka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final
WHERE vyse_cen IS NOT NULL AND nazev_zbozi LIKE '%chleb%' OR nazev_zbozi LIKE '%mleko%'
GROUP BY nazev_zbozi,rok,ctvrtleti
ORDER BY rok DESC ,ctvrtleti DESC
LIMIT 2);