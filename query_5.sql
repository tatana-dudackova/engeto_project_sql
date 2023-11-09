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

-- tady asi bude dulezity ten komentar. Hranici jsem si u vsech tri hodnot nakonec zvolila 5
-- ze zadani nevyplyvalo, jestli chceme vztah mezi mzdami a cenami posuzovat pro obe promenne zaroven a nebo zvlast, slovo "ci" se da chapat ruzne 
-- ja prikaz sestavila tak, aby podminka platila, pokud vzrostla nad stanovenou hranici alespon jedna moznost
-- krome toho se take mohlo stat, ze vzrostly vyrazne ceny nebo mzdy, ale ne vlivem vyrazneho rustu hdp - pro takovou variantu jsem ale nezvolila specialni posouzeni - jakmile neplati podminka vyrazneho rustu hdp, je to jedno
-- okomentovat, kdy to tedy vubec vyslo
-- pro zajimavost napsat, ze jsem si napred udelala dotaz, kde jsem si porovnala pouze zmeny hdp podle let a overila jsem si na webu csu, ze mi to vyslo spravne :)


