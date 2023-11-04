
SELECT * 
FROM t_tatana_dudackova_project_sql_primary_final
ORDER BY industry_branch_code, payroll_year,payroll_quarter;

SELECT DISTINCT cp.id,cp2.id, cp.value,cp2.value AS druha_tabulka_value,cp.industry_branch_code, cp2.industry_branch_code, cp.payroll_year,cp.payroll_quarter,cp2.payroll_year +1 AS payroll_year2,cp2.payroll_quarter AS payroll_quarter2
FROM czechia_payroll cp
LEFT JOIN czechia_payroll cp2 
ON cp.value_type_code = cp2.value_type_code
AND cp.unit_code = cp2.unit_code 
AND cp.calculation_code = cp2.calculation_code
AND cp.industry_branch_code = cp2.industry_branch_code 
AND cp.payroll_year = cp2.payroll_year +1
AND cp.payroll_quarter = cp2.payroll_quarter 
WHERE cp.value_type_code = '5958' AND cp.calculation_code  = '200'
ORDER BY cp.id,cp2.id; -- jooo, ted se mi TO posunulo spravne. zkontrolovat ale odvetvi.
   
-- poznamka: posun mozna zkusit udelat uz rovnou v te finalni tabulce. Budu tam potrebovat udelat value2 a payroll_year2. 
-- v tom sql dotazu bych pak uz udelala jen case
-- jinak se mi to asi bude pocitat priserne dlouho

-- --------------------
-- tady jeste zkusim udelat CASE - funguje to
-- pak jeste bude asi zapotrebi vybrat to prislusne odvetvi ???


SELECT DISTINCT cp.id,cp2.id, cp.value,cp2.value AS druha_tabulka_value,cp.industry_branch_code, cp2.industry_branch_code, cp.payroll_year,cp.payroll_quarter,cp2.payroll_year +1 AS payroll_year2,cp2.payroll_quarter AS payroll_quarter2,
CASE 
	WHEN cp.value>cp2.value THEN 'mzdy vzrostly'
	WHEN cp2.value>cp.value THEN 'mzdy klesly'
	WHEN cp2.value IS NULL THEN 'chybi nam udaje'
	ELSE 'mzdy zustaly stejne'
END AS porovnani
FROM czechia_payroll cp
LEFT JOIN czechia_payroll cp2 
ON cp.value_type_code = cp2.value_type_code
AND cp.unit_code = cp2.unit_code 
AND cp.calculation_code = cp2.calculation_code
AND cp.industry_branch_code = cp2.industry_branch_code 
AND cp.payroll_year = cp2.payroll_year +1
AND cp.payroll_quarter = cp2.payroll_quarter 
WHERE cp.value_type_code = '5958' AND cp.calculation_code  = '200'
ORDER BY cp.id,cp2.id;

-- prikaz viz vyse zkusit udelat pak podle te finalni tabulky, pokusit se ale mit v te finalni tabulce uz prijoinovany ten spravny sloupec

