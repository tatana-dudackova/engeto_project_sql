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
WHERE cp.value_type_code ='5958' AND e.country = 'czech republic' AND cp.calculation_code = '200'); -- tohle funguje, akorat pak jeste musim dat ORDER BY podle tech prvnich dvou id

DROP  TABLE pokus2_t_tatana_dudackova_project_sql_primary_final;

SELECT *
FROM pokus2_t_tatana_dudackova_project_sql_primary_final pttdpspf;
ORDER BY mzdy_id,mzdy_id_previous_year; -- tohle udelat asi az nakonec, trva TO desne dlouho

-- novy pokus - zkousim jeste prijoinovat czechia price posunute o rok -- radsi to tu pisi znova -- je to cele ale strasne pomale :(

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
	cp2.value AS vyse_cen,
	cp4.value AS vyse_cen_prev_year, 
	cp2.category_code, 
	cp2.date_from, 
	cp2.date_to,
	cp2.region_code,
	e.GDP,
	e2.gdp AS gdp_year_prev_year
FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2
	ON cp.payroll_year = YEAR(cp2.date_from)
	AND cp.payroll_quarter = quarter (cp2.date_from)
LEFT JOIN economies e 
	ON cp.payroll_year = e.`year`
LEFT JOIN czechia_payroll cp3 
	ON cp.value_type_code = cp3.value_type_code
		AND cp.unit_code = cp3.unit_code 
		AND cp.calculation_code = cp3.calculation_code
		AND cp.industry_branch_code = cp3.industry_branch_code 
		AND cp.payroll_year = cp3.payroll_year +1
		AND cp.payroll_quarter = cp3.payroll_quarter
LEFT JOIN czechia_price cp4 
	ON cp2.category_code = cp4.category_code 
	AND cp2.region_code = cp4.region_code 
	AND cp.payroll_year = YEAR(cp4.date_from)+1
	AND cp.payroll_quarter = quarter(cp4.date_from) 
LEFT JOIN economies e2 
  ON cp.payroll_year = e2.`year`+1
WHERE cp.value_type_code ='5958' AND e.country = 'czech republic' AND cp.calculation_code = '200');





-