SELECT
rok,
((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100) AS mezirocni_zmena_mezd_v_procentech,
((avg(vyse_cen)/avg(vyse_cen_prev_year))*100 - 100) AS mezirocni_zmena_cen_v_procentech,
CASE
	WHEN ((avg(vyse_cen)/avg(vyse_cen_prev_year))*100-100) - ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100) > 10 THEN 'pozor, vyrazny narust'
	ELSE 'vyrazna zmena nenastala'
END AS porovnani_rustu_mezd_a_potravin
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok ;

