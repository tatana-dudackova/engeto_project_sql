/* TVORBA FINALNI TABULKY*/

-- MEZIKROK 1: Propojeni tabulky czechia_payroll se stejnou tabulkou (potrebuji pripojit hodnoty za predchozi rok). Vysledkem je pomocna tabulka.
CREATE TABLE t_mezikrok1a_t_tatana_dudackova_project_sql_primary_final AS (
SELECT  
	cp.id AS mzdy_id,
	cp3.id AS mzdy_id_prev_year,
	cp.value AS vyse_mezd,
	cp3.value AS vyse_mezd_prev_year,
	cp.value_type_code,
	cp.unit_code,
	cp.calculation_code,
	cp.industry_branch_code AS kod_odvetvi,
	cp.payroll_year,
	cp3.payroll_year AS payroll_year_prev_year,
	cp.payroll_quarter
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll cp3 
	ON cp.value_type_code = cp3.value_type_code
		AND cp.unit_code = cp3.unit_code 
		AND cp.calculation_code = cp3.calculation_code
		AND cp.industry_branch_code = cp3.industry_branch_code 
		AND cp.payroll_year = cp3.payroll_year +1
		AND cp.payroll_quarter = cp3.payroll_quarter
WHERE cp.value_type_code ='5958' AND cp.calculation_code = '200' AND cp.industry_branch_code IS NOT NULL
ORDER BY cp.industry_branch_code, cp.payroll_year, cp.payroll_quarter, cp.id);


-- MEZIKROK 1b: Dalsi propojeni s tabulkou czechia_payroll, jelikoz potrebuji jeste sloupec pro mzdy z dalsiho roku.
CREATE TABLE t_mezikrok1b_t_tatana_dudackova_project_sql_primary_final AS (
SELECT  
	m1.mzdy_id,
	m1.mzdy_id_prev_year,
	m1.vyse_mezd,
	m1.vyse_mezd_prev_year,
	cp.value  AS vyse_mezd_next_year,
	m1.value_type_code,
	m1.unit_code,
	m1.calculation_code,
	m1.kod_odvetvi,
	m1.payroll_year,
	m1.payroll_year_prev_year,
	m1.payroll_quarter
FROM t_mezikrok1a_t_tatana_dudackova_project_sql_primary_final m1
LEFT JOIN czechia_payroll cp
	ON cp.value_type_code = cp.value_type_code
		AND m1.unit_code = cp.unit_code 
		AND m1.calculation_code = cp.calculation_code
		AND m1.kod_odvetvi = cp.industry_branch_code 
		AND m1.payroll_year = cp.payroll_year -1
		AND m1.payroll_quarter = cp.payroll_quarter
WHERE m1.value_type_code ='5958' AND m1.calculation_code = '200' AND m1.kod_odvetvi  IS NOT NULL
ORDER BY m1.kod_odvetvi, m1.payroll_year, m1.payroll_quarter, m1.mzdy_id);

-- MEZIKROK 1c: Propojeni tabulky czechia_price se stejnou tabulkou (potrebuji pripojit hodnoty za predchozi rok). Uprava datumu.
CREATE TABLE t_mezikrok_1c_tatana_dudackova_czechia_price AS (
SELECT 
cp.id AS ceny_id,
cp.value AS vyse_cen,
cp2.value AS vyse_cen_prev_year,
cp.category_code,
YEAR(cp.date_from) AS rok,
quarter(cp.date_from) AS ctvrtleti,
month(cp.date_from) AS mesic,
week(cp.date_from) AS tyden,
cp.date_from,
cp.region_code
FROM czechia_price cp
LEFT JOIN czechia_price cp2
ON cp.category_code = cp2.category_code 
AND cp.region_code = cp2.region_code 
AND year(cp.date_from) = year(cp2.date_from) +1
AND week(cp.date_from) = week(cp2.date_from)); 

-- Mezikrok 1d - dalsi pripojeni czechia_price pro ziskani sloupce s udaji za dalsi rok.
CREATE TABLE t_mezikrok_1d_tatana_dudackova_czechia_price AS (
SELECT 
tmatdcp.ceny_id,
tmatdcp.vyse_cen,
tmatdcp.vyse_cen_prev_year,
cp2.value AS vyse_cen_next_year,
tmatdcp.category_code,
tmatdcp.rok,
tmatdcp.ctvrtleti,
tmatdcp.mesic,
tmatdcp.tyden,
tmatdcp.date_from,
tmatdcp.region_code
FROM t_mezikrok_1c_tatana_dudackova_czechia_price tmatdcp
LEFT JOIN czechia_price cp2
ON tmatdcp.category_code = cp2.category_code 
AND tmatdcp.region_code = cp2.region_code 
AND tmatdcp.rok = year(cp2.date_from) -1
AND tmatdcp.tyden = week(cp2.date_from));


-- MEZIKROK 2: Propojuji obe pomocne tabulky z mezikroku 1b a 1d na zaklade roku a ctvrtleti
CREATE TABLE t_mezikrok2_t_tatana_dudackova_project_sql_primary_final AS (
SELECT *
FROM t_mezikrok_1d_tatana_dudackova_czechia_price mpc
LEFT JOIN t_mezikrok1b_t_tatana_dudackova_project_sql_primary_final m1
ON mpc.rok = m1.payroll_year
AND mpc.ctvrtleti = m1.payroll_quarter);

-- MEZIKROK 3: Zbavuji se prebytecnych sloupcu prostrednictvim nove pomocne tabulky
CREATE TABLE t_mezikrok3_t_tatana_dudackova_project_sql_primary_final AS
(SELECT 
kod_odvetvi,
rok,
ctvrtleti,
mesic,
tyden,
vyse_mezd,
vyse_mezd_prev_year,
vyse_mezd_next_year,
vyse_cen,
vyse_cen_prev_year,
vyse_cen_next_year,
category_code,
region_code
FROM t_mezikrok2_t_tatana_dudackova_project_sql_primary_final);

-- MEZIKROK 4 - propojeni s tabulkou economies
CREATE TABLE t_mezikrok4_tatana_dudackova_project_sql_primary_final AS (
SELECT m3.*,e.GDP,e2.gdp AS gdp_prev_year
FROM t_mezikrok3_t_tatana_dudackova_project_sql_primary_final m3
LEFT JOIN economies e 
ON rok = e.`year` AND e.country = 'czech republic'
LEFT JOIN economies e2 
 ON e.`year` = e2.`year`+1 AND e2.country = 'czech republic');

-- Tvorba finalni verze tabulky: pripojeni sloupcu s nazvem odvetvi a nazvem produktu z jinych tabulek
CREATE TABLE t_tatana_dudackova_project_sql_primary_final AS (
SELECT 
cpib.name AS nazev_odvetvi,
m4.rok,
m4.ctvrtleti,
m4.mesic,
m4.tyden,
m4.vyse_mezd,
m4.vyse_mezd_prev_year,
m4.vyse_mezd_next_year,
m4.vyse_cen,
m4.vyse_cen_prev_year,
m4.vyse_cen_next_year,
cpc.name AS nazev_zbozi,
cr.name AS kraj,
m4.GDP,
m4.gdp_prev_year 
FROM t_mezikrok4_tatana_dudackova_project_sql_primary_final m4
JOIN czechia_payroll_industry_branch cpib 
ON m4.kod_odvetvi = cpib.code 
JOIN czechia_price_category cpc 
ON m4.category_code=cpc.code
JOIN czechia_region cr
ON cr.code = m4.region_code);

SELECT * FROM  t_tatana_dudackova_project_sql_primary_final ;