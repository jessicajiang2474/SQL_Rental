SET SEARCH_PATH TO vacationschema;
drop table if exists q3 cascade;

create table q3(
  host_id INTEGER,
  email varchar ,
  highest_avg_rating FLOAT,
  most_expensive_week FLOAT
);


DROP VIEW IF EXISTS AvgRating CASCADE;
-- the average host rating score for each host
CREATE VIEW AvgRating AS
  SELECT ht.host_id, avg(rating_host) as avg_rating,email
  FROM HostRating hr,RentForRenter rr,Property pp,Host ht
  WHERE hr.rental_id = rr.rental_id AND rr.property_id = pp.property_id AND pp.host_id = ht.host_id
  GROUP BY ht.host_id;


DROP VIEW IF EXISTS HighestHost CASCADE;
-- the host with the highest rating score and the coressponding rating score and email
CREATE VIEW HighestHost AS
  SELECT host_id, avg_rating as highest_avg_rating,email
  FROM avgRating
  WHERE avg_rating = (SELECT max(avg_rating) FROM avgRating);


DROP VIEW IF EXISTS MostExpensiveWeek CASCADE;
-- the highest-rating-score hosts' most expensive per-week price
CREATE VIEW MostExpensiveWeek AS
  SELECT hh.host_id, max(per_week_price) as most_expensive_week
  FROM highestHost hh, Property pp, Price pc
  WHERE pp.host_id = hh.host_id AND pc.property_id = pp.property_id
  GROUP BY hh.host_id;


DROP VIEW IF EXISTS Answer3 CASCADE;
-- the highest-rating-score hosts' most expensive per-week price, and the corresponding rating score, email
CREATE VIEW Answer3 AS
  SELECT hh.host_id as host_id,hh.email as email,highest_avg_rating, most_expensive_week
  FROM highestHost hh, mostExpensiveWeek mx
  WHERE hh.host_id = mx.host_id;

insert into q3
  SELECT *
  FROM Answer3;

select * from q3;
