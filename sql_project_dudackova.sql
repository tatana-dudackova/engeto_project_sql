/*
 * Zadání projektu
Úvod do projektu
Na vašem analytickém oddělení nezávislé společnosti, která se zabývá životní úrovní občanů, jste se dohodli, že se pokusíte odpovědět na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veřejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovědět a poskytnout tuto informaci tiskovému oddělení. Toto oddělení bude výsledky prezentovat na následující konferenci zaměřené na tuto oblast.

Potřebují k tomu od vás připravit robustní datové podklady, ve kterých bude možné vidět porovnání dostupnosti potravin na základě průměrných příjmů za určité časové období.

Jako dodatečný materiál připravte i tabulku s HDP, GINI koeficientem a populací dalších evropských států ve stejném období, jako primární přehled pro ČR.

Datové sady, které je možné použít pro získání vhodného datového podkladu
Primární tabulky:

czechia_payroll – Informace o mzdách v různých odvětvích za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_payroll_calculation – Číselník kalkulací v tabulce mezd.
czechia_payroll_industry_branch – Číselník odvětví v tabulce mezd.
czechia_payroll_unit – Číselník jednotek hodnot v tabulce mezd.
czechia_payroll_value_type – Číselník typů hodnot v tabulce mezd.
czechia_price – Informace o cenách vybraných potravin za několikaleté období. Datová sada pochází z Portálu otevřených dat ČR.
czechia_price_category – Číselník kategorií potravin, které se vyskytují v našem přehledu.
Číselníky sdílených informací o ČR:

czechia_region – Číselník krajů České republiky dle normy CZ-NUTS 2.
czechia_district – Číselník okresů České republiky dle normy LAU.
Dodatečné tabulky:

countries - Všemožné informace o zemích na světě, například hlavní město, měna, národní jídlo nebo průměrná výška populace.
economies - HDP, GINI, daňová zátěž, atd. pro daný stát a rok.
Výzkumné otázky
Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
Výstup projektu
Pomozte kolegům s daným úkolem. Výstupem by měly být dvě tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte t_{jmeno}_{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za Českou republiku sjednocených na totožné porovnatelné období – společné roky) a t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodatečná data o dalších evropských státech).

Dále připravte sadu SQL, které z vámi připravených tabulek získají datový podklad k odpovězení na vytyčené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co říkají data.

Na svém GitHub účtu vytvořte repozitář (může být soukromý), kam uložíte všechny informace k projektu – hlavně SQL skript generující výslednou tabulku, popis mezivýsledků (průvodní listinu) a informace o výstupních datech (například kde chybí hodnoty apod.).

Neupravujte data v primárních tabulkách! Pokud bude potřeba transformovat hodnoty, dělejte tak až v tabulkách nebo pohledech, které si nově vytváříte.


 * 
 * */

SELECT payroll_year,payroll_quarter, value,industry_branch_code
FROM czechia_payroll cp
ORDER BY payroll_year,payroll_quarter;


SELECT payroll_year,payroll_quarter, value,industry_branch_code
FROM czechia_payroll cp
WHERE industry_branch_code = 'a'
ORDER BY value;


SELECT max(value),min(value),avg(value),industry_branch_code
FROM czechia_payroll cp
GROUP BY industry_branch_code;


SELECT payroll_year,payroll_quarter,industry_branch_code,value,value IN (
	SELECT max(VALUE)
	FROM czechia_payroll cp)
FROM czechia_payroll cp
ORDER BY value DESC; -- tímhle jsem zjistila jednu maximální hodnotu vůbec, není TO sice TO, co chci, ale možná BY mě TO mohlo někam odpíchnout


SELECT payroll_year,payroll_quarter,industry_branch_code,value,value IN (
	SELECT max(VALUE)
	FROM czechia_payroll cp)
FROM czechia_payroll cp
ORDER BY value DESC;









SELECT max(value),industry_branch_code 
FROM czechia_payroll cp
GROUP BY industry_branch_code; -- overit, jestli je TO pravda!!!


SELECT value,industry_branch_code 
FROM czechia_payroll cp
WHERE industry_branch_code = 'm'
ORDER BY value  DESC 
LIMIT 1; -- timto prikazem jsem zjistila, ze ten horni asi vychazi. tim padem jsem u toho horniho zjistila, jake jsou maximalni hodnoty u kazdeho odvetvi. 
-- to taky neni zatim to, co chci, ale mam pocit, ze uz jsem bliz

SELECT max(value),industry_branch_code,payroll_year
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL 
GROUP BY industry_branch_code,payroll_year; -- TO mi asi zjisti maximalni hodnotu podle odvetvi a roku??? 



SELECT avg(value),industry_branch_code,payroll_year
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'
GROUP BY industry_branch_code,payroll_year; -- pokusila jsem se udelat prumerne mzdy za kazde odvetvi v kazdem roce, radsi jeste overit, jestli TO dava smysl

-- POZOR!!! value v teto tabulce mohou byt dve veci, dat si tedy pozor na value type!!! (podminka s value type code), toto pak take napsat do popisu k projektu

SELECT * 
FROM czechia_payroll_value_type cpvt;

SELECT *
FROM czechia_payroll_industry_branch cpib;

SELECT *
FROM czechia_price cp;

