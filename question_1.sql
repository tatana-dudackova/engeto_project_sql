
SELECT * 
FROM t_tatana_dudackova_project_sql_primary_final;

SELECT ttdpspf.payroll_value,ttdpspf2.payroll_value AS payroll_value_next_year, ttdpspf.industry_branch_code,ttdpspf.payroll_year,ttdpspf2.payroll_year AS next_year,ttdpspf.payroll_quarter 
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
JOIN t_tatana_dudackova_project_sql_primary_final ttdpspf2
ON ttdpspf.cp_id = ttdpspf2.cp_id -- joinuju obe tabulky pres id za podminky viz nize, pro jistotu pridavam podminku rovnosti u dalsich sloupcu
WHERE ttdpspf.payroll_year = ttdpspf2.payroll_year + 1;