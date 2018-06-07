--test data
select * from emails limit 10 ; 
select * from rates limit 10 ; 
select * from segments limit 10 ; 

select count(*), count(id), count(distinct id) from emails ; 
select count(*), count(id), count(distinct id)  from rates ; 
select count(*), count(id), count(distinct id)  from segments ; 

--grab just the names and emails from the email table
select first_name, last_name, email
from emails 
; 

--order by first and last names
select first_name, last_name, email
from emails 
order by 1,2
; 

--get a list of all people with the first name 'Sunshine'
select first_name, last_name, email
from emails 
where first_name = 'Sunshine'
; 


--now count the 'Sunshine's
select count(*)
from emails 
where first_name = 'Sunshine'
; 


--what about first names starting with 'S' 
select count(*)
from emails 
where left(first_name,1) = 'S'
; 

--and rename this new column
select count(*) as s_first_names
from emails 
where left(first_name,1) = 'S'
; 


--parse the emails to find the domains
select position('@' in email) as email_start
, length(email) as email_char_length
, right(email, length(email) - position('@' in email)) as email_domain
, email
from emails 
limit 10
; 

--find the most popular email domains
select 
right(email, length(email) - position('@' in email)) as email_domain
, count(*)
from emails 
group by 1
order by 2 desc
; 

--switch gears, lets test out joins
select 
*
from 
  emails 
left join
  rates
on emails.id = rates.id
;

--or you could write this:
select 
*
from 
  emails e
left join
  rates r
on e.id = r.id
;

--or this:
select 
*
from 
  emails 
left join
  rates
using(id)
; 

--look at open and click rates by gender:
select 
gender
, avg(open_rate) as avg_open_rate
, avg(click_rate) as avg_click_rate
from 
  emails 
left join
  rates
using(id)
group by 1
; 

--clean up the averages a bit using round and concat
select 
gender
, concat(round(avg(open_rate)*100,0),'%') as avg_open_rate
, concat(round(avg(click_rate)*100,0),'%') as avg_click_rate
from 
  emails 
left join
  rates
using(id)
group by 1
; 

--add on the final table: segments
select 
*
from 
  emails 
left join
  rates
using(id)  
left join
  segments
using(id)
; 

--get a first, last, email for all people with an open rates > 30% or click rate > 30% in the red segment
select 
first_name 
, last_name
, email
from 
  emails 
left join
  rates
using(id)  
left join
  segments
using(id)
where segment = 'red' 
and (open_rate > .3 or click_rate > .3)
; 

--using a case statement, make this group to email weekly and if not email monthly
select 
first_name 
, last_name
, email
, case when segment = 'red' 
and (open_rate > .3 or click_rate > .3) then 'email_weekly' else 'email_monthly' end
from 
  emails 
left join
  rates
using(id)  
left join
  segments
using(id)
; 

--add a few more layers of logic with the case statement
select 
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
; 

--finally count how many people are in each group with a subquery
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




