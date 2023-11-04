SELECT c.country , c.capital_city, c.independence_date , e.year, 
    round( e.GDP / 1000000, 2 ) as GDP_mil_dollars , 
    e.population , e.gini , e.taxes 
FROM countries c 
JOIN economies e 
    on c.country = e.country 
    and c.independence_date <= e.year
;


SELECT *
FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2
ON cp.payroll_year = YEAR(cp2.date_from)
LEFT JOIN economies e 
ON cp.payroll_year = e.`year`
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958' AND e.country = 'czech republic';