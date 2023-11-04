SELECT *
FROM czechia_payroll cp;

SELECT *
FROM czechia_price cp2;

CREATE TABLE pokus2_t_tatana_dudackova_project_sql_primary_final AS (
SELECT 
	cp.id AS cp_id, 
	cp.value AS payroll_value,
	cp.value_type_code,
	cp.unit_code,
	cp.calculation_code,
	cp.industry_branch_code,
	cp.payroll_year,
	cp.payroll_quarter,
	cp2.id AS cp2_id, 
	cp2.value AS cp2_value, 
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
WHERE cp.value_type_code ='5958' AND e.country = 'czech republic' AND calculation_code = '200');

DROP  TABLE pokus2_t_tatana_dudackova_project_sql_primary_final;

