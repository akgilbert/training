--Lesson 1 Getting Started

--Testing your database:
SELECT 1 ; 

--Selecting a table:
SELECT * 
FROM counties ;


--Lesson 1 Guided Practice

--Selecting a table with a where clause:
SELECT *
FROM counties 
WHERE population > 10000 ; 

--Selecting a different table:
select item_no, item_description
from products
limit 100
;

--Selecting specific columns:
select item_no, item_description
from products
limit 100
;

--Specific Columns with Where Clause 1 / 3:
select item_no, item_description
from products
where category_name = 'SCOTCH WHISKIES'
limit 100
;

--Specific Columns with Where Clause 2 / 3:
select item_no, item_description
from products
where category_name LIKE 'SCOTCH WHISK%'
limit 100
;

--Specific Columns with Where Clause 3 / 3:
select item_no, item_description, case_cost
from products
where case_cost >= 100
order by 2 asc
limit 100
;

--First function -- rounding:
select total as total_raw
, round(total,0) as total_rounded
from sales
limit 100
;

---Sample Aggregate 1/2:
select count(*) as total_rows
from sales
limit 100
;

--Sample Aggregate 2/2:
select count(*) as total_rows
, count(distinct county) as county_count
, sum(population) as total_population
from counties
limit 100
;

--Aggregate with where clause:
select 
count(*) as total_rows
, count(distinct county) as county_count
, sum(population) as total_population
from counties
where population > 10000
limit 100
;

---Aggregate with Group by and where clause:
select 
vendor_name
, count(*) as product_count
from products 
where category_name = 'SCOTCH WHISKIES'
group by vendor_name
limit 10 
; 

---Casting:
SELECT total as raw_total
, CAST(total as integer) as total_as_int 
FROM sales 
limit 10  
;

Lesson 1 Guided Practice

--1 - Which products come in packs larger than 12? How many unique products have less than 12 in a pack?
select count(*) from products where pack > 12 ; 

select * from products where pack > 12 limit 10 ; 

select count(distinct item_no) from products where pack > 12 limit 10 ; 
--1106 distinct products with packs larger than 12

--2 - Which products have a case price of less than $70?
select distinct category_name from products where case_cost > 70 limit 10 ; 

--removing the nulls:
select distinct category_name 
from products 
where case_cost > 70 
	and category_name is not null 
limit 10 ; 

--3 - Which products come in packs larger than 12 AND have a case_cost of less than $70?
select distinct category_name 
from products
where pack > 12
	and case_cost > 70
	and category_name is not null 
limit 10 ; 

--4 - Which types of products have a proof of 85 or higher?
select item_description
from products
where cast(proof as integer) >= 85
limit 10 ; 

--5 - Which products are scotch whiskies OR are higher than 85 proof?
select distinct item_description
from products
where cast(proof as integer) > 85
	OR category_name = 'SCOTCH WHISKIES'
limit 10 ; 

--6 - How many stores are active (use store_status)? Inactive?*/
select count(distinct name) as distinct_count
, count(name) as raw_count
from stores
where store_status = 'A' ; 
--1390 distinct
--1425 not distinct

select count(distinct name) as distinct_count
, count(name) as raw_count
from stores
where store_status = 'I' ; 
--515 distinct
--548 not distinct

select * from stores limit 10 ; 



--Lesson 2 Guided Practice

-- != 
-- 1. Which products are not from vendor ‘Jim Beam Brands’?
select item_description 
from products 
where vendor_name != 'Jim Bean Brands'
limit 10 ; 

-- >, >=
-- 2. Which products are higher than 90 proof?
select item_description
from products
where cast(proof as integer) > 90
limit 10 ;

-- <, <=
--3. Which products have a case cost of less than $60?
select item_description
from products
where case_cost < 60
limit 10 ;

--4. Which products are either single malt scotches or Canadian whiskies (based on category name)?
select distinct item_description
from products
where category_name in ('SINGLE MALT SCOTCH', 'CANADIAN WHISKIES')
--alternative: category_name = 'SINGLE MALT SCOTCH' OR category_name = 'CANADIAN WHISKIES'
limit 10 ; 

--figuring out who single malt scotch looked in the data:
select distinct category_name
from products
where category_name like '%SINGLE MALT%'
limit 10 ;

--5 - Which products have ‘whiskies’ in the category name?
select item_description
from products
where category_name like '%WHISKIES%'
limit 10 
;

select item_description
from products
where category_name ilike '%whiskies%'
limit 10 
;

--6. Which products don’t have ‘whiskies’ in the category name?
select item_description
from products
where category_name not ilike '%whiskies%'
limit 10 
;


--7. Which products have a shelf_price between $4 and $10?
select category_name, item_description, shelf_price
from products
where shelf_price between 4 and 10
limit 10 ; 

--8. Which products have a bottle_price between $4 and $10?*/
select category_name, item_description, bottle_price
from products
where bottle_price between '$4.50' and '$10.01'
limit 10 ; 


Lesson 2 Independent Practice A
--1 - Which products have a case cost of more than $100?
select category_name, item_description, case_cost
from products
where case_cost > 100
limit 10 ; 

--3 - Which tequilas or scotch whiskies have a case cost of more than $100?
select *
from products
where case_cost > 100 and category_name in ('TEQUILA', 'SCOTCH WHISKIES')
limit 10 ; 

--5 - Which whiskies of any kind cost more than $100?
select distinct item_description
from products
where category_name ilike 'whisk%' and case_cost > 100 
limit 10 ; 

--7 - Which products, excluding tequilas, cost between $100 and $120?
select distinct item_description
from products
where category_name not ilike '%TEQUILA%' and case_cost between 100 and 120 
limit 10 ; 


--logic a alternatives:
-----a: category_name not ilike '%TEQUILA%' 
-----b: category_name not ilike '%tequila%' 
-----c: category_name not ilike '%tequil%' 
-----d: category_name != 'TEQUILA'
-----e: category_name not in ('TEQUILA')
-----f: category_name not like '%TEQUILA%'



--aggregrates guided practice
select category_name
, min(case_cost) as min_case_cost
, max(case_cost) as max_case_cost
, round(avg(case_cost),2) as avg_case_cost
from products 
where category_name is not null
group by category_name
having avg(case_cost) > 100
limit 10 ; 


--what is the large sale in the iowa liquor database?
SELECT MAX(total) FROM sales;

--what is the average cost of a bottle sold in the iowa liquor database?
SELECT 
round(
	avg(
		cast(state_btl_cost as decimal)
	)
,2) 
FROM sales;

--average bottle price per vendor
select vendor, vendor_name, round(avg( cast(bottle_price as decimal) ),2)
from products
group by vendor, vendor_name
order by 3 desc
limit 10 ;

Lesson 2 Independent Practice B

SELECT vendor_name
, round(max(cast(bottle_price as dec)),2) as max_bottle_price
, round(min(cast(bottle_price as dec)),2) as min_bottle_price
FROM products
GROUP BY vendor_name
HAVING round(min(cast(bottle_price as dec)),2) > 10 --Further refine the results to those that have a minimum bottle_price of $10.
ORDER BY 2 --Sort the results by maximum bottle_price column.
LIMIT 20 --Limit the report data to the top 20.
;

