SELECT *
FROM czechia_payroll cp;

SELECT *
FROM czechia_price cp2;

CREATE TABLE pokus2_t_tatana_dudackova_project_sql_primary_final AS (
SELECT  
	cp.id AS mzdy_id,
	cp3.id AS mzdy_id_previous_year,
	cp.value AS vyse_mezd,
	cp3.value AS vyse_mezd_previous_year,
	cp.value_type_code,
	cp.unit_code,
	cp.calculation_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp3.payroll_year AS payroll_year_previous_year,
	cp.payroll_quarter,
	cp3.payroll_quarter AS payroll_quarter_previous_quarter,
	cp2.id AS ceny_id,
	cp2.value AS vyse_cen, 
	cp2.category_code, 
	cp2.date_from, 
	cp2.date_to,
	cp2.region_code,
	e.GDP
FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2
	ON cp.payroll_year = YEAR(cp2.date_from)
LEFT JOIN economies e 
	ON cp.payroll_year = e.`year`
LEFT JOIN czechia_payroll cp3 
	ON cp.value_type_code = cp3.value_type_code
		AND cp.unit_code = cp3.unit_code 
		AND cp.calculation_code = cp3.calculation_code
		AND cp.industry_branch_code = cp3.industry_branch_code 
		AND cp.payroll_year = cp3.payroll_year +1
		AND cp.payroll_quarter = cp3.payroll_quarter
WHERE cp.value_type_code ='5958' AND e.country = 'czech republic' AND cp.calculation_code = '200');

DROP  TABLE pokus2_t_tatana_dudackova_project_sql_primary_final;

SELECT *
FROM pokus2_t_tatana_dudackova_project_sql_primary_final pttdpspf;
ORDER BY mzdy_id,mzdy_id_previous_year; -- tohle udelat asi az nakonec, trva TO desne dlouho


SELECT cp.*
FROM czechia_price cp
JOIN czechia_price cp2
ON cp.category_code = cp.category_code
AND 


