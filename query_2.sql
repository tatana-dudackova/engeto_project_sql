SELECT *
FROM t_tatana_dudackova_project_sql_primary_final
WHERE cp2_value IS NOT NULL
ORDER BY payroll_year;

SELECT code,name 
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%'; -- pomocnym způsobem jsem si overila, jake kody maji chleb a mleko a pak jsem TO zakomponovala do slozitejsiho dotazu nize

SELECT *
FROM czechia_price cp
WHERE category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%') AND region_code IS NULL
ORDER BY date_from;

SELECT payroll_value,avg(cp2_value),category_code,payroll_year,payroll_quarter,payroll_value/avg(cp2_value) AS vypocet,
CASE 
	WHEN category_code  = '111301' THEN 'kg chleba'
	ELSE 'litrů mléka'
END AS jednotka
FROM t_tatana_dudackova_project_sql_primary_final
WHERE cp2_value IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%')
GROUP BY payroll_value,category_code,payroll_year,payroll_quarter; -- VYPOCET, KTERY MI VYCHAZI. jeste BY chtelo doplnit jednotku, tzn. kusy nebo litry, a vybrat posledni a prvni obdobi. asi bych udelala dva dotazy, seradila TO bud vzestupne nebo sestupne a udelala LIMIT na 2

-- zobrazi se radky, kde kod zbozi odpovida kodu pro mleko a nebo pro chleb, zaroven jsem dala podminku, aby kod kategorie nebyl nulovy, takze se mi nezobrazi radky, kde jsou nulove hodnoty, zobrazi se mi az relevantni roky

SELECT *
FROM czechia_price_category cpc;


-- ---------

SELECT category_code, round(payroll_value/cp2_value,2), payroll_year, payroll_quarter
FROM t_tatana_dudackova_project_sql_primary_final
WHERE cp2_value IS NOT NULL AND category_code IN 
(SELECT code
FROM czechia_price_category cpc
WHERE name LIKE '%chléb%' OR  name LIKE '%mléko%')
ORDER BY payroll_year, payroll_quarter; -- pokus, jak TO udelat, jenomze zatim nemam srovnatelna obdobi, udaje o cenach jsou po mesicich
-- 