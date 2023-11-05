SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;

-- Definuji si, ze vyrazny narust HDP bude vice nez 5 % 
SELECT DISTINCT 
rok,((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
CASE 
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 THEN 'vyrazny narust hdp'
	ELSE 'nevyrazny narust'
END AS zhodnoceni_zmeny_hdp
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;

-- poznamka: jeste porovnat s temi mzdami a cenami, slo by pouzit zavery predchoziho ukolu - DODELAT!!!


