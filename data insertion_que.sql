insert ignore into airline(airline_id, unique_carrier, unique_carrier_name, unique_carrier_entity )
select distinct
	airline_id,
    unique_carrier,
    unique_carrier_name,
    unique_carrier_entity
from meta_data  
where airline_id is not null;

select count(distinct airline_id) from airline;  
select * from airline;
 

#origin airport
insert ignore into airport (airport_id, airport_seq_id, city_market_id, airport_code, city_name, state_abr, state_fips, state_nm, wac)
select distinct
    origin_airport_id,
    origin_airport_seq_id,
    origin_city_market_id,
    origin,
    origin_city_name,
    origin_state_abr,
    origin_state_fips,
    origin_state_nm,
    origin_wac
from meta_data
where origin_airport_id is not null;

select * from airport;


#dest/desi airport
insert ignore into airport (airport_id, airport_seq_id, city_market_id, airport_code, city_name,
                      state_abr, state_fips, state_nm, wac)
select distinct
    dest_airport_id,
    dest_airport_seq_id,
    dest_city_market_id,
    dest,
    dest_city_name,
    dest_state_abr,
    dest_state_fips,
    dest_state_nm,
    dest_wac
from meta_data
where dest_airport_id not in (
    select airport_id from airport
);

select * from airport;  


##
DROP TABLE IF EXISTS flightmetrics;
DROP TABLE IF EXISTS flight;

create table flight(
    flight_id int auto_increment primary key,
    airline_id int,
    origin_airport_id int,
    dest_airport_id int,
    distance float,
    distance_group int,
    year int,
    quarter int,
    month int,
    class char(1),
    foreign key (airline_id) references airline(airline_id),
    foreign key (origin_airport_id) references airport(airport_id),
    foreign key (dest_airport_id) references airport(airport_id)
);

#insert into flights
insert into flight (airline_id, origin_airport_id, dest_airport_id, distance, distance_group,
                    year, quarter, month, class)
select
    airline_id,
    origin_airport_id,
    dest_airport_id,
    distance,
    distance_group,
    year,
    quarter,
    month,
    class
from meta_data;

select * from flight; 
SELECT COUNT(*) FROM flight;

insert into flightmetrics(
    flight_id, passengers,freight, mail)
select
    f.flight_id,
    NULLIF(REGEXP_REPLACE(m.passengers, '[^0-9.]', ''), '') + 0,
    NULLIF(REGEXP_REPLACE(m.freight, '[^0-9.]', ''), '') + 0,
    NULLIF(REGEXP_REPLACE(m.mail, '[^0-9.]', ''), '') + 0
from meta_data m
join flight f
  on f.airline_id = m.airline_id
 and f.origin_airport_id = m.origin_airport_id
 and f.dest_airport_id = m.dest_airport_id
 and f.year = m.year
 and f.quarter = m.quarter
 and f.month = m.month
 and f.distance = m.distance;
 
 select * from flightmetrics;
 select count(*) from flightmetrics;
 

insert into city (cityname,state_abr,state_nm)
select distinct
    city_name,
    state_abr,
    state_nm
from airport;

select * from airport;
select * from city;

