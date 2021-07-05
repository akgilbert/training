select
email_group
, count(*)
from
(select 
first_name 
, last_name
, email
, case when segment = 'red' and (open_rate > .3 or click_rate > .3) 
    then 'email_weekly' 
  when open_rate > .3  or click_rate > .3
    then 'email_daily'
  when segment in ('blue','green') 
    then 'email_monthly'
  else 'remove_from_list' end as email_group
from 
  emails 
left join
  rates
using(id)  
left join
  segments
using(id)
) email_group
group by 1
;
