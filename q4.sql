SET SEARCH_PATH TO vacationschema;
drop table if exists q4 cascade;


create table q4(
  property_type varchar,
  avg_extra_guests FLOAT
);



DROP VIEW IF EXISTS ExtraGuest CASCADE;
-- number of guests who are not renters for each rent
CREATE VIEW ExtraGuest AS
  SELECT rental_id, count(num_of_guest)as num_of_guest
  FROM
  (SELECT rental_id,guest_id as num_of_guest
   FROM RentForAllGuests
  EXCEPT
  SELECT rental_id,guest_id as num_of_guest
   FROM RentForRenter ) as eg
  GROUP BY rental_id;



DROP VIEW IF EXISTS WaterGuest CASCADE;
-- water type properties average of extra guests number
CREATE VIEW WaterGuest AS
  SELECT avg(eg.num_of_guest) as avg_extra_guests,'water' AS property_type
  FROM extraGuest eg, RentForRenter rr,Water wt
  WHERE eg.rental_id = rr.rental_id AND rr.property_id = wt.property_id;



DROP VIEW IF EXISTS CityGuest CASCADE;
-- city type properties average of extra guests number
CREATE VIEW cityGuest AS
  SELECT avg(eg.num_of_guest) as avg_extra_guests,'city' AS property_type
  FROM extraGuest eg, RentForRenter rr,City ct
  WHERE eg.rental_id = rr.rental_id AND rr.property_id = ct.property_id;



DROP VIEW IF EXISTS OtherProperty CASCADE;
-- properties that are not water nor city type
CREATE VIEW OtherProperty AS
  (SELECT property_id FROM Property)
   EXCEPT
   (SELECT property_id FROM City)
   EXCEPT
   (SELECT property_id FROM Water);


DROP VIEW IF EXISTS otherGuest CASCADE;
-- other type properties average of extra guests number
CREATE VIEW otherGuest AS
  SELECT  avg(eg.num_of_guest) as avg_extra_guests,'other' AS property_type
  FROM extraGuest eg, RentForRenter rr,otherProperty op
  WHERE eg.rental_id = rr.rental_id AND rr.property_id = op.property_id;


DROP VIEW IF EXISTS Answer4 CASCADE;
CREATE VIEW Answer4 AS
  (SELECT property_type, avg_extra_guests FROM waterGuest)
  UNION
  (SELECT property_type, avg_extra_guests FROM cityGuest)
  UNION
  (SELECT property_type, avg_extra_guests FROM otherGuest);



insert into q4
  SELECT *
  From Answer4;

select * from q4;