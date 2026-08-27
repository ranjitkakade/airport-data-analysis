### asses flight frequency and identity high-traffic corridors
# to acess flight frequancy and identify high traffic corridors,we will:
# 1.count how ofen each route (origin- destination)appers - that's flight frequeancy.
# 2.identify routes with the highest number of flights- these are high-traffic corridors. 
 
select
    f.origin_airport_id,
    f.dest_airport_id,
    a1.city_name as origin_city,
    a2.city_name as dest_city,
    count(*) as flight_count
from flight f
join airport a1 on f.origin_airport_id =a1.airport_id
join airport a2 on f.dest_airport_id = a2.airport_id
group by f.origin_airport_id, f.dest_airport_id
order by flight_count desc
limit 10;

select * from flight;
select * from airport;


# compare passenger numbers across origin cities to identify the top performing airports
# total passengers and no of total flights

select 
	a.city_name as origin_city,
    sum(fm.passengers) as total_passengers,
    count(f.flight_id) as total_flights
from flight f
join flightmetrics fm on f.flight_id = fm.flight_id
join airport a on f.origin_airport_id = a.airport_id
group by a.city_name
order by total_flights desc;

#destination city

select 
	a.city_name as dest_city,
    sum(fm.passengers) as total_passengers,
    count(f.flight_id) as total_flights
from flight f
join flightmetrics fm on f.flight_id = fm.flight_id
join airport a on f.dest_airport_id = a.airport_id
group by a.city_name
order by total_passengers desc;
 
select * from city;
#correlation between population and air traffic

select substring_index(cityname,',',1) as cityname, state_abr,
state_nm, population
from city c
left join all_city_pop as a
on a.city_name = c.cityname;

update city
set cityname = substring_index(cityname,',',1);

set sql_safe_updates = 0;

select * from city;

select substring_index(cityname,',',1) as cityname, state_abr,
state_nm, population
from city c
left join all_city_pop as a
on a.city_name = c.cityname;

#create a table new_city for get population column also
create table city_new
(select city_id,substring_index(cityname,',',1) as cityname, state_abr,
state_nm, population
from city c
left join all_city_pop as a
on a.city_name = c.cityname);

select * from city_new;
select * from city_new;
