create database flight_analysis;
use flight_analysis;
select * from meta_data;

create table airline(
airline_id int primary key,
unique_carrier varchar(10),
unique_carrier_name varchar(100),
unique_carrier_entity varchar(10)
);

create table airport(
airport_id int primary key,
airport_seq_id int,
city_market_id int,
airport_code varchar(10),
city_name varchar(100),
state_abr char(2),
state_nm varchar(100),
wac int
);

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

drop table if exists flightmetrics;
create table flightmetrics(
flight_id int,
passengers float,
freight float,
mail float,
foreign key(flight_id) references flight(flight_id)
);

drop table if exists city;
create table city(
city_id int auto_increment primary key,
cityname varchar(100),
state_abr char(2),
state_nm  varchar (100)
);
