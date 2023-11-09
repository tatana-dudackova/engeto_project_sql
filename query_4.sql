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




-- Alternativa, co radsi zkusit prumer?

SELECT
rok,
((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100) AS mezirocni_zmena_mezd_v_procentech,
((avg(vyse_cen)/avg(vyse_cen_prev_year))*100 - 100) AS mezirocni_zmena_cen_v_procentech,
CASE
	WHEN ((avg(vyse_cen)/avg(vyse_cen_prev_year))*100-100) - ((avg(vyse_mezd)/avg(vyse_mezd_prev_year))*100 - 100) > 10 THEN 'pozor, vyrazny narust'
	ELSE 'vyrazna zmena nenastala'
END AS porovnani_rustu_mezd_a_potravin
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok ; -- take se mi vysledky ale nejak nezdaji, radsi overit

-- -------
SELECT (avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100,rok 
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok;

SELECT (avg(vyse_cen)/avg(vyse_cen_prev_year)*100)-100,rok, ctvrtleti
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
GROUP BY rok, ctvrtleti ;

SELECT rok,ctvrtleti,mesic,vyse_cen,vyse_cen_prev_year  
FROM t_tatana_dudackova_project_sql_primary_final ttdpspf
ORDER BY rok;

-- poznamka: overit pres excel, mrknout, jestli jsme neco podobneho nepocitali pro covidova cisla