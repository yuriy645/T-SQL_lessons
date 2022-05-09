--Lesson No.: 8
--Exercise 1
--Take samples that meet the following criteria:
-- - Airport with the most flights
-- - Name of cities and cost of tickets to them
-- - Names of passengers, the cost of the tickets they booked, the cost of the reservation and other tickets of these passengers

--DROP DATABASE HomeTask_8 
CREATE DATABASE HomeTask_8 
 GO     

ALTER DATABASE HomeTask_8
COLLATE Cyrillic_General_CI_AS	
GO

USE HomeTask_8

--DROP TABLE AirPorts
CREATE TABLE AirPorts
(
	AirportCode int NOT NULL CONSTRAINT PK_AirPorts_AirportCode PRIMARY KEY,
	AirportName nvarchar(30) NOT NULL, 
	City nvarchar(30) NOT NULL, 
	Longitude decimal(9, 6) NOT NULL, 
	Latitude decimal(9, 6) NOT NULL, 
	TimeZone int NOT NULL 
); 
GO

INSERT INTO AirPorts
	VALUES
		('500','n1234','kyiv',       '25','34','-2'),
		('678','n7204','kharkiv',    '78','45','-6'),
		('490','n9234','Antalya',    '37','67','4'),
		('134','n1234','воскресенка','10','98','54'),
		('356','n9234','lviv',       '26','23','47'),
		('758','n1234','varshava',   '46','54','52'),
		('125','n7234','Chandler',   '85','79','35'),
		('769','n9z34','odesa',      '68','37','24'),
		('879','n9j34','бобруйск',  '35','19','-34'),
		('435','n9h34','Berlin',    '54','40','-12'),
   ('135','n7234','Chandler',   '85','79','35'),
		('136','n9z34','odesa',      '68','37','24'),
		('491','n9j34','бобруйск',  '35','19','-34'),
		('679','n9h34','Berlin',    '54','40','-12')

--DROP TABLE AirCrafts		
CREATE TABLE AirCrafts
(
    AircraftCode nvarchar(30) NOT NULL CONSTRAINT PK_AirCrafts_AircraftCode PRIMARY KEY, 
	Model nvarchar(30) NOT NULL, 
	Range int NULL, 
	SeatsNumber int NOT NULL, 
	FareConditions nvarchar(30) NOT NULL UNIQUE CONSTRAINT CK_AirCrafts_FareConditions  CHECK (FareConditions IN ('Lorem ipsum', 'dolor sit amet', 'consectetur adipiscing', 'sed do eiusmod'))
	
	--CONSTRAINT PK_AirCrafts_AircraftCode_FareConditions PRIMARY KEY (FareConditions) --тут PK состоит из 2-х!!! столбцов одновременно!
);
GO

ALTER TABLE AirCrafts 
ADD CONSTRAINT CK_AirCrafts_SeatsNumber CHECK (SeatsNumber <= Range/2) -- ограничение для таблицы

ALTER TABLE AirCrafts
DROP CONSTRAINT CK_AirCrafts_SeatsNumber

INSERT AirCrafts 
   VALUES
     ('aircraft19','boeing1'        ,'500','400','Lorem ipsum'),
	 ('aircraft35','lockheed martin','900','2','dolor sit amet'),
	 ('aircraft44','space x'        ,'7000','31','consectetur adipiscing'),
	 ('aircraft17','boeing2'        ,null,'300','sed do eiusmod')
	 
GO

--DROP TABLE TicketFlies
CREATE TABLE TicketFlies
(
	TicketNumber int NOT NULL UNIQUE,
	FlightId nvarchar(30) NOT NULL CONSTRAINT PK_TicketFlies_FlightId PRIMARY KEY, -- (FlightId), 
	FareConditions nvarchar(30) NOT NULL CONSTRAINT FK_TicketFlies_AirCrafts FOREIGN KEY REFERENCES AirCrafts (FareConditions), --CONSTRAINT FK_TicketFlies_AirCrafts FOREIGN KEY (FareConditions) REFERENCES AirCrafts (FareConditions), 
	Amount  decimal(10,4) NULL, 
	BoardingNumber int, 
	SeatNumber int

	--CONSTRAINT PK_TicketFlies_TicketNumber_FlightId PRIMARY KEY (TicketNumber, FlightId) 
)
GO

