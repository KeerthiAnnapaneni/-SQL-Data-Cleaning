select * from layoffs;

-- 1) remove duplicates
-- 2) standardize the data
-- 3) null values or blank values
-- 4) remove any colums

CREATE TABLE layoffs_staging LIKE  layoffs;

SELECT * FROM layoffs_staging;

INSERT layoffs_staging SELECT * FROM layoffs;

-- REMOVING DUPLICATES 

SELECT * ,
ROW_NUMBER () OVER (
partition by company, industry, total_laid_off , percentage_laid_off, 'date') AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT * ,
ROW_NUMBER () OVER (
partition by company, location, industry, total_laid_off , percentage_laid_off, 'date', stage, country
,funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num >1;

SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

DELETE
FROM duplicate_cte
WHERE row_num >1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL, 
  `ROW_NUM` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT * ,
ROW_NUMBER () OVER (
partition by company, location, industry, total_laid_off , percentage_laid_off, 'date', stage, country
,funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT * 
FROM layoffs_staging2
WHERE row_num >1 ;

SET SQL_SAFE_UPDATES=0;      -- COMMAND TO TURN ON DELECT QUERY

DELETE           -- HERE WE DELETED ALL ROW_NUM VALUES  1
FROM layoffs_staging2
WHERE row_num >1 ;

SELECT * 
FROM layoffs_staging2;

-- 2) Standardizing data

SELECT DISTINCT Company, TRIM(company)   -- trim helps to remove white space 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET Company = TRIM(company) ;  -- here we are assinging TRAIM(company) to comapny.

SELECT Company, TRIM(company) 
FROM layoffs_staging2;

-- now, its time for industry

SELECT distinct INDUSTRY
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'CRYPTO%';

UPDATE layoffs_staging2
SET industry = 'Crypto' WHERE industry LIKE 'CRYPTO%';

-- its time for location

Select distinct location FROM layoffs_staging2
order by 1;

-- its time for country

Select distinct country FROM layoffs_staging2
order by 1;

SELECT DISTINCT TRIM(TRAILING '.' FROM country) AS country  -- with the help of trailing we removed . after united states
FROM layoffs_staging2;


UPDATE layoffs_staging2 -- we updated here
SET Country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- ITS TIME FOR DATE

SELECT * FROM layoffs_staging2;

SELECT `date` FROM layoffs_staging2;  -- date is in text formate , now we have to change it into date formate

SELECT `date`,
str_to_date(`DATE`, '%m/%d/%Y')  -- fuction we use to change text formate date to normal date formate
FROM layoffs_staging2;

UPDATE layoffs_staging2              -- HERE WE UPDATED THE DATE FORMATE
SET `DATE`= str_to_date(`DATE`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2   -- NOW WE MODIFED THE FORMATE
MODIFY COLUMN `DATE` DATE;

SELECT * FROM layoffs_staging2;

-- NOW FOR NULL VALES

SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE Industry = '';

SELECT *
 FROM layoffs_staging2
WHERE industry IS NULL OR  industry = '';

SELECT *
 FROM layoffs_staging2
 WHERE company = 'AIRBNB';
 
 SELECT *
 FROM layoffs_staging2
 WHERE company LIKE 'Bally%';
 
SELECT * 
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
ON T1.company = T2.company
AND T1.LOCATION = T2.LOCATION
WHERE (T1.INDUSTRY IS NULL OR T1.INDUSTRY = '') 
AND T2.industry IS NOT NULL;

SELECT T1.INDUSTRY , T2.INDUSTRY
FROM layoffs_staging2 T1
JOIN layoffs_staging2 T2
ON T1.company = T2.company
AND T1.LOCATION = T2.LOCATION
WHERE (T1.INDUSTRY IS NULL OR T1.INDUSTRY = '') 
AND T2.industry IS NOT NULL;

UPDATE layoffs_staging2 T1
JOIN layoffs_staging2 T2
ON T1.company = T2.company
SET T1.INDUSTRY = T2.INDUSTRY
WHERE T1.INDUSTRY IS NULL  
AND T2.industry IS NOT NULL;

SELECT *
 FROM layoffs_staging2;
 
SELECT * 
FROM layoffs_staging2 -- HERE BOTH ARE NULL VALUES .
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

DELETE                          -- AS BOTH AREE NULL VALUES ARE ARE DELETING THEM.
FROM layoffs_staging2
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging2;     -- OUR FINAL TABLE WITH ROW_NUM
 
-- NOW WE HAVE TO REMOVE ROM_NUM TABLE


ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;     -- THIS IS OUR FINAL AND CLEANED DATA.




































