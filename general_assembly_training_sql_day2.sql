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
where county = 'Mason City'
limit 10
;