INSERT TicketFlies
   VALUES 
     ('1513551', 'f1' ,'Lorem ipsum',           '451','6456', '21'), 
	 ('4362265', 'f2' ,'dolor sit amet',        '859','9522', '22'),
	 ('4362267', 'f3' ,'consectetur adipiscing','897','7989','23'), 
	 ('4362268', 'f4','sed do eiusmod',         '593','4235','24'),
    ('15135511', 'f5' ,'Lorem ipsum',           '451','6456', '21'), 
	 ('43622651', 'f6' ,'dolor sit amet',        '859','9522', '22'),
	 ('43622671', 'f7' ,'consectetur adipiscing','897','7989','23'), 
	 ('43622681', 'f8','sed do eiusmod',         '593','4235','24'),
    ('15135512', 'f9' ,'Lorem ipsum',           '451','6456', '21'), 
	 ('43622652', 'f10' ,'dolor sit amet',        '859','9522', '22'),
	 ('43622672', 'f11' ,'consectetur adipiscing','897','7989','23'), 
	 ('43622682', 'f12','sed do eiusmod',         '593','4235','24'),
   ('15135514', 'f13' ,'Lorem ipsum',           '451','6456', '21'), 
	 ('43622654', 'f14' ,'dolor sit amet',        '859','9522', '22'),
	 ('43622674', 'f15' ,'consectetur adipiscing','897','7989','23'),
  ('436226740', 'f16' ,'consectetur adipiscing','897','7989','23')
  GO


--DROP TABLE Flights
CREATE TABLE Flights
(
	FlightId nvarchar(30) NOT NULL        CONSTRAINT FK_Flights_TicketFlies FOREIGN KEY (FlightId)         REFERENCES TicketFlies (FlightId),
	FlightNumber int NULL CONSTRAINT CK_Flights_FlightNumber CHECK (FlightNumber LIKE '[0-9][0-9][0-9][0-9]'),
	ScheduledDeparture datetime NULL, 
	ScheduledArrival datetime NULL, 
	DepartureAirport int NOT NULL CONSTRAINT FK_Flights_AirPorts  FOREIGN KEY (DepartureAirport)  REFERENCES AirPorts (AirportCode), 
	ArrivalAirport int NOT NULL   CONSTRAINT FK_Flights_AirPorts1 FOREIGN KEY (ArrivalAirport)    REFERENCES AirPorts (AirportCode), 
	Status bit NOT NULL, 
	AircraftCode nvarchar(30) NOT NULL     CONSTRAINT FK_Flights_AirCrafts FOREIGN KEY (AircraftCode)      REFERENCES AirCrafts (AircraftCode), 
	ActualDeparture datetime NULL, 
	ActualArrival nvarchar(30) NOT NULL 
);
GO

INSERT INTO Flights 
	VALUES
		('f1','1234','20211110','20201226','500','356','1',      'aircraft19',       '20201227','lviv'),
		('f2','7234','20210913','20201226','678','758','1',  'aircraft35',    '20211227','бобруйск'),
		('f3','9234','20201225','20201226','490','125','1',  'aircraft44','20201228','varshava'),
		('f4','1234','20201225','20201226','134','769','1',       'aircraft19',       '20201227','lviv'),
    ('f5','1234','20210913','20201226','500','769','1',      'aircraft19',       '20201227','lviv'),
		('f6','7234','20201225','20201226','678','758','1',  'aircraft35',    '20211227','бобруйск'),
		('f7','9234','20201225','20201226','490','125','1',  'aircraft44','20201228','varshava'),
		('f8','1234','20201225','20201226','136','769','1',       'aircraft19',       '20201227','lviv'),
    ('f9','1234','20210914','20201226','500','134','1',      'aircraft19',       '20201227','lviv'),
		('f10','7234','20201225','20201226','679','758','1',  'aircraft35',    '20211227','бобруйск'),
		('f11','9234','20201225','20201226','491','125','1',  'aircraft44','20201228','varshava'),
		('f12','1234','20201225','20201226','135','769','1',       'aircraft19',       '20201227','lviv'),
		('f13','1234','20201225','20201226','500','125','1',      'aircraft19',       '20201227','lviv'),
		('f14','7234','20201225','20201226','500','879','1',  'aircraft35',    '20211227','бобруйск'),
		('f15','9234','20201225','20201226','500','490','1',  'aircraft44','20201228','varshava'),
    ('f16','9234','20221225','20201226','500','490','1',  'aircraft44','20201228','varshava')
  GO
		
--DROP TABLE Tickets
CREATE TABLE Tickets
(
	TicketNumber int NOT NULL CONSTRAINT FK_Tickets_TicketFlies FOREIGN KEY (TicketNumber) REFERENCES TicketFlies (TicketNumber), 
	BookDate datetime CONSTRAINT DF_Employees_StartDate DEFAULT GETDATE(), 
	TotalAmount  decimal(10,4) NULL,
	PassangerId nvarchar(30) NOT NULL, 
	PassangerName nvarchar(30) NOT NULL, 
	ContactData nvarchar(30) NULL 
)
GO

