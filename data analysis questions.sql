##data analysis
use flight_analysis;
#route wise flight analysis

select 
     f.origin_airport_id,
     f.dest_airport_id,
     a1.city_name as origin_city,
     a2.city_name as desi_city,
	  sum(fm.passengers) as total_passengers
from flight f
join flightmetrics fm on f.flight_id = fm.flight_id
join airport a1 on f.origin_airport_id = a1.airport_id
join airport a2 on f.dest_airport_id = a2.airport_id
group by f.origin_airport_id, f.dest_airport_id
order by total_passengers desc
limit 100;

#total passengers served in the duration 

select
	f.year,
    f.month,
    round(sum(fm.passengers)/1000000,2) as total_passengers
    from flight f
    join flightmetrics fm on f.flight_id = fm.flight_id
    group by f.year, f.month
    order by f.year, f.month;
    
## average passengers per origin city

select
    f.origin_airport_id,
    a.city_name as origin_city,
    count(f.flight_id) as total_flight,
    sum(fm.passengers) as total_passengers,
    round(avg(fm.passengers),2) as avg_passengers_per_flight
from flight f
join flightmetrics fm on f.flight_id = fm.flight_id
join airport a on f.origin_airport_id = a.airport_id
group by f.origin_airport_id
order by avg_passengers_per_flight desc;

## average passengers per destination city

select
    f.dest_airport_id,
    a.city_name as dest_city,
    count(f.flight_id) as total_flight,
    sum(fm.passengers) as total_passengers,
    round(avg(fm.passengers),2) as avg_passengers_per_flight
from flight f
join flightmetrics fm on f.flight_id = fm.flight_id
join airport a on f.dest_airport_id = a.airport_id
group by f.dest_airport_id
order by avg_passengers_per_flight desc
limit 10;

