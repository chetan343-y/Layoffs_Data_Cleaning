-- Data Cleaning

Select *
from layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove Any Columns

Create Table Layoffs_staging
Like layoffs;

select * from layoffs_staging;

insert Layoffs_staging 
select *
from layoffs;

select * , row_number() Over( 
partition by company,industry,total_laid_off,percentage_laid_off,'date')
AS  row_num
 from layoffs_staging;

with duplicate_cte as(
select * , row_number() Over( 
partition by company,location,industry,total_laid_off,percentage_laid_off,'date',country,funds_raised_millions)
AS  row_num
 from layoffs_staging
)
select * 
from duplicate_cte
where row_num>1;

with duplicate_cte as(
select * , row_number() Over( 
partition by company,location,industry,total_laid_off,percentage_laid_off,'date',country,funds_raised_millions)
AS  row_num
 from layoffs_staging
)
delete 
from duplicate_cte
where row_num>1;

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
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

Insert into layoffs_staging2
select * , row_number() Over( 
partition by company,industry,total_laid_off,percentage_laid_off,'date')
AS  row_num
 from layoffs_staging;
 
 select * from layoffs_staging2 where row_num >1;
 
 delete 
 from layoffs_staging2
 where row_num >1;
 
 select *
  from layoffs_staging2
 where row_num >1;
 
 select *
  from layoffs_staging2;
  
  -- Standardizing Data
  
select distinct(trim(company))
  from layoffs_staging2;
  
  select company,trim(company)
  from layoffs_staging2;
  
update layoffs_staging2
set company=trim(company);

  select distinct industry
  from layoffs_staging2
  order by 1;
  
   select *
  from layoffs_staging2
  where industry like 'Crypto%' ;
  
  update layoffs_staging2
  set industry ='Crypto'
  where industry like 'Crypto%';
  
    select distinct industry
  from layoffs_staging2
  order by 1;
  
    select distinct location
  from layoffs_staging2
  order by 1;
  
    select distinct country
  from layoffs_staging2
  order by 1;
  
      select distinct country,trim(trailing '.' from country)
  from layoffs_staging2
  order by 1;
  
  update layoffs_staging2
  set country = Trim(trailing '.' from country)
  where country like 'United States%';
  
      select distinct country,trim(trailing '.' from country)
  from layoffs_staging2
  order by 1;
  
  select `date`,
  str_to_date(`date`,'%m/%d/%Y')
  from layoffs_staging2;
  
  update layoffs_staging2
  set `date`=  str_to_date(`date`,'%m/%d/%Y');
  
  alter table layoffs_staging2
  modify column `date` date;
  
  select * 
  from layoffs_staging2;

 select *
 from layoffs_staging2
 where total_laid_off Is Null and percentage_laid_off is null ;
 
 select *
 from layoffs_staging2
 where
 industry is null or industry='';
 
 update layoffs_staging2
 set industry=null
 where industry='';
 
 select *
 from layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company=t2.company
 where (t1.industry is null or t1.industry='')
 and t2.industry is not null;
 
 
update layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company=t2.company
 set t1.industry=t2.industry
  where (t1.industry is null or t1.industry='')
 and t2.industry is not null;
 
 select *
 from layoffs_staging2 where company='Airbnb';
 
  select *
 from layoffs_staging2 where company='Ba%';
 
  select *
 from layoffs_staging2
 where total_laid_off Is Null and percentage_laid_off is null ;

delete from layoffs_staging2
 where total_laid_off Is Null and percentage_laid_off is null ;

  select *
 from layoffs_staging2
 where total_laid_off Is Null and percentage_laid_off is null ;
 
   select *
 from layoffs_staging2 ;
 
 alter table layoffs_staging2
 drop column row_num;
 
    select *
 from layoffs_staging2 ;
 
 -- EDA (Explodatory Data Analysis)
 
   select *
 from layoffs_staging2 ;
 
   select max(total_laid_off),max(percentage_laid_off)
 from layoffs_staging2 ;
 
 select * 
 from layoffs_staging2 
 where percentage_laid_off=1
 order by funds_raised_millions Desc;
 
 select company,sum(total_laid_off)
 from layoffs_staging2
 group by company
 order by 2 desc;
 
 select min(`date`),Max(`date`)
 from layoffs_staging2;
 
  select industry,sum(total_laid_off)
 from layoffs_staging2
 group by industry
 order by 2 desc;
 
   select *
 from layoffs_staging2 ;
 
  select country,sum(total_laid_off)
 from layoffs_staging2
 group by country
 order by 2 desc;
 
  select `date`,sum(total_laid_off)
 from layoffs_staging2
 group by `date`
 order by 1 desc;
 
  select year(`date`),sum(total_laid_off)
 from layoffs_staging2
 group by year(`date`)
 order by 1 desc;
 
   select stage,sum(total_laid_off)
 from layoffs_staging2
 group by stage
 order by 2 desc;
 
   select company,sum(total_laid_off)
 from layoffs_staging2
 group by company
 order by 2 desc;
 
  select substring(`date`,1,7) as `month` ,sum(total_laid_off)
 from layoffs_staging2
 where substring(`date`,1,7) is not null
 group by `month` 
 order by 1 asc;
 
with Rolling_total as(
select substring(`date`,1,7) as `month` ,sum(total_laid_off) as total_off
 from layoffs_staging2
 where substring(`date`,1,7) is not null
 group by `month` 
 order by 1 asc
 )
 select `month`,total_off, sum(total_off) Over(order by `month`) as rolling_total
 from Rolling_total;
 
  select company,sum(total_laid_off)
 from layoffs_staging2
 group by company
 order by 2 desc;
 
  select company,Year(`date`),sum(total_laid_off)
 from layoffs_staging2
 group by company,Year(`date`)
 order by 2 desc;
 
 with Company_year (company,years,total_laid_off) as(
 select company,Year(`date`),sum(total_laid_off)
 from layoffs_staging2
 group by company,Year(`date`)
 ),Company_Year_rank as(
 select * ,dense_rank() over(partition by years order by total_laid_off desc) as ranking
 from Company_year
 where years is not null
 order by ranking asc)
 select *
 from Company_Year_rank
 where Ranking <=5;
 