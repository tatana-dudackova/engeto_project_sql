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
-- pozn - overila jsem si na webu csu, ze je ten vypocet vyse dobre

-- POKUS
SELECT DISTINCT 
rok,((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
(avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AS mezirocni_zmena_cen,
((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100) AS mezirocni_zmena_mezd,
CASE 
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AND ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)>10) THEN 'vyrazny narust hdp, mezd i cen'
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 OR  ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)>10) THEN 'vyrazny narust hdp a zaroven bud mezd nebo cen'
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AND ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)<10) THEN 'vyrazny narust hdp, ale mzdy ani ceny se nezmenily nijak vyrazne'
	ELSE 'nevyrazny narust HDP'
END AS zhodnoceni_zmeny
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok; 


SELECT *
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf;


-- novy pokus




-- jeste udelam jeden pokus, tedka radsi ukladam

-- pokus - prijoinovani finalni tabulky s posunem o rok na opacnou stranu

SELECT 
ttdpspf.rok,
ttdpspf.vyse_mezd_prev_year, 
ttdpspf.vyse_mezd, 
ttdpspf2.vyse_mezd AS vyse_mezd_next_year
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
JOIN t_tatana_dudackova_project_sql_primary_final ttdpspf2
ON 
ttdpspf.kod_odvetvi = ttdpspf2.kod_odvetvi
AND ttdpspf.rok = ttdpspf2.rok-1
AND ttdpspf.ctvrtleti = ttdpspf2.ctvrtleti
AND ttdpspf.mesic = ttdpspf2.mesic 
AND ttdpspf.tyden = ttdpspf2.tyden 
AND ttdpspf.category_code =  ttdpspf2.category_code
AND ttdpspf.region_code = ttdpspf2.region_code;

-- novy pokus o query 5


SELECT DISTINCT 
rok,((GDP/gdp_prev_year*100)-100) AS zmena_hdp,
(avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AS mezirocni_zmena_cen,
((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100) AS mezirocni_zmena_mezd,
CASE 
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AND ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)>10) THEN 'vyrazny narust hdp, mezd i cen'
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 OR  ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)>10) THEN 'vyrazny narust hdp a zaroven bud mezd nebo cen'
	WHEN ((GDP/gdp_prev_year*100)-100) > 5 AND ((avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100 AND ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100)<10) THEN 'vyrazny narust hdp, ale mzdy ani ceny se nezmenily nijak vyrazne'
	ELSE 'nevyrazny narust HDP'
END AS zhodnoceni_zmeny
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok; 


SELECT GDP,`year`
FROM economies e 
WHERE country = 'czech republic';