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



SELECT avg(value) AS avg_value,industry_branch_code,payroll_year
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'
GROUP BY industry_branch_code,payroll_year; -- pokusila jsem se udelat prumerne mzdy za kazde odvetvi v kazdem roce, radsi jeste overit, jestli TO dava smysl

-- POZOR!!! value v teto tabulce mohou byt dve veci, dat si tedy pozor na value type!!! (podminka s value type code), toto pak take napsat do popisu k projektu


-- pokus s window function
SELECT industry_branch_code,payroll_year,
avg(value) OVER (PARTITION BY industry_branch_code, payroll_year) AS avg_value
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'; -- joooo, melo BY mi TO vychazet stejne podle GROUP BY i WINDOW FUNCTION, velky objev!!!! asi zapsat pak i do popisu projektu, mezi cim jsem se rozhodovala

-- vzor z tohoto webu: https://www.sqlshack.com/sql-partition-by-clause-overview/
SELECT Customercity, 
       AVG(Orderamount) OVER(PARTITION BY Customercity) AS AvgOrderAmount, 
       MIN(OrderAmount) OVER(PARTITION BY Customercity) AS MinOrderAmount, 
       SUM(Orderamount) OVER(PARTITION BY Customercity) TotalOrderAmount
FROM [dbo].[Orders];



SELECT industry_branch_code,payroll_year,value,
RANK () OVER (PARTITION BY industry_branch_code ORDER BY value) AS poradi,
CASE 
	WHEN (payroll_year + 1) > payroll_year THEN 'mzdy rostou' -- ----- pozn. - tohle nefunguje, zkusim prijoinovat
	ELSE 'mzdy jsou dalsi rok stejne nebo klesaji'
END AS vysledek
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'; 






SELECT *
FROM czechia_payroll cp;

-- mozna na to jdu ale celkove spatne a mozna bych spis mela zjistit, jestli nejvyssi value je v nejvyssim roce?


SELECT industry_branch_code, payroll_year,avg(value) AS avg_value
FROM czechia_payroll cp 
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'
GROUP BY industry_branch_code,payroll_year; 

SELECT max(payroll_year),industry_branch_code
FROM czechia_payroll cp 
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'
GROUP BY industry_branch_code;


SELECT
    industry_branch_code
FROM czechia_payroll
WHERE value IN (
    SELECT
        MAX(value)
    FROM czechia_payroll
    WHERE value_type_code = 5958
);

where year in (
select max (year)
from czechia_payroll
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958');

SELECT industry_branch_code,avg(value),payroll_year 
FROM czechia_payroll cp 
WHERE payroll_year IN  (
SELECT max (payroll_year)
FROM  czechia_payroll
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958')
GROUP BY industry_branch_code,payroll_year; -- podle me TO nevychazi spravne, ale nevim :( )


SELECT industry_branch_code,avg(value),payroll_year,
CASE 
	WHEN payroll_year IN (SELECT max(payroll_year) FROM czechia_payroll) THEN 'mzdy rostou'
	ELSE 'neplati, ze mzdy rostou'
END AS posouzeni
FROM czechia_payroll cp 
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'
GROUP BY industry_branch_code,payroll_year; -- takhle BY TO podle me moznaa slo, sice TO nevychazi, ale mohla bych zkusit jeste jednou prijoinovat rok a nejak TO porovnat


SELECT industry_branch_code,avg(value) AS avg_value,payroll_year,
RANK () OVER (PARTITION BY industry_branch_code ORDER BY avg_value) AS poradi
FROM czechia_payroll cp 
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'
GROUP BY industry_branch_code,payroll_year; -- zatim posledni pokus, asi TO funguje, ale poradi nejde po sobe, pac je TO 
-- serazene podle average value a krome toho tam nemam zatim CASE-end


SELECT max(avg_value)
FROM 
(SELECT  industry_branch_code,payroll_year,avg(value) AS avg_value
FROM czechia_payroll cp 
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'
GROUP BY industry_branch_code,payroll_year) AS xyz;

-- --------------
select worker_id, avgsal 
from 
(
  select worker_id, avg(salary) as avgsal 
  from workers 
  group by worker_id
) 
where avgsal=(select  max(avgsal) 
              from (select worker_id, avg(salary) as avgsal 
                    from workers group by worker_id))




select max(avg_salary)
from (select worker_id, avg(salary) AS avg_salary
      from workers
      group by worker_id) As maxSalary;



SELECT * 
FROM czechia_payroll_value_type cpvt;

SELECT *
FROM czechia_payroll_industry_branch cpib;

SELECT *
FROM czechia_price cp;


SELECT *
FROM czechia_payroll_unit cpu;

SELECT *
FROM czechia_payroll cp;
