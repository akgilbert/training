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






