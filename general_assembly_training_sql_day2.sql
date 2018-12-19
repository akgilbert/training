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




