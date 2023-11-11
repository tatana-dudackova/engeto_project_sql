
SELECT DISTINCT 
	rok,
	((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
	avg(vyse_mezd)/avg(vyse_mezd_prev_year)*100-100 AS mzdy_mezirocne,
	avg(vyse_cen)/avg(vyse_cen_prev_year)*100-100 AS ceny_mezirocne,
CASE
	WHEN (((GDP/gdp_prev_year*100)-100) > 5) AND (avg(vyse_mezd)/avg(vyse_mezd_prev_year)*100-100 > 5 OR  avg(vyse_cen)/avg(vyse_cen_prev_year)*100-100 > 5) THEN 'vlivem vyrazneho rustu hdp doslo k vyraznemu rustu mezd a/nebo cen'
	WHEN (((GDP/gdp_prev_year*100)-100) > 5) AND (avg(vyse_mezd)/avg(vyse_mezd_prev_year)*100-100 < 5 OR  avg(vyse_cen)/avg(vyse_cen_prev_year)*100-100 < 5) THEN 'nastal vyrazny rust hdp bez dalsich vlivu'
	WHEN (((GDP/gdp_prev_year*100)-100) < 5) THEN 'nevyrazny rust hdp popr. pokles'
	ELSE 'jina moznost'
END AS 'posouzeni vlivu',
avg(vyse_mezd_next_year)/avg(vyse_mezd)*100-100 AS mzdy_mezirocne_dalsi_rok,
avg(vyse_cen_next_year)/avg(vyse_cen)*100-100 AS ceny_mezirocne_dalsi_rok,
CASE
	WHEN (((GDP/gdp_prev_year*100)-100) > 5) AND (avg(vyse_mezd_next_year)/avg(vyse_mezd)*100-100 > 5 OR  avg(vyse_cen_next_year)/avg(vyse_cen)*100-100 > 5) THEN 'vlivem vyrazneho rustu hdp doslo k vyraznemu rustu mezd a/nebo cen'
	WHEN (((GDP/gdp_prev_year*100)-100) > 5) AND (avg(vyse_mezd_next_year)/avg(vyse_mezd)*100-100 < 5 OR  avg(vyse_cen_next_year)/avg(vyse_cen)*100-100 < 5) THEN 'nastal vyrazny rust hdp bez dalsich vlivu'
	WHEN (((GDP/gdp_prev_year*100)-100) < 5) THEN 'nevyrazny rust hdp popr. pokles'
	ELSE 'jina moznost'
END AS 'posouzeni vlivu dalsi rok'
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok 
ORDER BY rok ;

