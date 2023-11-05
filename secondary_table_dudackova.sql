CREATE TABLE t_tatana_dudackova_project_sql_secondary_final AS (
SELECT c.country,c.population,e.`year` AS `year`,e.gdp,e.gini,e.taxes
FROM countries c
JOIN economies e
ON c.country =e.country AND c.continent = 'europe'
WHERE e.`year` BETWEEN 
	(SELECT min(rok) FROM t_tatana_dudackova_project_sql_primary_final) AND 
	(SELECT max(rok) FROM t_tatana_dudackova_project_sql_primary_final));

-- vyber roku jsem puvodne chtela udelat pomoci in, vnoreneho order by a limit, ale vratila se mi chybova hlaska, ze tato verze maria DB zvolenou kombinaci prikazu zatim nepodporuje

