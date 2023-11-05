CREATE TABLE t_tatana_dudackova_project_sql_primary_final AS (
SELECT cp.id AS cp_id, cp.value AS payroll_value,cp.industry_branch_code,cp.payroll_year,cp.payroll_quarter,cp2.id AS cp2_id, cp2.value AS cp2_value, cp2.category_code, cp2.date_from, cp2.date_to,e.GDP  
FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2
ON cp.payroll_year = YEAR(cp2.date_from)
LEFT JOIN economies e 
ON cp.payroll_year = e.`year`
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958' AND e.country = 'czech republic' AND calculation_code = '200');

-- poznamky: sloupce, ktere se ve slucovanych tabulkach jmenuji stejne, jsem musela prejmenovat
-- z tabulky economies jsem pro ceskou republiku vybrala jen sloupec HDP
-- v popisu k projektu popsat take podminku where, proc jsem to zvolila tak, jak jsem zvolila
-- z tabulky czechia payroll jsem vyhodila region code, protoze ho vzhledem k zadani urcite nebudu potrebovat
-- tabulku pak vytvorit znovu a pojmenovat ji tak, jak ji mame pojmenovat
-- mozna pak odstranit i sloupec value_type_code, nemusi tam podle me byt, kdyz uz ho mam v podmince where
-- myslim, ze nepotrebuju ani sloupec unit_code, nedavat do finalni tabulky
-- naopak ale budu potrebovat sloupec calculation_code. Pokud je kod 100, tak TO znamena skutecny pocet zamestnancu, bez ohledu na TO, jestli maji plny uvazek. kod 200 znamena prepocteni na plny uvazek. ja asi tedy potrebuji kod 200
-- do finalni tabulky ho ale take nedam, uz ho mam ve where, tak je pak zbytecny. ale to omezeni je podstatne.
-- mozna pak jeste prejmenovat sloupce
-- určitě napsat, že se mi to tvořilo strašně pomalu a proto jsem to musela rozdělit do několika příkazů

CREATE TABLE t_mezikrok1_t_tatana_dudackova_project_sql_primary_final AS (
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
		
SELECT *
FROM t_mezikrok1_t_tatana_dudackova_project_sql_primary_final m1;


/*

CREATE TABLE mezikrok2_t_tatana_dudackova_project_sql_primary_final AS (
SELECT 
	m1.*,
	cp2.id AS ceny_id,
	cp2.category_code, 
	cp2.date_from, 
	cp2.date_to,
	cp2.region_code,
	cp2.value AS vyse_cen
FROM mezikrok1_t_tatana_dudackova_project_sql_primary_final m1
LEFT JOIN czechia_price cp2
	ON m1.payroll_year = YEAR(cp2.date_from)
	AND m1.payroll_quarter = quarter(cp2.date_from));
	

SELECT *
FROM mezikrok2_t_tatana_dudackova_project_sql_primary_final m2
ORDER BY kod_odvetvi, payroll_year, payroll_quarter, mzdy_id;


CREATE TABLE mezikrok3_t_tatana_dudackova_project_sql_primary_final AS(
SELECT 
mzdy_id,
mzdy_id_prev_year,
vyse_mezd,
vyse_mezd_prev_year,
kod_odvetvi,
payroll_year,
payroll_year_prev_year,
payroll_quarter,
ceny_id,
category_code ,
date_from ,
region_code,
vyse_cen
FROM mezikrok2_t_tatana_dudackova_project_sql_primary_final m2);-- odstranila jsem tyto sloupce: unit_code, calculation_code,value_type_code, date_to = nebudu s nimi dále pracovat a vsude jsou diky omezenim stejne hodnoty

SELECT *
FROM mezikrok3_t_tatana_dudackova_project_sql_primary_final m3
ORDER BY kod_odvetvi, payroll_year, payroll_quarter, mzdy_id;


CREATE TABLE mezikrok4_t_tatana_dudackova_project_sql_primary_final AS (
SELECT m3.*,cp.value AS vyse_cen_prev_year
FROM mezikrok3_t_tatana_dudackova_project_sql_primary_final m3
JOIN czechia_price cp
ON m3.payroll_year = YEAR(cp.date_from) +1
	AND m3.payroll_quarter = quarter(cp.date_from)
	AND m3.category_code = cp.category_code 
	AND m3.region_code = cp.region_code;


SELECT * 
FROM czechia_price cp;
		
		
CREATE TABLE pokus2_t_tatana_dudackova_project_sql_primary_final AS (
SELECT  
	cp.id AS mzdy_id,
	cp3.id AS mzdy_id_prev_year,
	cp.value AS vyse_mezd,
	cp3.value AS vyse_mezd_prev_year,
	cp.value_type_code,
	cp.unit_code,
	cp.calculation_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp3.payroll_year AS payroll_year_prev_year,
	cp.payroll_quarter,
	
	cp2.id AS ceny_id,
	cp2.category_code, 
	cp2.date_from, 
	cp2.date_to,
	cp2.region_code,
	cp2.value AS vyse_cen,
	cp4.value AS vyse_cen_prev_year, 
	
	e.GDP,
	e2.gdp AS gdp_year_prev_year
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll cp3 
	ON cp.value_type_code = cp3.value_type_code
		AND cp.unit_code = cp3.unit_code 
		AND cp.calculation_code = cp3.calculation_code
		AND cp.industry_branch_code = cp3.industry_branch_code 
		AND cp.payroll_year = cp3.payroll_year +1
		AND cp.payroll_quarter = cp3.payroll_quarter
		
LEFT JOIN czechia_price cp2
	ON cp.payroll_year = YEAR(cp2.date_from)
	
LEFT JOIN czechia_price cp4 
	ON cp2.category_code = cp4.category_code 
	AND cp2.region_code = cp4.region_code 
	AND cp.payroll_year = YEAR(cp4.date_from)+1
	
LEFT JOIN economies e 
	ON cp.payroll_year = e.`year`
LEFT JOIN economies e2 
  ON cp.payroll_year = e2.`year`+1
WHERE cp.value_type_code ='5958' AND e.country = 'czech republic' AND cp.calculation_code = '200');

-- 
**/

-- zkusim na TO jit uplne jinak a napred upravit tabulku czechia price... uz fakt nevim
-- -------------------------------------------------------------------------------------------------------------------
CREATE TABLE t_mezikrok_tatana_dudackova_czechia_price AS (
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
-- transformovana tabulka pro czechia price, kam jsem prijoinovala vysi cen za predchozi rok
-- musela jem upravit take format data = vypreparovani rok, ctvrtleti, mesice a tydne
-- sloupec date_from by nebyl nutny, ale radsi jsem ho tam nechala pro kontrolu, zda cisla sedi
-- vzhledem ke granularite dat jsem dala podminku rovnosti tydnu, aby se sparovaly vzdy ty spravne hodnoty

SELECT *
FROM t_mezikrok_tatana_dudackova_czechia_price;
