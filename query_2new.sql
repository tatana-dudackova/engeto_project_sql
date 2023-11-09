
(SELECT avg(vyse_mezd) AS prumerne_ctvrtletni_mzdy_vsechna_odvetvi,avg(vyse_cen) AS prumerna_cena_ctvrtleti,category_code,rok,ctvrtleti,round(avg(vyse_mezd)/avg(vyse_cen),2) AS vypocet,
CASE
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%') THEN 'kg chleba'
	ELSE 'litru mleka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
WHERE vyse_cen IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%') 
GROUP BY category_code,rok,ctvrtleti
ORDER BY rok,ctvrtleti
LIMIT 2)
UNION 
(SELECT avg(vyse_mezd) AS prumerne_mzdy_vsechna_odvetvi,avg(vyse_cen) AS prumerna_cena_ctvrtleti,category_code,rok,ctvrtleti,round(avg(vyse_mezd)/avg(vyse_cen),2) AS vypocet,
CASE
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%') THEN 'kg chleba'
	ELSE 'litru mleka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
WHERE vyse_cen IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%') 
GROUP BY category_code,rok,ctvrtleti
ORDER BY rok DESC ,ctvrtleti DESC
LIMIT 2);

-- finalni verze kodu, jeste mozna poupravim ale tu primarni tabulku. myslim, ze mi TO vychazi spravne.