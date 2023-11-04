
SELECT * 
FROM t_tatana_dudackova_project_sql_primary_final
ORDER BY industry_branch_code, payroll_year,payroll_quarter;

SELECT ttdpspf.payroll_value,ttdpspf2.payroll_value AS payroll_value_next_year, ttdpspf.industry_branch_code,ttdpspf.payroll_year,ttdpspf2.payroll_year AS next_year,ttdpspf.payroll_quarter 
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
LEFT JOIN t_tatana_dudackova_project_sql_primary_final ttdpspf2
ON ttdpspf.cp_id = ttdpspf2.cp_id -- joinuju obe tabulky pres id za podminky viz nize, mohla bych pro jistotu pridat podminku rovnosti dalsich sloupcu, ale uz ted se mi prikaz vykonava priserne pomalu
WHERE ttdpspf.payroll_year = ttdpspf2.payroll_year + 1;


-- cp.value,cp2.value AS payroll_next_year,cp.industry_branch_code,cp.payroll_year,cp.payroll_quarter 

SELECT cp.value,cp2.value AS druha_tabulka_value,cp.industry_branch_code, cp.payroll_year,cp.payroll_quarter,cp2.payroll_year AS payroll_year2,cp2.payroll_quarter AS payroll_quarter2
FROM czechia_payroll cp
JOIN czechia_payroll cp2 
ON cp.id=cp2.id
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code = '5958' AND cp.calculation_code  = '200'
ORDER BY cp.industry_branch_code, cp.payroll_year,cp.payroll_quarter; -- prijoinovavam znova stejnou tabulku, v dalsim kroku TO zkusim posunout

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

SELECT cp.id,cp.value,cp.industry_branch_code,cp.payroll_year,cp.payroll_quarter 
FROM czechia_payroll cp
WHERE cp.value_type_code = '5958' AND cp.calculation_code  = '200';

-- --------------
   