INSERT Tickets 
(TicketNumber, TotalAmount, PassangerId, PassangerName, ContactData)
   VALUES 
     ('1513551', '55','451345','Вася1', NULL), 
	 ('4362265', '67','899999','Вася2','дата сегодня'),
	 ('4362265', '100','899999','Вася3','дата 3 месяца назад'), 
	 ('4362265', '100','899999','Вася2','дата 5 дней назад'),
   ('15135514', '55','451345','Саша', NULL), 
	 ('43622654', '89','893999','Керя','дата сегодня'),
	 ('43622674', '35','6499999','Петя','дата 3 месяца назад'),
   ('436226740', '35','6499999','Петя','дата 3 месяца назад'),
   ('15135511', '69','451345','Мохаммед', NULL), 
	 ('15135512', '14','893999','Вадим','дата сегодня')
GO 



--- Аэропорт с максимальным количеством рейсов

DECLARE @temp TABLE (DepartureAirport int ,CountNum int)
insert into @temp -- в эту переменную спрячем выборку ниже

SELECT DepartureAirport, COUNT(DepartureAirport) CountNum FROM Flights 
 GROUP BY DepartureAirport --выдаст список аэропортов (без повторяющихся значений) и количеств повторений значений

SELECT MAX(CountNum) MAX_Value FROM @temp -- в табличной переменной нашли макс. число повторений вылетов
  --это и есть макс. кол-во вылетов из аэропорта
  




   -- - Название городов и стоимости билетов к ним

--1)по расписанию Flights найти все рейсы Киев - все города. А точнее, нужен только FlightId от этих рейсов.

--a) выберем из Flight такие FlightId, при которых город отправления- Киев
DECLARE @Flight1 TABLE (FlightId NVARCHAR(30), DepartureAirport int, City NVARCHAR(30))
insert into @Flight1 -- в эту переменную спрячем выборку ниже
    
    SELECT FlightId, DepartureAirport, a.City FROM Flights f
      JOIN AirPorts a  --null быть не может в обоих табл, потому всеравно, какой join 
      ON f.DepartureAirport = a.AirportCode --к табл расписания Flights добавили строки табл Airports так, что City.Airports соответствует коду аэропорта отправления 
WHERE a.City = 'kyiv' --список рейсов, кот отправляются из Киева.


  --б) выберем из Flight такие FlightId, при которых город отправления- НЕ Киев
  DECLARE @Flight2 TABLE (FlightId NVARCHAR(30), ArrivalAirport int, City NVARCHAR(30))
insert into @Flight2 -- в эту переменную спрячем выборку ниже
    
    SELECT FlightId, ArrivalAirport, a.City FROM Flights f
      JOIN AirPorts a  --null быть не может в обоих табл, потому всеравно, какой join 
      ON f.ArrivalAirport = a.AirportCode --к табл расписания Flights добавили строки табл Airports так, что City.Airports соответствует коду аэропорта отправления 
WHERE a.City != 'kyiv' --список рейсов, кот отправляются из Киева.


--в) из @Flight1 и @Flight2 простым JOIN-ом получим строки расписания, где рейсы из Киева во все города
 DECLARE @Flight3 TABLE (FlightId NVARCHAR(30), DepartureAirport INT, City NVARCHAR(30), FlightId1 NVARCHAR(30), ArrivalAirport int,  City1 NVARCHAR(30))
insert into @Flight3 -- в эту переменную спрячем выборку ниже

  SELECT DISTINCT *  FROM @Flight1 f1
    JOIN @Flight2 f2        -- используем простой join вместо логического И
    ON f1.FlightId = f2.FlightId

  --SELECT * FROM @Flight3
--join -им полученный вариант расписания @Flight3 с табл. TicketFlies по FlightId; потом join -им сюда табл. Tickets по TicketNumber
-- и выводим FlightId, TotalAmmount
SELECT DISTINCT f3.FlightId,  f3.City DepartureCity, f3.City1 ArrivalCity, t.TotalAmount FROM @Flight3 f3 --f3.FlightId, 
  LEFT JOIN TicketFlies tf     -- в правильной системе всеравно, какой join, потому что по смыслу null нигде не должно быть. но у меня может быть что-то недозаполнено В билетах, по э делаю LEFT JOIN
  ON f3.FlightId = tf.FlightId
  LEFT JOIN Tickets t
  ON tf.TicketNumber = t.TicketNumber
  ORDER BY ArrivalCity
  





-- - Имена пассажиров, стоимость забронированных ими билетов, стоимость брони и остальных билетов этих пассажиров

  --по идее так. 
  -- A)имена пассажиров и стоимость забронированных ими билетов- это то, что в табл Tickets. Но только если датаОтправления - датаЗаказа > 1День 
  -- Б)стоимость брони- это если заджойнить табл броней из Tickets с TicketsFlies по TicketNumber то это TotalAmount- Amount
  -- В)из списка имен пассажиров, у которых есть бронь показать стоимость билетов без брони.
  --   короче, найти пассажиров у которых куплено и бронь и не бронь. показать имя и стоимость билетов без брони.

