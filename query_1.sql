SELECT DISTINCT nazev_odvetvi,rok,ctvrtleti,vyse_mezd,vyse_mezd_prev_year,
CASE 
	WHEN vyse_mezd > vyse_mezd_prev_year THEN 'mzdy vzrostly'
	WHEN vyse_mezd < vyse_mezd_prev_year THEN 'mzdy klesly'
	WHEN vyse_mezd_prev_year IS NULL THEN 'chybi nam udaje'
	ELSE 'mzdy zustaly stejne'
END AS mezirocni_srovnani
FROM t_tatana_dudackova_project_sql_primary_final
ORDER BY mezirocni_srovnani, nazev_odvetvi, rok,ctvrtleti;

