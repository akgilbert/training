--string functions guided practice

--concat example
SELECT item
, description
, concat(item, description) as concat_sample1
, concat(item, ' - ', description) as concat_sample2
FROM sales
LIMIT 100;

--Sample functions as used in join
SELECT *
FROM sales s
INNER JOIN counties c
ON trim(upper(s.county)) = trim(upper(c.county))
LIMIT 10 ; 

--Sample function in where
SELECT *
FROM products
where lower(category_name) = 'tequila'
LIMIT 10 ; 

--length example
SELECT item
, description
, concat(item, ' - ', description) as concat_sample
, length(concat(item, ' - ', description)) as concat_length
FROM sales
LIMIT 100;

--sample replace
SELECT replace(description, 'Absolut', 'Grey Goose') as corrected_description
FROM sales
LIMIT 100;

--sample replace 2
SELECT item
, description
, concat(item, ' - ', description) as concat_sample
, replace(concat(item, ' - ', description), '-', '|') as replace_sample
FROM sales
LIMIT 100;

--replace + length example
SELECT LENGTH('the quick brown fox jumped over the lazy dog')
    - LENGTH(REPLACE('the quick brown fox jumped over the lazy dog',' ','')) ; 

--upper & lower example
SELECT item
, description
, concat(item, ' - ', description) as concat_sample
, upper(concat(item, ' - ', description)) as upper_sample
, lower(concat(item, ' - ', description)) as lower_sample
FROM sales
LIMIT 100;

--left example
SELECT item
, description
, concat(item, ' - ', description) as concat_sample
, left(concat(item, ' - ', description), 5) as left_sample
FROM sales
LIMIT 100
;

--right example
SELECT item
, description
, concat(item, ' - ', description) as concat_sample
, length(concat(item, ' - ', description)) as total_lenght_count
, length(concat(item, ' - ', description)) - 8 as right_most_count
, right(concat(item, ' - ', description), length(concat(item, ' - ', description)) - 8) as right_sample
FROM sales
LIMIT 100
;

--trim example
SELECT item
, description
, concat(item, ' - ', description) as concat_sample
, substring(concat(item, ' - ', description), 7, 1) as substring_example1
, substring(concat(item, ' - ', description), 9, 5) as substring_Example2
, trim(substring(concat(item, ' - ', description), 9, 5)) as trim_example
, rtrim(substring(concat(item, ' - ', description), 9, 5)) as rtrim_example
FROM sales
LIMIT 100
;

                  
--date functions!
                  
--current_date
--extract(date_part from field1)
--age

--what year is the data set from?
select distinct extract(year from date) as year
from sales 
limit 10 ; 

--what about the months?
select distinct 
extract(year from date) as year
, extract(month from date) as month
from sales 
order by 1,2 ; 

--what is the current date?
--select 1 ; 
--select 'quick fox' ; 
select current_date ; 

--what is yesterday's date?
select current_date - 1 as yesterday ;  

--what month are we in?
select extract(month from current_date) ; 

--age sample
select date 
, current_date
, age(current_date, date)
from sales 
limit 10 ; 

                  
--case statements!

---what is the averages sales of products with fruit in their name (apple, berry, or orange) 
	---vs no fruit in their name?

SELECT 
CASE WHEN description ILIKE '%Apple%' OR description ILIKE '%Berry%' 
			OR description ILIKE '%Orange%' OR description ILIKE '%Pear%'  
		THEN 'Fruit Product'
	ELSE 'Not Fruit Product'
END AS fruit_category
, ROUND(AVG(total),2) as avg_sales
, COUNT(*) as sales_count
FROM sales
GROUP BY 1
LIMIT 100 ; 


SELECT 
CASE WHEN description ILIKE '%Apple%' OR description ILIKE '%Berry%' 
			OR description ILIKE '%Orange%' OR description ILIKE '%Pear%'  
		THEN 'Fruit Product'
	ELSE 'Not Fruit Product'
END AS fruit_category
, description
, avg(total)
FROM sales
group by 1,2
LIMIT 100 ; 





---what is the average sales in large, small and medium counties in iowa?
SELECT *
FROM counties
;

--large: > 100000
--medium: > 10000
--small: everything else, <= 10000

SELECT
CASE WHEN population > 100000
	THEN 'Large'
WHEN population > 10000
	THEN 'Medium'
ELSE 'Small'
END AS county_size
, *
FROM counties
;

SELECT *
FROM sales s
INNER JOIN counties c
USING (county)
LIMIT 10 ; 


SELECT 
CASE WHEN population > 100000
	THEN 'Large'
WHEN population > 10000
	THEN 'Medium'
ELSE 'Small'
END AS county_size
, round(avg(total),2) as average_sales
FROM sales s
INNER JOIN counties c
USING (county)
GROUP BY 1
ORDER BY 2 desc
LIMIT 10 ; 



