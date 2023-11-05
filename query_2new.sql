
(SELECT avg(vyse_mezd) AS prumerne_mzdy_vsechna_odvetvi,avg(vyse_cen) AS prumerna_cena_ctvrtleti,category_code,rok,ctvrtleti,round(avg(vyse_mezd)/avg(vyse_cen),2) AS vypocet,
CASE
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%') THEN 'kg chleba'
	ELSE 'litru mleka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
WHERE vyse_cen IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%' OR  name LIKE '%ml�ko%') 
GROUP BY category_code,rok,ctvrtleti
ORDER BY rok,ctvrtleti
LIMIT 2)
UNION 
(SELECT avg(vyse_mezd) AS prumerne_mzdy_vsechna_odvetvi,avg(vyse_cen) AS prumerna_cena_ctvrtleti,category_code,rok,ctvrtleti,round(avg(vyse_mezd)/avg(vyse_cen),2) AS vypocet,
CASE
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%') THEN 'kg chleba'
	ELSE 'litru mleka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
WHERE vyse_cen IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%' OR  name LIKE '%ml�ko%') 
GROUP BY category_code,rok,ctvrtleti
ORDER BY rok DESC ,ctvrtleti DESC
LIMIT 2);
-- ale pozor!!! vyslo mi to bohuzel jinak nez vcera, vychazi mi totiz z nejakeho duvodu jinak prumerne ceny za ctvrtleti :(
-- overit, kde je chyba





-- POKUS O SLOUCENI PROSTREDNICTVIM UNION a jeste jsem vymenila znova sumu za prumer, pac jsem prisla na to, ze je to jinak zkreslene
(SELECT avg(payroll_value) AS prumerne_mzdy_vsechna_odvetvi,avg(cp2_value) AS prumerna_cena_ctvrtleti,category_code,payroll_year,payroll_quarter,round(avg(payroll_value)/avg(cp2_value),2) AS vypocet,
CASE 
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%') THEN 'kg chleba'
	ELSE 'litr? ml�ka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final_old
WHERE cp2_value IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%' OR  name LIKE '%ml�ko%') 
GROUP BY category_code,payroll_year,payroll_quarter
ORDER BY payroll_year, payroll_quarter
LIMIT 2)
UNION
(SELECT avg(payroll_value) AS prumerne_mzdy_vsechna_odvetvi,avg(cp2_value) AS prumerna_cena_ctvrtleti,category_code,payroll_year,payroll_quarter,round(avg(payroll_value)/avg(cp2_value),2) AS vypocet,
CASE 
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%') THEN 'kg chleba'
	ELSE 'litr? ml�ka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final_old
WHERE cp2_value IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chl�b%' OR  name LIKE '%ml�ko%') 
GROUP BY category_code,payroll_year,payroll_quarter
ORDER BY payroll_year DESC, payroll_quarter DESC
LIMIT 2);

-- TOHLE BY SNAD UZ MOHLA BEJT FINALNI ODPOVED NA MUJ DOTAZ!!! - potom smazat predchozi mezikroky a popsat, jak jsem postupovala