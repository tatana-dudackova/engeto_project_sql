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

-- TEXT VYSE SMAZAT !!! - az budu mit ty poznamky jinde

-- MEZIKROK 1: Propojeni tabulky czechia_payroll se stejnou tabulkou (potrebuji pripojit hodnoty za predchozi rok). Zatim jsem neodstranila nektere pomocne sloupce. Vysledkem je pomocna tabulka.
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
-- tady jsem si vytvorila prvni mezitabulku, kde jsem prijoinovala sloupec ze stejne tabulky, abych mohla provadet mezirocni porovnani
-- podminky pro value type code a calculation code viz vyse
-- dale jsem provedla bokem podobny krok pro tabulku czechia price, ale tam jsem jeste musela datum prevest do jineho formatu a dost z nej udaje pro tyden, mesic, rok, ctvrtleti... = ruzna granularita		
-- tento text pozdeji smazat (az budu mit ty poznamky vypsane nekde jinde)


-- MEZIKROK 1b: pripojuji znovu tabulku czechia_payroll, jelikoz potrebuji jeste sloupec pro mzdy z dalsiho roku
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


-- MEZIKROK 1c: Propojeni tabulky czechia_price se stejnou tabulkou (potrebuji pripojit hodnoty za predchozi rok). Take jsem potrebovala upravit datum.
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
-- transformovana tabulka pro czechia price, kam jsem prijoinovala vysi cen za predchozi rok
-- musela jem upravit take format data = vypreparovani rok, ctvrtleti, mesice a tydne
-- sloupec date_from by nebyl nutny, ale radsi jsem ho tam nechala pro kontrolu, zda cisla sedi
-- vzhledem ke granularite dat jsem dala podminku rovnosti tydnu, aby se sparovaly vzdy ty spravne hodnoty
-- tento text pozdeji smazat, az ho budu mit jinde

-- MEZIKROK 1d: Propojeni tabulky z mezikroku 1c znovu s tabulkou czechia price, protoze na query5 potrebuji jeste ceny v dalsim roce
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

-- MEZIKROK 2: Propojuji obe pomocne tabulky z mezikroku 1b a 1d na zaklade roku a ctvrtleti. Zatim nechavam prebytecne sloupce, zbavim se jich v dalsim kroku.
CREATE TABLE t_mezikrok2_t_tatana_dudackova_project_sql_primary_final AS (
SELECT *
FROM t_mezikrok_1d_tatana_dudackova_czechia_price mpc
LEFT JOIN t_mezikrok1b_t_tatana_dudackova_project_sql_primary_final m1
ON mpc.rok = m1.payroll_year
AND mpc.ctvrtleti = m1.payroll_quarter);

-- v tomto kroku spojuji pomocnou tabulku pro ceny s pomocnou tabulkou pro mzdy (obe maji pripojene sloupce s mezirocnimi hodnotami pro porovnani)
-- v dalsim mezikroku se asi zbavim prebytecnych sloupcu, ne vsechny totiz budu potrebovat a zase vytvorim mezitabulku
-- v konecne tabulce jeste budu potrebovat HDP a HDP + 1
-- zbavit se techto sloupcu: value_type_code, unit_code, calculation_code, payroll_year, payroll_year_prev_year, payroll_quarter
-- ktere sloupce nepotrebuji jsem si pro jistotu overila pomoci funkce select distinct - pokud se mi zobrazilo vice udaju, sloupce potrebuji
-- tabulka zacina az v roce 2006, od ktere mame spolecna data pro czechia payroll!!! - pouzila jsem pri joinovani prostrednictvim leveho joinu jako vychozi tabulku czechia price (prvni rok 2006), na to jsem pripojila czechia payroll (prvni udaje pro 2000), tj. udaje pro mzdy za leta, ktera nejsou spolecna (2000-2006, z czechia payroll) mi timto vypadla, ale to mi nijak nevadi, aspon mi takto zustane spolecny zacatek
-- u posunutych dat mi navic pro czechia payroll zustavaji data z roku 2005, takze muzu snadno udelat mezirocni srovnani 2005/2006

-- MEZIKROK 3: Zbavuji se prebytecnych sloupcu 
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
-- tady se tedy zbavuji prebytecnych sloupcu, zbavila jsem se i duplicitnich udaju pro datumy, sloupcu mzdy_id, ceny_id


-- MEZIKROK 4
CREATE TABLE t_mezikrok4_tatana_dudackova_project_sql_primary_final AS (
SELECT m3.*,e.GDP,e2.gdp AS gdp_prev_year
FROM t_mezikrok3_t_tatana_dudackova_project_sql_primary_final m3
LEFT JOIN economies e 
ON rok = e.`year` AND e.country = 'czech republic'
LEFT JOIN economies e2 
 ON e.`year` = e2.`year`+1 AND e2.country = 'czech republic');
-- tady jeste prijoinovavam tabulku pro HDP a HDP predchozi rok. Propojila jsem to pres roky, ale musela jsem jeste dat podminku, ze zeme se rovna ceska republika

SELECT *
FROM t_mezikrok4_tatana_dudackova_project_sql_primary_final;


-- FINALNI VERZE TABULKY
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
m4.region_code,
m4.GDP,
m4.gdp_prev_year 
FROM t_mezikrok4_tatana_dudackova_project_sql_primary_final m4
JOIN czechia_payroll_industry_branch cpib 
ON m4.kod_odvetvi = cpib.code 
JOIN czechia_price_category cpc 
ON m4.category_code=cpc.code);
-- zde jsem jeste pripojila nazvy pro odvetvi a zbozi z tabulek czechia payroll industry branch a czechia price category

SELECT * 
FROM t_tatana_dudackova_project_sql_primary_final;