

SET SEARCH_PATH TO vacationschema;
drop table if exists q2 cascade;

create table q2(
  whether_at_capacity varchar,
  total_number INTEGER,
  average_rating FLOAT
);


DROP VIEW IF EXISTS Capacity CASCADE;
-- all the at capacity rentals
CREATE VIEW Capacity AS
  SELECT rg.rental_id
  FROM Property pp,RentForRenter rr, RentForAllGuests rg
  WHERE rr.rental_id = rg.rental_id AND rr.property_id = pp.property_id
  GROUP BY rg.rental_id
  HAVING  count(rg.guest_id) = max(pp.capacity);


DROP VIEW IF EXISTS NumCapa CASCADE;
-- number of at capacity rentals
CREATE VIEW NumCapa AS
  SELECT count(rental_id) as total_number
  FROM Capacity ;



DROP VIEW IF EXISTS AvgCapaRating CASCADE;
-- average property rating for at capacity rentals
CREATE VIEW AvgCapaRatig AS
  SELECT avg(pr.rating_property) as average_rating
  FROM Capacity cp,PropertyRating pr
  WHERE cp.rental_id = pr.rental_id;




DROP VIEW IF EXISTS Lower CASCADE;
-- all not at capacity rentals
CREATE VIEW Lower AS
  (SELECT rental_id from RentForAllGuests)
  EXCEPT
  (SELECT rental_id FROM Capacity);


DROP VIEW IF EXISTS Capa CASCADE;
-- average property rating and total number for at capacity rentals
CREATE VIEW Capa AS
  SELECT  np.total_number as tota_number, 'At Capacity' as whether_at_capacity, cp.average_rating as average_rating
  FROM avgCapaRatig cp, numCapa np;


DROP VIEW IF EXISTS NumLower CASCADE;
-- number of below  capacity rentals
CREATE VIEW NumLower AS
  SELECT count(rental_id) as total_number
  FROM Lower ;


DROP VIEW IF EXISTS AvgLowerRating CASCADE;
-- average property rating for below capacity rentals
CREATE VIEW AvgLowerRatig AS
  SELECT avg(pr.rating_property) as average_rating
  FROM Lower lo,PropertyRating pr
  WHERE lo.rental_id = pr.rental_id;


DROP VIEW IF EXISTS Below CASCADE;
-- average property rating and total number for below capacity rentals
CREATE VIEW Below AS
  SELECT  nl.total_number as tota_number,'Below Capacity' as whether_at_capacity,lp.average_rating as average_rating
  FROM numLower nl, avgLowerRatig lp;


DROP VIEW IF EXISTS Answer2 CASCADE;
-- at and below capacity rentals' total number and average rating
CREATE VIEW Answer2 AS
  (SELECT whether_at_capacity, Capa.tota_number, average_rating
  FROM Capa)
  UNION
  (SELECT whether_at_capacity, Below.tota_number, average_rating
   FROM Below);


insert into q2
  SELECT *
  From Answer2;

select * from q2;


