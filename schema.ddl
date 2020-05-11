
drop schema if exists vacationschema cascade; 
create schema vacationschema;
set search_path to vacationschema;

-- Guest Information
CREATE TABLE Guest (
  guest_id integer PRIMARY KEY,
  name varchar NOT NULL,
  address varchar NOT NULL,
  dob date
) ;

-- Property Information Table
CREATE TABLE Property (
  property_id integer PRIMARY KEY,
  host_id integer NOT NULL,
  bedrooms integer NOT NULL,
  bathrooms integer NOT NULL,
  capacity integer NOT NULL,
  address varchar NOT NULL,
  hottub boolean default false,
  sauna boolean default false,
  laundry boolean default false,
  dailyclean boolean default false,
  concierge boolean default false,
  breakfast boolean default false,
  CHECK (capacity >= bedrooms)
) ;

-- Walkability Score Allowed Range
CREATE DOMAIN walk AS smallint 
   DEFAULT NULL
   CHECK (VALUE >= 0 AND VALUE <= 100);

-- Transit type
CREATE DOMAIN transit AS varchar 
   DEFAULT NULL
   CHECK (VALUE IN ('bus', 'LRT', 'subway'));

-- City Type Information
CREATE TABLE City (
  property_id integer NOT NULL PRIMARY KEY REFERENCES Property,
  walkability_score walk NOT NULL,
  closest_transit varchar NOT NULL
) ;

-- Water Type Property Information
CREATE TABLE Water(
  property_id integer NOT NULL PRIMARY KEY REFERENCES Property,
  beach boolean default false,
  beach_lifeguarding boolean default false,
  lake boolean default false,
  lake_lifeguarding boolean default false,
  pool boolean default false,
  pool_lifeguarding boolean default false
) ;

-- Saturday to Week Mapping
CREATE TABLE SaturdayToWeek(
  week_id integer NOT NULL,
  saturday timestamp NOT NULL,
  PRIMARY KEY(week_id, saturday)
) ;

-- Property Prices By Week
CREATE TABLE Price(
  property_id integer NOT NULL REFERENCES Property,
  week_id integer NOT NULL,
  per_week_price real NOT NULL,
  PRIMARY KEY(property_id, week_id)
) ;

-- Guest Credit Card Information 
CREATE TABLE CreditCard(
  guest_id integer REFERENCES Guest,
  card_number bigint NOT NULL
) ;

-- Property Renter Information
CREATE TABLE RentForRenter (
  rental_id integer NOT NULL PRIMARY KEY,
  guest_id integer NOT NULL REFERENCES Guest,
  property_id integer NOT NULL REFERENCES Property,
  firstdate timestamp NOT NULL,
  weeks integer NOT NULL
) ;

-- Property Rental Guests
CREATE TABLE RentForAllGuests(
  rental_id integer NOT NULL REFERENCES RentForRenter, 
  guest_id integer NOT NULL REFERENCES Guest,
  PRIMARY KEY (rental_id, guest_id)
) ;

-- Host Information
CREATE TABLE Host(
  host_id integer NOT NULL PRIMARY KEY,
  email varchar NOT NULL
) ;

-- Rating Score Allowed Range 
CREATE DOMAIN score AS smallint 
   DEFAULT NULL
   CHECK (VALUE >= 1 AND VALUE <= 5);

-- Property Rating Information
CREATE TABLE PropertyRating(
  rating_id integer NOT NULL PRIMARY KEY,
  rental_id integer NOT NULL REFERENCES RentForRenter,
  guest_id integer NOT NULL REFERENCES Guest,
  rating_property score NOT NULL
) ;

-- Property Rating Comment
CREATE TABLE Comment(
  rating_id integer NOT NULL PRIMARY KEY REFERENCES PropertyRating,
  comment varchar NOT NULL
) ;

-- Host Rating Information
CREATE TABLE HostRating(
  rental_id integer NOT NULL PRIMARY KEY REFERENCES RentForRenter,
  guest_id integer NOT NULL,
  rating_host score NOT NULL
) ;