-- A)имена пассажиров и стоимость забронированных ими билетов- это то, что в табл Tickets. Но только если датаОтправления - датаЗаказа > 1День 
SELECT t.PassangerName, t.TotalAmount FROM Tickets t
  JOIN TicketFlies tf
  ON t.TicketNumber = tf.TicketNumber
  JOIN Flights f
  ON tf.FlightId = f.FlightId
  WHERE DATEDIFF(DAY, t.BookDate, f.ScheduledDeparture) > 1  

-- Б)стоимость брони- это если заджойнить табл броней из Tickets с TicketsFlies по TicketNumber то это TotalAmount- Amount
SELECT t.PassangerName, t.TotalAmount, t.TotalAmount-tf.Amount AS bookPrice FROM Tickets t
  JOIN TicketFlies tf
  ON t.TicketNumber = tf.TicketNumber
  JOIN Flights f
  ON tf.FlightId = f.FlightId
  WHERE DATEDIFF(DAY, t.BookDate, f.ScheduledDeparture) > 1  


  -- В)из списка имен пассажиров, у которых есть бронь показать стоимость билетов без брони.
  --   короче, найти список пассажиров у которых куплено и бронь и не бронь. показать имя и стоимость билетов без брони.
-
    --ищем в табл билетов имена, у которых нет брони. (делаем табл. аналогично A, но где билеты не бронировались заранее т е датаОтправления - датаЗаказа < 1День) 
SELECT f.FlightId, t.PassangerName, t.TotalAmount, f.ScheduledDeparture, f.ActualDeparture, t.BookDate FROM Tickets t
  JOIN TicketFlies tf
  ON t.TicketNumber = tf.TicketNumber
  JOIN Flights f
  ON tf.FlightId = f.FlightId
  WHERE (DATEDIFF(DAY, t.BookDate, f.ScheduledDeparture) < 1) AND (f.ActualDeparture > GETDATE())

  -- делаем inner join из того, что имеем

  --выводить тех, у кого есть минимум 2 билета. Один из них с бронью, а второй без брони.
--Только джойнить надо было по имени пассажира. И я уже сделал, чтоб показывало одного клиента.
    SELECT Book.FlightId, Book.TotalAmount, Book.PassangerName FROM 

( SELECT f.FlightId AS FlightId, t.PassangerName PassangerName, t.TotalAmount AS TotalAmount, t.TicketNumber TicketNumber FROM Tickets t
  JOIN TicketFlies tf
  ON t.TicketNumber = tf.TicketNumber
  JOIN Flights f
  ON tf.FlightId = f.FlightId
  WHERE DATEDIFF(DAY, t.BookDate, f.ScheduledDeparture) > 1  ) Book

      JOIN

      ( SELECT f.FlightId AS FlightId, t.PassangerName PassangerName, t.TotalAmount, f.ScheduledDeparture, f.ActualDeparture, t.BookDate, t.TicketNumber TicketNumber FROM Tickets t
  JOIN TicketFlies tf
  ON t.TicketNumber = tf.TicketNumber
  JOIN Flights f
  ON tf.FlightId = f.FlightId
  WHERE (DATEDIFF(DAY, t.BookDate, f.ScheduledDeparture) <= 1)  ) NoBook --AND (f.ActualDeparture > GETDATE())

      ON Book.PassangerName = NoBook.PassangerName

      --*

	  --А если эти выборки с бронью и без брони просто склеивать с UNION, то зачем было разделять билеты на те, что с бронью и без брони ( для этого пришлось джойнить 2 раза по 3 таблицы, чтоб  из табл. Tickets добраться до даты отправления).
--Сделать выборку из Tickets и всё тогда.
SELECT TotalAmount FROM  ( --Tickets

  SELECT f.FlightId AS FlightId, t.PassangerName, t.TotalAmount AS TotalAmount FROM Tickets t
  JOIN TicketFlies tf
  ON t.TicketNumber = tf.TicketNumber
  JOIN Flights f
  ON tf.FlightId = f.FlightId
  WHERE DATEDIFF(DAY, t.BookDate, f.ScheduledDeparture) > 1  

      UNION  --выведутся и те и те строки

  SELECT f.FlightId AS FlightId, t.PassangerName, t.TotalAmount AS TotalAmount FROM Tickets t
  JOIN TicketFlies tf
  ON t.TicketNumber = tf.TicketNumber
  JOIN Flights f
  ON tf.FlightId = f.FlightId
  WHERE (DATEDIFF(DAY, t.BookDate, f.ScheduledDeparture) <= 1) --AND (f.ActualDeparture > GETDATE())
  
  ) AS Book 
  ORDER BY TotalAmount
