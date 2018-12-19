--Joins Guided Practice

--Our first join :)
SELECT 
	b.store, 
	a.item, 
	a.total								
FROM 
	sales a									
INNER JOIN stores b

	ON a.store = b.store;


--Use Inner to Connect Sales to Products
--Planning: Connecting field: sales.item and products.item_no

--Variation 1:
select 
*
from sales
inner join products
on sales.item = products.item_no
limit 10 ;

--Variation 2 with specific column names and aliases:
select 
p.item_no
, p.item_description
, s.total
from sales s
inner join products p
on s.item = p.item_no
limit 1000 ;

--Mason City example:
select distinct
sa.description
, sa.category_name
, st.store_address
from sales sa
inner join stores st
using (store)
where county = 'Cerro Gordo'
limit 10
;


--Joins Independent Practice

/*Using Sales as our primary table, create links to all of the other tables in the 
Iowa Liquor Sales Database. The result should be one query with several JOINs. 

Before going into SQL, practice wireframing your JOINs on a piece of paper.

Your query should:
Include county from the County table, store from the Stores table, store name from the 
Stores table, item name, case_cost from the Products table, and total from the Sales table. 

Limit results to 1,000.*/

select distinct b.county, d.store, d.name, c.item_description, c.case_cost, a.total
from sales a
inner join counties b
on a.county = b.county
inner join products c
on a.item = c.item_no
inner join stores d
on a.store = d.store
order by d.store
limit 1000 
;

/*Your query should:
List the store number (from Sales), category_name (from Sales), 
and two aggregated columns: average bottle_price (from Products) and average total price (from Sales). 
Use a compounded WHERE clause to limit the calculations to the sales of tequila (category_name from Sales) from active stores in Mason City, Iowa.
Group and sort the data by the store number.
*/

select 
c.store
, a.category_name
, round(avg(cast(b.bottle_price as dec)),2) as avg_bottle_price
, round(avg(a.total),2) as avg_total_sales
from sales a
inner join products b
on a.item = b.item_no
inner join stores c
on a.store = c.store
where a.category_name = 'TEQUILA' and c.store_status = 'A' and a.county = 'Cerro Gordo'
group by c.store, a.category_name --or use 1,2
order by c.store --or use 1
limit 10
;

	    
--multiple joins guided practice:

--“We want to see all of the information we can get on inactive stores (if there are any) for sales, as well as their addresses.”
	    
select *
from
    sales a
right join
    stores b
on a.store = b.store
where b.store_status = 'I'
limit 10 ; 
	
--or:
select *
from
    stores b
left join
    sales a
on a.store = b.store
where b.store_status = 'I'
limit 10 ; 

