SET SEARCH_PATH TO vacationschema;
drop table if exists q5 cascade;

create table q5(
  property_id INT,
  min_price FLOAT,
  max_price FLOAT,
  price_range FLOAT,
  max_range VARCHAR );


DROP VIEW IF EXISTS ExtremPrice CASCADE;
-- the min and max prices and the range for each property
CREATE VIEW ExtremPrice AS
  SELECT property_id, min(per_week_price) as min_price,
         max(per_week_price) as max_price,
         max(per_week_price)- min(per_week_price) as price_range
  FROM Price
  GROUP BY property_id;


DROP VIEW IF EXISTS MaxRange CASCADE;
-- the max of the range of each property
CREATE VIEW MaxRange AS
    SELECT max(price_range) as maxrange
    FROM extremPrice;



DROP VIEW IF EXISTS HighestRange CASCADE;
-- each property's max and min prices, and the range for each property with the max range marked by a '*'
CREATE VIEW HighestRange AS
  SELECT property_id,min_price, max_price, price_range,
         CASE
         WHEN price_range = maxrange THEN '*'
         WHEN price_range < maxrange THEN ' '
         END AS max_range
  FROM  extremPrice ep, maxRange mr;


insert into q5
  SELECT *
  From highestRange;

select * from q5;