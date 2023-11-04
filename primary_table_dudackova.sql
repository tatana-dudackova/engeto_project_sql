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


-- -----------------
SELECT * 
FROM t_tatana_dudackova_project_sql_primary_final;

SELECT cp_id, payroll_value,industry_branch_code,payroll_year,payroll_quarter 
FROM t_tatana_dudackova_project_sql_primary_final
ORDER BY payroll_year; -- poznamka - zkusit prijoinovat znova rok a ctvrtleti