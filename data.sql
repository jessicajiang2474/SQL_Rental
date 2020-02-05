
insert into Guest values
(31,'Darth Vader', 'Death Star', '1985-12-06'),
(32,'Leia Princess', 'Alderaan', '2001-10-05'),
(33,'Romeo Montague', 'Veona', '1988-05-11'),
(34,'Juliet Capuet', 'Verona', '1991-07-24'),
(35, 'Mercutio', 'Verona','1988-03-03'),
(36, 'Chewbacca', 'Kashyyyk','1988-09-15');



insert into Property values
(1,1,3,1,6,'Tatooine',TRUE,FALSE,FALSE,TRUE,FALSE,FALSE),
(2,2,1,1,2,'Alderaan',TRUE,TRUE,FALSE,TRUE,FALSE,FALSE),
(3,3,2,1,3,'Corellia',FALSE,FALSE,FALSE,FALSE,TRUE,TRUE),
(4,2,2,1,2,'Verona',FALSE,FALSE,TRUE,FALSE,FALSE,FALSE),
(5,3,2,2,4,'Florence',TRUE,FALSE,FALSE,FALSE,FALSE,FALSE),
(6,1,1,1,2,'Unknown',TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);



insert into City values
(3,20,'bus');


insert into Water values
(2,FALSE,FALSE,TRUE,FALSE,FALSE ,FALSE );


insert into SaturdayToWeek values
(21,'2019-01-05'),
(22,'2019-01-12'),
(23,'2019-01-19');



insert into Price values
(2,21,580),(2,22,600),
(3,22,750),(3,23,750),
(5,21,1000),(5,22,1220);



insert into CreditCard values
(31,3466704824219330),
(32,6011253896008199),
(33,5446447451075463),
(35,4666153163329984),
(36,6011624297465933);



insert into RentForRenter values
(11,31,2,'2019-01-05',1),
(12,32,3,'2019-01-12',2),
(13,33,2,'2019-01-12',1),
(14,35,5,'2019-01-05',1),
(15,36,5,'2019-01-12',1);



insert into RentForAllGuests values
(11,31),(11,32),
(12,32),(12,33),(12,34),
(13,33),(13,34),
(14,35),(14,33),(14,31),
(15,36), (15,32)
;


insert into Host values
(1, 'luke@gmail.com'),
(2, 'leia@gmail.com'),
(3,'han@gmail.com');




insert into PropertyRating values
(61,11,32,5),(62,11,31,2),
(63,12,33,5),(64,12,34,5),(65,12,32,1),
(66,13,34,5),
(67,14,35,1),(68,14,33,1),
(69,15,36,3);




insert into Comment values
(62,'Looks like she hides rebel scum here.'),
(65,'A bit scruffy, could do with more regular housekeeping'),
(69,'Fantastic, arggg');




insert into HostRating values
(11,31,2),
(12,32,5),
(13,33,3),
(14,35,4),
(15,36,4);