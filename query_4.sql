SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;

SELECT
rok,
((sum(vyse_mezd)/sum(vyse_mezd_prev_year))*100 - 100) AS mezirocni_zmena_mezd_v_procentech,
((sum(vyse_cen)/sum(vyse_cen_prev_year))*100-100) AS mezirocni_zmena_cen_v_procentech,
CASE
	WHEN ((sum(vyse_cen)/sum(vyse_cen_prev_year))*100-100) - ((sum(vyse_mezd)/sum(vyse_mezd_prev_year))*100 - 100) > 10 THEN 'pozor, vyrazny narust'
	ELSE 'vyrazna zmena nenastala'
END AS porovnani_rustu_mezd_a_potravin
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok ;

-- prijde mi, ze mi to vychazi nejak divne, radsi se nad tim jeste zamyslet...
-- NAPAD: u jednoho z tech predchozich ukolu bych jeste mohla zkombinovat sumu a prumer!!!
-- tady mozna taky!!!