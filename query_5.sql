SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;

-- Definuji si, ze vyrazny narust HDP bude vice nez 5 % 
SELECT DISTINCT 
rok,((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
CASE 
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 THEN 'vyrazny narust hdp'
	ELSE 'nevyrazny narust nebo pokles'
END AS zhodnoceni_zmeny_hdp
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
ORDER BY rok DESC ;
-- pozn - overila jsem si na webu csu, ze je ten vypocet vyse dobre

-- Dalsi podminky - mzdy a ceny
SELECT DISTINCT 
rok,((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
CASE 
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 THEN 'vyrazny narust hdp'
	ELSE 'nevyrazny narust nebo pokles'
END AS zhodnoceni_zmeny_hdp,
avg(vyse_mezd)/avg(vyse_mezd_prev_year)*100-100 AS mzdy_mezirocne,
avg(vyse_cen)/avg(vyse_cen_prev_year)*100-100 AS ceny_mezirocne,
CASE
	WHEN (((GDP/gdp_prev_year*100)-100) > 5) AND (avg(vyse_mezd)/avg(vyse_mezd_prev_year)*100-100 > 10 OR  avg(vyse_cen)/avg(vyse_cen_prev_year)*100-100 > 10) THEN 'vlivem vyrazneho rustu hdp doslo k vyraznemu rustu mezd nebo cen'
	WHEN (((GDP/gdp_prev_year*100)-100) > 5) AND (avg(vyse_mezd)/avg(vyse_mezd_prev_year)*100-100 < 10 OR  avg(vyse_cen)/avg(vyse_cen_prev_year)*100-100 < 10) THEN 'nastal vyrazny rust hdp bez dalsich vlivu'
	WHEN (((GDP/gdp_prev_year*100)-100) < 5) THEN 'nevyrazny rust hdp'
	ELSE 'jina moznost'
END AS 'posouzeni vlivu'
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok 
ORDER BY rok ;





