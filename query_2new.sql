
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
-- ale pozor!!! vyslo mi to bohuzel jinak nez vcera, vychazi mi totiz z nejakeho duvodu jinak prumerne ceny za ctvrtleti :(
-- overit, kde je chyba



-- POKUS O SLOUCENI PROSTREDNICTVIM UNION a jeste jsem vymenila znova sumu za prumer, pac jsem prisla na to, ze je to jinak zkreslene
(SELECT avg(payroll_value) AS prumerne_mzdy_vsechna_odvetvi,avg(cp2_value) AS prumerna_cena_ctvrtleti,category_code,payroll_year,payroll_quarter,round(avg(payroll_value)/avg(cp2_value),2) AS vypocet,
CASE 
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%') THEN 'kg chleba'
	ELSE 'litr? mléka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final_old
WHERE cp2_value IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%') 
GROUP BY category_code,payroll_year,payroll_quarter
ORDER BY payroll_year, payroll_quarter
LIMIT 2)
UNION
(SELECT avg(payroll_value) AS prumerne_mzdy_vsechna_odvetvi,avg(cp2_value) AS prumerna_cena_ctvrtleti,category_code,payroll_year,payroll_quarter,round(avg(payroll_value)/avg(cp2_value),2) AS vypocet,
CASE 
	WHEN category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%') THEN 'kg chleba'
	ELSE 'litr? mléka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final_old
WHERE cp2_value IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%') 
GROUP BY category_code,payroll_year,payroll_quarter
ORDER BY payroll_year DESC, payroll_quarter DESC
LIMIT 2);

-- TOHLE BY SNAD UZ MOHLA BEJT FINALNI ODPOVED NA MUJ DOTAZ!!! - potom smazat predchozi mezikroky a popsat, jak jsem postupovala




SELECT category_code,avg(value),year(date_from),quarter(date_from)  
FROM czechia_price cp 
WHERE category_code IN (SELECT code FROM czechia_price_category cpc WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%')
GROUP BY category_code, year(date_from),quarter(date_from)  
ORDER BY year(date_from),quarter(date_from) ;

SELECT category_code,avg(value),year(date_from) 
FROM czechia_price cp 
WHERE category_code IN (SELECT code FROM czechia_price_category cpc WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%')
GROUP BY category_code, year(date_from)
ORDER BY year(date_from);


-- joo, prisla jsem na to, proc se to pocita rozdilne!!! - v jednom z dotazu pocitam prumer pro ctvrtleti a v druhem pro rok!!!!!

-- jeste zjistit, jak se to vlastne pocita u mezd

SELECT avg(value),payroll_year,payroll_quarter 
FROM czechia_payroll cp
WHERE value_type_code = '5958' AND calculation_code = '200'AND industry_branch_code IS NOT NULL AND payroll_year >=2006
GROUP BY payroll_year,payroll_quarter; -- tady mi TO vychazi stejne jako v obou dotazech vyse! takze si bude lepsi TO udelat na TO ctvrtleti, odpovida TO zadani!!!!


SELECT avg(value),payroll_year
FROM czechia_payroll cp
WHERE value_type_code = '5958' AND calculation_code = '200'AND industry_branch_code IS NOT NULL AND payroll_year >=2006
GROUP BY payroll_year;

