/*
 * ZadÃ¡nÃ­ projektu
Ãšvod do projektu
Na vaÅ¡em analytickÃ©m oddÄ›lenÃ­ nezÃ¡vislÃ© spoleÄ�nosti, kterÃ¡ se zabÃ½vÃ¡ Å¾ivotnÃ­ ÃºrovnÃ­ obÄ�anÅ¯, jste se dohodli, Å¾e se pokusÃ­te odpovÄ›dÄ›t na pÃ¡r definovanÃ½ch vÃ½zkumnÃ½ch otÃ¡zek, kterÃ© adresujÃ­ dostupnost zÃ¡kladnÃ­ch potravin Å¡irokÃ© veÅ™ejnosti. KolegovÃ© jiÅ¾ vydefinovali zÃ¡kladnÃ­ otÃ¡zky, na kterÃ© se pokusÃ­ odpovÄ›dÄ›t a poskytnout tuto informaci tiskovÃ©mu oddÄ›lenÃ­. Toto oddÄ›lenÃ­ bude vÃ½sledky prezentovat na nÃ¡sledujÃ­cÃ­ konferenci zamÄ›Å™enÃ© na tuto oblast.

PotÅ™ebujÃ­ k tomu od vÃ¡s pÅ™ipravit robustnÃ­ datovÃ© podklady, ve kterÃ½ch bude moÅ¾nÃ© vidÄ›t porovnÃ¡nÃ­ dostupnosti potravin na zÃ¡kladÄ› prÅ¯mÄ›rnÃ½ch pÅ™Ã­jmÅ¯ za urÄ�itÃ© Ä�asovÃ© obdobÃ­.

Jako dodateÄ�nÃ½ materiÃ¡l pÅ™ipravte i tabulku s HDP, GINI koeficientem a populacÃ­ dalÅ¡Ã­ch evropskÃ½ch stÃ¡tÅ¯ ve stejnÃ©m obdobÃ­, jako primÃ¡rnÃ­ pÅ™ehled pro ÄŒR.

DatovÃ© sady, kterÃ© je moÅ¾nÃ© pouÅ¾Ã­t pro zÃ­skÃ¡nÃ­ vhodnÃ©ho datovÃ©ho podkladu
PrimÃ¡rnÃ­ tabulky:

czechia_payroll â€“ Informace o mzdÃ¡ch v rÅ¯znÃ½ch odvÄ›tvÃ­ch za nÄ›kolikaletÃ© obdobÃ­. DatovÃ¡ sada pochÃ¡zÃ­ z PortÃ¡lu otevÅ™enÃ½ch dat ÄŒR.
czechia_payroll_calculation â€“ ÄŒÃ­selnÃ­k kalkulacÃ­ v tabulce mezd.
czechia_payroll_industry_branch â€“ ÄŒÃ­selnÃ­k odvÄ›tvÃ­ v tabulce mezd.
czechia_payroll_unit â€“ ÄŒÃ­selnÃ­k jednotek hodnot v tabulce mezd.
czechia_payroll_value_type â€“ ÄŒÃ­selnÃ­k typÅ¯ hodnot v tabulce mezd.
czechia_price â€“ Informace o cenÃ¡ch vybranÃ½ch potravin za nÄ›kolikaletÃ© obdobÃ­. DatovÃ¡ sada pochÃ¡zÃ­ z PortÃ¡lu otevÅ™enÃ½ch dat ÄŒR.
czechia_price_category â€“ ÄŒÃ­selnÃ­k kategoriÃ­ potravin, kterÃ© se vyskytujÃ­ v naÅ¡em pÅ™ehledu.
ÄŒÃ­selnÃ­ky sdÃ­lenÃ½ch informacÃ­ o ÄŒR:

czechia_region â€“ ÄŒÃ­selnÃ­k krajÅ¯ ÄŒeskÃ© republiky dle normy CZ-NUTS 2.
czechia_district â€“ ÄŒÃ­selnÃ­k okresÅ¯ ÄŒeskÃ© republiky dle normy LAU.
DodateÄ�nÃ© tabulky:

countries - VÅ¡emoÅ¾nÃ© informace o zemÃ­ch na svÄ›tÄ›, napÅ™Ã­klad hlavnÃ­ mÄ›sto, mÄ›na, nÃ¡rodnÃ­ jÃ­dlo nebo prÅ¯mÄ›rnÃ¡ vÃ½Å¡ka populace.
economies - HDP, GINI, daÅˆovÃ¡ zÃ¡tÄ›Å¾, atd. pro danÃ½ stÃ¡t a rok.
VÃ½zkumnÃ© otÃ¡zky
Rostou v prÅ¯bÄ›hu let mzdy ve vÅ¡ech odvÄ›tvÃ­ch, nebo v nÄ›kterÃ½ch klesajÃ­?
Kolik je moÅ¾nÃ© si koupit litrÅ¯ mlÃ©ka a kilogramÅ¯ chleba za prvnÃ­ a poslednÃ­ srovnatelnÃ© obdobÃ­ v dostupnÃ½ch datech cen a mezd?
KterÃ¡ kategorie potravin zdraÅ¾uje nejpomaleji (je u nÃ­ nejniÅ¾Å¡Ã­ percentuÃ¡lnÃ­ meziroÄ�nÃ­ nÃ¡rÅ¯st)?
Existuje rok, ve kterÃ©m byl meziroÄ�nÃ­ nÃ¡rÅ¯st cen potravin vÃ½raznÄ› vyÅ¡Å¡Ã­ neÅ¾ rÅ¯st mezd (vÄ›tÅ¡Ã­ neÅ¾ 10 %)?
MÃ¡ vÃ½Å¡ka HDP vliv na zmÄ›ny ve mzdÃ¡ch a cenÃ¡ch potravin? Neboli, pokud HDP vzroste vÃ½raznÄ›ji v jednom roce, projevÃ­ se to na cenÃ¡ch potravin Ä�i mzdÃ¡ch ve stejnÃ©m nebo nÃ¡sdujÃ­cÃ­m roce vÃ½raznÄ›jÅ¡Ã­m rÅ¯stem?
VÃ½stup projektu
Pomozte kolegÅ¯m s danÃ½m Ãºkolem. VÃ½stupem by mÄ›ly bÃ½t dvÄ› tabulky v databÃ¡zi, ze kterÃ½ch se poÅ¾adovanÃ¡ data dajÃ­ zÃ­skat. Tabulky pojmenujte t_{jmeno}_{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za ÄŒeskou republiku sjednocenÃ½ch na totoÅ¾nÃ© porovnatelnÃ© obdobÃ­ â€“ spoleÄ�nÃ© roky) a t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodateÄ�nÃ¡ data o dalÅ¡Ã­ch evropskÃ½ch stÃ¡tech).

DÃ¡le pÅ™ipravte sadu SQL, kterÃ© z vÃ¡mi pÅ™ipravenÃ½ch tabulek zÃ­skajÃ­ datovÃ½ podklad k odpovÄ›zenÃ­ na vytyÄ�enÃ© vÃ½zkumnÃ© otÃ¡zky. Pozor, otÃ¡zky/hypotÃ©zy mohou vaÅ¡e vÃ½stupy podporovat i vyvracet! ZÃ¡leÅ¾Ã­ na tom, co Å™Ã­kajÃ­ data.

Na svÃ©m GitHub ÃºÄ�tu vytvoÅ™te repozitÃ¡Å™ (mÅ¯Å¾e bÃ½t soukromÃ½), kam uloÅ¾Ã­te vÅ¡echny informace k projektu â€“ hlavnÄ› SQL skript generujÃ­cÃ­ vÃ½slednou tabulku, popis mezivÃ½sledkÅ¯ (prÅ¯vodnÃ­ listinu) a informace o vÃ½stupnÃ­ch datech (napÅ™Ã­klad kde chybÃ­ hodnoty apod.).

Neupravujte data v primÃ¡rnÃ­ch tabulkÃ¡ch! Pokud bude potÅ™eba transformovat hodnoty, dÄ›lejte tak aÅ¾ v tabulkÃ¡ch nebo pohledech, kterÃ© si novÄ› vytvÃ¡Å™Ã­te.


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
ORDER BY value DESC; -- tÃ­mhle jsem zjistila jednu maximÃ¡lnÃ­ hodnotu vÅ¯bec, nenÃ­ TO sice TO, co chci, ale moÅ¾nÃ¡ BY mÄ› TO mohlo nÄ›kam odpÃ­chnout

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
SELECT id,industry_branch_code,payroll_year,
avg(value) OVER (PARTITION BY industry_branch_code, payroll_year) AS avg_value,value,
min(value) OVER (PARTITION BY industry_branch_code, payroll_year) AS min_value,
max(value) OVER (PARTITION BY industry_branch_code, payroll_year) AS max_value
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'; -- joooo, melo BY mi TO vychazet stejne podle GROUP BY i WINDOW FUNCTION, velky objev!!!! asi zapsat pak i do popisu projektu, mezi cim jsem se rozhodovala

SELECT id, industry_branch_code,payroll_year,value,
avg(value) OVER (PARTITION BY industry_branch_code, payroll_year) AS avg_value,
min(value) OVER (PARTITION BY industry_branch_code, payroll_year) AS min_value,
max(value) OVER (PARTITION BY industry_branch_code, payroll_year) AS max_value
FROM czechia_payroll cp
WHERE industry_branch_code IS NOT NULL AND value_type_code ='5958'; -- dalsi pokus, ale jeste moc nevim, jestli je TO k necemu dobry









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


SELECT a.country, a.life_exp_1970 , b.life_exp_2015,
    round( b.life_exp_2015 / a.life_exp_1970, 2 ) as life_exp_ratio
FROM (
    SELECT le.country , le.life_expectancy as life_exp_1970
    FROM life_expectancy le 
    WHERE year = 1970
    ) a JOIN (
    SELECT le.country , le.life_expectancy as life_exp_2015
    FROM life_expectancy le 
    WHERE year = 2015
    ) b
    ON a.country = b.country
; -- ukazka, jak prijoinovat sloupec ze stejne tabulky



SELECT cp.id,cp2.id,cp.value,cp2.value,cp.payroll_year,cp2.payroll_year,cp.payroll_quarter,cp2.payroll_quarter 
FROM czechia_payroll cp
LEFT JOIN czechia_payroll cp2 
ON cp.id=cp2.id+1
WHERE cp.value_type_code ='5958';

SELECT *,
LAG (Value,1)
OVER (PARTITION BY industry_branch_code ORDER BY payroll_quarter) AS value_last_year
FROM czechia_payroll cp
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958';


SELECT min(id)
FROM czechia_payroll cp;


SELECT *
FROM czechia_payroll cp;





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
FROM czechia_payroll cp
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958';
-----------------------------
NOVY POKUS, ty predchozi pak promazat

1. výzkumná otázka

SELECT *,
LAG (Value,1)
OVER (PARTITION BY industry_branch_code ORDER BY id) AS value_last_year
FROM czechia_payroll cp
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958'
ORDER BY id;-- vznikl mi nový sloupec s hodnotou za predchozi rok

-- zkusim pridat novy sloupec s podminkou case, ktery by mi rekl, jestli hodnoty klesaji. jako dalsi krok bych pak jeste zkusila porovnat prumery.

SELECT *,
LAG (Value,1)
OVER (PARTITION BY industry_branch_code ORDER BY id) AS value_last_year,
CASE 
	WHEN value_last_year > value THEN 'mzda roste'
	WHEN value_last_year < value THEN 'mzda klesa'
	ELSE 'mzda zustala stejna'
END AS vyvoj_mzdy
FROM czechia_payroll cp
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958'
ORDER BY id; -- nelze, nezna TO ten sloupec value LAST YEAR... asi TO musim udelat trochu jinak

SELECT *,
LAG (Value,1)OVER (PARTITION BY industry_branch_code ORDER BY id) AS mzda_predchozi_obdobi,
CASE 
	WHEN LAG (Value,1) OVER (PARTITION BY industry_branch_code ORDER BY id) < value THEN 'mzda vzrostla'
	WHEN LAG (Value,1) OVER (PARTITION BY industry_branch_code ORDER BY id) > value THEN 'mzda klesla'
	ELSE 'mzda zustala stejna, nebo nemame blizsi informace'
END AS vyvoj_mzdy
FROM czechia_payroll cp
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958'
ORDER BY id; -- funguje TO, ale jeste zkusit nejak ucesat a overit, ze tam nejsou blbosti
-- --------------------------------------------------------------------------------------------------------
NOVY POKUS - propojeni tabulek

SELECT *
FROM czechia_payroll cp


SELECT *
FROM czechia_price cp;

SELECT cp.id,cp.value,cp.category_code,YEAR(cp.date_from),region_code
FROM czechia_price cp
ORDER BY year(cp.date_from);

SELECT *
FROM czechia_payroll cp 
LEFT JOIN czechia_price cp2
ON cp.payroll_year = YEAR(cp2.date_from)
LEFT JOIN economies e 
ON cp.payroll_year = e.`year`
WHERE cp.industry_branch_code IS NOT NULL AND cp.value_type_code ='5958' AND e.country = 'czech republic';

SELECT *
FROM czechia_payroll_calculation cpc;

SELECT *
FROM czechia_payroll_unit cpu;

SELECT country,`year` 
FROM economies e
WHERE country LIKE 'czech%'
ORDER BY `year` ;
