SELECT *
FROM countries c;

SELECT *
FROM economies e;

SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
ORDER BY rok;

SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
ORDER BY rok DESC ;

-- takze musim porovnavat roky 2006-2018

SELECT c.country,e.`year` AS rok_secondary,e.gdp,e.gini,e.taxes
FROM countries c
JOIN economies e
ON c.country =e.country AND c.continent = 'europe'
WHERE e.`year` >= rok IN (SELECT DISTINCT rok FROM t_tatana_dudackova_project_sql_primary_final ORDER BY rok LIMIT 1)
OR
WHERE e.`year` <= rok IN (SELECT DISTINCT rok FROM t_tatana_dudackova_project_sql_primary_final ORDER BY rok DESC LIMIT 1);



