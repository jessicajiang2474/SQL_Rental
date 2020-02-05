


SET SEARCH_PATH  TO vacationschema ;
drop table if exists q1 cascade;


create table q1(
    luxueryOffer VARCHAR,
    numofProperty INT
);



DROP VIEW IF EXISTS PropertyLuxury CASCADE;
-- num of properties that provide hot tub, sauna, laundry,dailyclean,breakfast,concierge :
CREATE VIEW PropertyLuxury AS
  (SELECT count(CASE WHEN hottub THEN 1 END) AS numofProperty, 'properties with hottub' AS luxuryOffer
   FROM Property)
  UNION
  (SELECT count(CASE WHEN sauna THEN 1 END) AS numofProperty,'properties with sauna' AS luxuryOffer
   FROM Property)
  UNION
   (SELECT count(CASE WHEN laundry THEN 1 END) AS numofProperty,'properties with laundry' AS luxuryOffer
    FROM Property)
  UNION
  (SELECT count(CASE WHEN dailyclean THEN 1 END) AS numofProperty,'properties with dailyclean' AS luxuryOffer
   FROM Property)
  UNION
  (SELECT count(CASE WHEN breakfast THEN 1 END) AS numofProperty,'properties with breakfast' AS luxuryOffer
   FROM Property)
  UNION
  (SELECT count(CASE WHEN concierge THEN 1 END) AS numofProperty,'properties with concierge' AS luxuryOffer
   FROM Property)
;

insert into q1
  SELECT luxuryOffer, numofProperty
  From propertyLuxury;

select * from q1;