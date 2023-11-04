
SELECT * 
FROM t_tatana_dudackova_project_sql_primary_final;

SELECT cp_id, payroll_value,industry_branch_code,payroll_year,payroll_quarter 
FROM t_tatana_dudackova_project_sql_primary_final
ORDER BY payroll_year;   -- poznamka - zkusit prijoinovat znova rok a ctvrtleti 