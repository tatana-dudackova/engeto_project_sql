SELECT * 
FROM t_tatana_dudackova_project_sql_primary_final
ORDER BY kod_odvetvi, rok,ctvrtleti;

SELECT DISTINCT mzdy_id,kod_odvetvi,rok,ctvrtleti, vyse_mezd,vyse_mezd_prev_year,
CASE 
	WHEN vyse_mezd > vyse_mezd_prev_year THEN 'mzdy vzrostly'
	WHEN vyse_mezd < vyse_mezd_prev_year THEN 'mzdy klesly'
	WHEN vyse_mezd_prev_year IS NULL THEN 'chybi nam udaje'
	ELSE 'mzdy zustaly stejne'
END AS mezirocni_srovnani
FROM t_tatana_dudackova_project_sql_primary_final
ORDER BY kod_odvetvi, rok,ctvrtleti, mzdy_id;

-- jeste omrknout/zkontrolovat, proc sloupec mezd za predchozi rok neni na zacatku vzdycky nul, je divny, ze to asi odnekud bere ty hodnoty
-- podle toho sloupce zjistuji, ze nektere nekdy doslo k mezirocnimu poklesu 

