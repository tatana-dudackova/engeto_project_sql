SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;

-- Definuji si, ze vyrazny narust HDP bude vice nez 5 % 
SELECT DISTINCT 
rok,((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
CASE 
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 THEN 'vyrazny narust hdp'
	ELSE 'nevyrazny narust'
END AS zhodnoceni_zmeny_hdp
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
ORDER BY rok DESC ;

-- poznamka: jeste porovnat s temi mzdami a cenami, slo by pouzit zavery predchoziho ukolu - DODELAT!!!
-- pozn - overila jsem si na webu csu, ze je ten vypocet vyse dobre

-- POKUS


SELECT DISTINCT 
rok,((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
(avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AS mezirocni_zmena_cen,
((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100) AS mezirocni_zmena_mezd,
CASE 
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AND ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)>10) THEN 'vyrazny narust hdp, mezd i cen'
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 OR  ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)>10) THEN 'vyrazny narust hdp a zaroven mezd nebo cen'
	WHEN ((GDP/gdp_prev_year*100)-100) > 5) AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AND ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)<10) THEN 'vyrazny narust hdp, ale mzdy ani ceny se nezmenily nijak vyrazne'
	ELSE 'nevyrazny narust HDP'
END AS zhodnoceni_zmeny_hdp
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok,zmena_hdp,zhodnoceni_zmeny_hdp;

-- opravit kod viz vyse, nekde tam mam chybu, podle me by mohl byt problem v zavorkach
