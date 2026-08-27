use flight_analysis;

#cities as origin
select
    c.cityname,
    c.population,
    sum(fm.passengers) as total_passengers
from city_new c 
join airport a on a.cityname = c.cityname
join flight f on f.origin_airport_id = a.airport_id
join flightmetrics fm on f.flight_id = fm.flight_id
group by c.cityname,c.population
order by total_passengers desc;

select * from city_new;
use flight_analysis;

select
    c.cityname,
    c.population,
    sum(fm.passengers) as total_passengers
from city_new c
join airport a on a.city_name = c.cityname
join flight f on f.origin_airport_id = a.airport_id
join flightmetrics fm on f.flight_id = fm.flight_id
group by c.cityname, c.population
order by total_passengers desc;

select
    c.cityname,
    c.population,
    sum(fm.passengers) as total_passengers
from city c
join airport a on a.city_name like concat('%', trim(c.cityname), '%')
join flight f on f.origin_airport_id = a.airport_id
join flightmetrics fm on f.flight_id = fm.flight_id
group by c.cityname, c.population
order by total_passengers desc;


select *from airport;

set sql_safe_updates = 0;

update airport
set city_name = substring_index(city_name,',',1);

select
    c.cityname,
    c.population,
    sum(fm.passengers) as total_passengers,
    round(sum(fm.passengers)/c.population,2) as pass_pop_ratio
from city c
join airport a on a.city_name like concat('%', trim(c.cityname), '%')
join flight f on f.origin_airport_id = a.airport_id
join flightmetrics fm on f.flight_id = fm.flight_id
group by c.cityname, c.population
order by pass_pop_ratio desc;

#cities as destination

select
    c.cityname,
    c.population,
    sum(fm.passengers) as total_passengers
from city_new c 
join airport a on a.cityname = c.cityname
join flight f on f.dest_airport_id = a.airport_id
join flightmetrics fm on f.flight_id = fm.flight_id
group by c.cityname,c.population
order by total_passengers desc;



select
    c.cityname,
    c.population,
    sum(fm.passengers) as total_passengers
from city c
join airport a on a.city_name like concat('%', trim(c.cityname), '%')
join flight f on f.dest_airport_id = a.airport_id
join flightmetrics fm on f.flight_id = fm.flight_id
group by c.cityname, c.population
order by total_passengers desc;


select *from airport;

set sql_safe_updates = 0;

update airport
set city_name = substring_index(city_name,',',1);

select
    c.cityname,
    c.population,
    sum(fm.passengers) as total_passengers,
    round(sum(fm.passengers)/c.population,2) as pass_pop_ratio
from city c
join airport a on a.city_name like concat('%', trim(c.cityname), '%')
join flight f on f.dest_airport_id = a.airport_id
join flightmetrics fm on f.flight_id = fm.flight_id
group by c.cityname, c.population
order by pass_pop_ratio desc;