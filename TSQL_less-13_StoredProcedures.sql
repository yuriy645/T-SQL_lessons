--Lesson No.: 13
--Additional task
--Create a procedure that will make a selection for task 3 of lesson 10.
--perform the following selection: Names of passengers, cost of their last ticket.

--Task 1
--Write a function that will be a filter function for the flight distance of the aircraft.
--Using this function, get a selection of unique aircraft models whose flight range exceeds 500 km.

--Task 2
--Rewrite task 3 of the previous lesson using procedures.
--Write an algorithm that will determine the largest prime divisor of the value of some integer variable

--DROP DATABASE HomeTask_9 
CREATE DATABASE HomeTask_9 
 GO     

ALTER DATABASE HomeTask_9
COLLATE Cyrillic_General_CI_AS	
GO

USE HomeTask_9

--Таблица AirPorts - Аэропорты.Cities + AirPorts
--В одном городе вполне может быть несколько аэропортов. Поэтому города могут повторяться.
--Временная зона жестко привязана не к координатам GPS, а к городу, т. к. официально принятую временную зону 
--передвигают для административного удобства и одному городу всегда будет директивно назначена одна временная зона.
--Потому город с временной зоной выносим в отдельную таблицу.
--DROP TABLE Cities
CREATE TABLE Cities
(
	CityId int NOT NULL IDENTITY CONSTRAINT PK_Cities_CityId PRIMARY KEY,
	TimeZone int NOT NULL 
); 
GO
INSERT INTO Cities
	VALUES
		('-2'), ('-6'),	('4'), ('54'),	('47'),	('52'),	('35'),	('24'),	('-34'),('-12'), ('35'), ('24'), ('-34'),('-12')

--DROP TABLE AirPorts
CREATE TABLE AirPorts
(
	AirportCode int NOT NULL CONSTRAINT PK_AirPorts_AirportCode PRIMARY KEY,
	AirportName nvarchar(30) NOT NULL, 
	City nvarchar(30) NOT NULL, 
	Longitude decimal(9, 6) NOT NULL, 
	Latitude decimal(9, 6) NOT NULL,
	CityId int NOT NULL CONSTRAINT FK_AirPorts_CityId FOREIGN KEY REFERENCES Cities (CityId)
); 
GO
INSERT INTO AirPorts
	VALUES
		(500,'n1234','kyiv',       '25','34',1),
		('678','n7204','kharkiv',    '78','45',2),
	  ('490','n9234','Antalya',    '37','67',3),
		('134','n1234','воскресенка','10','98',4),
		('356','n9234','lviv',       '26','23',5),
		('758','n1234','varshava',   '46','54',6),
		('125','n7234','Chandler',   '85','79',7),
		('769','n9z34','odesa',      '68','37',8),
		('879','n9j34','бобруйск',  '35','19',9),
		('435','n9h34','Berlin',    '54','40',10),
    ('135','n7234','Chandler',   '85','79',11),
		('136','n9z34','odesa',      '68','37',12),
		('491','n9j34','бобруйск',  '35','19',13),
		('679','n9h34','Berlin',    '54','40',14)
	GO										   

--Таблица AirCrafts - самолёты. Planes + AirCrafts
--Состоит из полётного кода - AircraftCode, модели Model и всех характеристик модели. Наверняка моделей меньше, чем полетных кодов, поэтому строки, характеризующие самолёт будут повторяться.
--Значит, надо самолёты вывести вотдельную табл., а в табл. AirCrafts подставлять Id модели самолета.
--DROP TABLE Planes
CREATE TABLE Planes
(
    PlaneId int NOT NULL IDENTITY CONSTRAINT PK_Planes_PlaneId PRIMARY KEY, 
	Model nvarchar(30) NOT NULL UNIQUE CONSTRAINT CK_Planes_Model  CHECK (Model IN ('airbus', 'boeing', 'lockheed martin', 'space x')), 
	Range int NOT NULL, 
	SeatsNumber int NOT NULL, 
	FareConditions nvarchar(30) NOT NULL UNIQUE,
);
GO
INSERT Planes 
   VALUES
   ('airbus'        ,'500','400','Lorem ipsum'),
	 ('lockheed martin','900','2','dolor sit amet'),
	 ('space x'        ,'70000','31','consectetur adipiscing'),
	 ('boeing'        ,2000,'300','sed do eiusmod')	 
GO

--DROP TABLE AirCrafts
CREATE TABLE AirCrafts
(
    AircraftCode nvarchar(30) NOT NULL CONSTRAINT PK_AirCrafts_AircraftCode PRIMARY KEY,
	PlaneId int NOT NULL CONSTRAINT FK_AirCrafts_PlaneId FOREIGN KEY REFERENCES Planes (PlaneId)
);
GO
INSERT AirCrafts 
   VALUES
   ('aircraft19', 1),
	 ('aircraft35', 2),
	 ('aircraft44', 3),
	 ('aircraft17',  4)	 
GO

--Таблица TicketFlies- это по смыслу типа "Полётные места", т. е. содержит набор параметров с некоторой условной периодичностью, 
--соответствующей круговороту самолетов по земному шару. Если попробовать поискать такие параметры, то можно предположить : 
--FlightId- номер рейса, BoardingNumber- номер посадки (хотя, я точно не знаю, возможно, это поле производное от TicketNumber без такой периодичности),
--SeatNumber- идентификатор сидения. 
--Остальные столбцы уже совсем разнородные. FareConditions- условия оплаты- можно считать случайная величина, т. к. зависит от всего.
--Ammount- тоже квазислучайная, разве что может быть расчетной относительно FareConditions, но такую сложнорасчетную ответственную величину врядли 
--оставят расчетной ибо потом может быть сложно выяснять предполагаемые сбои.
--TicketNumber- скорее всего автоинкрементируемая с большим периодом величина.

--DROP TABLE TicketFlies
CREATE TABLE TicketFlies
(
	TicketNumber int NOT NULL UNIQUE,
	FlightId nvarchar(30) NOT NULL CONSTRAINT PK_TicketFlies_FlightId PRIMARY KEY, -- (FlightId), 
	FareConditions nvarchar(30) NOT NULL CONSTRAINT FK_TicketFlies_AirCrafts FOREIGN KEY REFERENCES Planes (FareConditions), --CONSTRAINT FK_TicketFlies_AirCrafts FOREIGN KEY (FareConditions) REFERENCES AirCrafts (FareConditions), 
	Amount  decimal(10,4) NULL, 
	BoardingNumber int, 
	SeatNumber int
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

--Табл. Tickets - Билеты Passangers + Tickets
--Очевидно состоит из 2-х частей : 
--1 инфо о покупках билетов
--2 инфо о пассажирах, которые могут повторяться
--Потому пассажиров выносим в отдельную таблицу.

--DROP TABLE Passangers
CREATE TABLE Passangers
(
	PassangerId int NOT NULL CONSTRAINT PK_Passangers_PassangerId PRIMARY KEY,
	PassangerName nvarchar(30) NOT NULL, 
	ContactData nvarchar(30) NULL 
)
GO
INSERT Passangers 
  (PassangerId, PassangerName, ContactData)
   VALUES 
   ( '451345'  ,'Вася1', NULL), 
	 ( '899999'  ,'Вася2','дата сегодня'),
	 ( '839999'  ,'Вася3','дата 3 месяца назад'), 
	 ( '899929'  ,'Вася2','дата 5 дней назад'),
   ( '45143345','Саша', NULL), 
	 ( '893999'  ,'Керя','дата сегодня'),
	 ( '6499999' ,'Петя','дата 3 месяца назад'),
   ( '6499599' ,'Петя','дата 3 месяца назад'),
   ( '4514345' ,'Мохаммед', NULL), 
	 ( '89391099','Вадим','дата сегодня')
GO

--DROP TABLE Tickets
CREATE TABLE Tickets
(
	TicketNumber int NOT NULL CONSTRAINT FK_Tickets_TicketFlies FOREIGN KEY (TicketNumber) REFERENCES TicketFlies (TicketNumber), 
	BookDate datetime CONSTRAINT DF_Employees_StartDate DEFAULT GETDATE(), 
	TotalAmount  decimal(10,4) NULL,
	PassangerId int NOT NULL CONSTRAINT FK_Tickets_PassangerId FOREIGN KEY REFERENCES Passangers (PassangerId)
)
GO
INSERT Tickets 
(TicketNumber, TotalAmount, PassangerId)
   VALUES 
     ('1513551', '55',  '451345'    ), 
	 ('4362265', '67',  '899999'    ),
	 ('4362265', '100', '839999'    ), 
	 ('4362265', '100', '899929'    ),
   ('15135514', '55',   '45143345'  ), 
	 ('43622654', '89', '893999'    ),
	 ('43622674', '35', '6499999'   ),
   ('436226740', '35',  '6499599'   ),
   ('15135511', '69',   '4514345'   ), 
	 ('15135512', '14', '89391099'  )
GO


--Таблица Flights  Schedule + Flights
--содержит очевидно повторяющиеся части строк, которые можно вынести с PK FlightNumber и остальные части строк со случайными данными,
--которые заполняются по факту.

--DROP TABLE Schedule
CREATE TABLE Schedule
(
	FlightNumber int NOT NULL CONSTRAINT PK_Schedule_FlightNumber PRIMARY KEY, CONSTRAINT CK_Flights_FlightNumber CHECK (FlightNumber LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]'),
	ScheduledDeparture datetime NULL, 
	ScheduledArrival datetime NULL, 
	DepartureAirport int NOT NULL CONSTRAINT FK_Flights_AirPorts  FOREIGN KEY (DepartureAirport)  REFERENCES AirPorts (AirportCode), 
	ArrivalAirport int NOT NULL   CONSTRAINT FK_Flights_AirPorts1 FOREIGN KEY (ArrivalAirport)    REFERENCES AirPorts (AirportCode)
);
GO
INSERT INTO Schedule 
	VALUES
		('123401','20211110','20201226','500','356'),
		('723402','20210913','20201226','678','758'),
		('923403','20201225','20201226','490','125'),
		('123404','20201225','20201226','134','769'),
    ('123405','20210913','20201226','500','769'),
		('723406','20201225','20201226','678','758'),
		('923407','20201225','20201226','490','125'),
		('123408','20201225','20201226','136','769'),
    ('123409','20210914','20201226','500','134'),
		('723410','20201225','20201226','679','758'),
		('923411','20201225','20201226','491','125'),
		('123412','20201225','20201226','135','769'),
		('123413','20201225','20201226','500','125'),
		('723414','20201225','20201226','500','879'),
		('923415','20201225','20201226','500','490'),
    ('923416','20221225','20201226','500','490')
  GO

--DROP TABLE Flights
CREATE TABLE Flights
(
	FlightId nvarchar(30) NOT NULL        CONSTRAINT FK_Flights_TicketFlies FOREIGN KEY (FlightId)         REFERENCES TicketFlies (FlightId),
	FlightNumber int NULL CONSTRAINT FK_Flights_FlightNumber FOREIGN KEY (FlightNumber) REFERENCES Schedule (FlightNumber),
	Status bit NOT NULL, 
	AircraftCode nvarchar(30) NOT NULL     CONSTRAINT FK_Flights_AirCrafts FOREIGN KEY (AircraftCode)      REFERENCES AirCrafts (AircraftCode), 
	ActualDeparture datetime NULL, 
	ActualArrival nvarchar(30) NOT NULL 
);
GO
INSERT INTO Flights 
	VALUES
		('f1', '123401','1',  'aircraft19',       '20201227',  '356'),
		('f2', '723402','1',  'aircraft35',    '20211227',     '758'),
		('f3', '923403','1',  'aircraft44','20201228',         '125'),
		('f4', '123404','1',  'aircraft19',       '20201227',  '769'),
    ('f5', '123405','1',  'aircraft19',       '20201227',  '769'),
		('f6', '723406','1',  'aircraft35',    '20211227',     '758'),
		('f7', '923407','1',  'aircraft44','20201228',         '125'),
		('f8', '123408','1',  'aircraft19',       '20201227',  '769'),
    ('f9', '123409','1',  'aircraft19',       '20201227',  '134'),
		('f10','723410','1', 'aircraft35',    '20211227',     '758'),
		('f11','923411','1', 'aircraft44','20201228',         '134'),
		('f12','123412','1', 'aircraft19',       '20201227',  '134'),
		('f13','123413','1', 'aircraft19',       '20201227',  '134'),
		('f14','723414','1',  'aircraft35',    '20211227',    '134'),
		('f15','923415','1',  'aircraft44','20201228',        '134'),
    ('f16','923416','1',  'aircraft44','20201228',        '134')
  GO



--Additional task
--Create a procedure that will make a selection for task 3 of lesson 10.
--perform the following selection: Names of passengers, cost of their last ticket.
USE HomeTask_9
GO

CREATE PROCEDURE sp310task 
AS
 SELECT pa.PassangerName, t.BookDate FROM Passangers pa
	  JOIN Tickets t 
    
    ON (pa.PassangerId = t.PassangerId)          --объединение таблиц по Id 
	     AND ( t.BookDate) IN                      --и по тому признаку, что дата максимальная из возможных

       (SELECT  MAX(t.BookDate) FROM Tickets t 
        WHERE pa.PassangerId = t.PassangerId )    --для Id пассажира, который рассмвтривается во внешнем select-e
      
		GROUP BY pa.PassangerName,T.BookDate--, t.TotalAmount --убирание дубликатов
GO

EXECUTE sp310task
GO


--Task 1
--Write a function that will be a filter function for the flight distance of the aircraft.
--Using this function, get a selection of unique aircraft models whose flight range exceeds 500 km.

--DROP FUNCTION fnModels
CREATE FUNCTION fnModels(@Range int = '1') --%- любое дефолтное значение
	RETURNS TABLE
AS
	RETURN 
	(
		SELECT DISTINCT p.Model, p.range FROM Planes p
    WHERE p.Range > @Range
	)
GO

SELECT * FROM fnModels(500);
GO

SELECT * FROM fnModels(DEFAULT);
GO


--Task 2
--Rewrite task 3 of the previous lesson using procedures.
--Write an algorithm that will determine the largest prime divisor of the value of some integer variable

  --The idea is
   --1) to create a table
   --2) procedure 1 writes a column of test values into the table
   --3) procedure 2 reads these values and appends its own.
   --4) in the progress of work, procedure 2 uses procedure 3, which deals with calculations
   --5) procedure 3 calls itself 1 time to determine if the divisor is prime.

--DROP TABLE Numbers
CREATE TABLE Numbers
(
	Number int NULL,
  Div int NULL
	
); 
GO

--TRUNCATE TABLE Numbers

CREATE PROC spMakeNumbers --procedure fills a table with a column of numbers --using the cursor method
AS
DECLARE @Number INT, @count INT = 0, @Numbers_cursor CURSOR 
--SET @Numbers_cursor = CURSOR             --в переменную типа курсор запишем курсор
--  FOR SELECT Number FROM Numbers
--OPEN @Numbers_cursor                     --открыли курсор. @- потому что курсор объявлен, как переменная
	WHILE @count < 30 
	BEGIN
	     SET @count = @count + 1
       INSERT INTO Numbers VALUES (@count, null)
  END 
--CLOSE @Numbers_cursor
--DEALLOCATE @Numbers_cursor --тут могли выделять только все строки сразу, т к переменные должны существовать в пакете, кот разово выполняем
GO
 

EXEC spMakeNumbers
GO


--DROP PROC spPrimeNumber 
CREATE PROC spPrimeNumber -- the procedure is designed for 2 applications: 
	@num int,               -- 1) checks the 1st parameter for prime number. does RETURN -1 or RETURN +1  
	@maxDiv INT=1 OUT       -- 2) using the second OUT parameter returns the maximum of the prime divisors of the 1st parameter
AS
DECLARE @x INT = 2, @Prime INT = 1, @check int
  WHILE @x < @num         --делю испытуемое число на все, кроме 1 и себя самого(**). Если есть хоть один 0-вой остаток от деления, то число не простое
  
    BEGIN                                                     --search of divisor
      
      IF (@num % @x = 0)                                      --если обнаружился делитель, то работаем с ним
        BEGIN
        --PRINT ' делитель ' + CAST(@x AS VARCHAR)             --для отладки можно посмотреть на все делители
        SET @Prime = -1                                        --признак НЕ простого числа

        EXEC @check = spPrimeNumber @x                         --рекурсивная проверка, является ли найденный делитель простым
        IF (@x =2) SET @check = -1                             --если начальный делитель @x ставить не 1, а 2; а конечный- != входном у числу(**), 
                                                               -- то проверок 2/1 , 2/2 не будет  и 2 ложно определится, как простое число. По э. вручную меняем.
        
        IF ((@check > 0) AND (@maxDiv < @x)) SET @maxDiv = @x  --переприсваивать только простые делители
        

        END 
     
    SET @x = @x +1
    END 
  RETURN @Prime
 GO


--DECLARE @Prime INT, @maxDiv INT = 1, @count int = 27       --test code for procedure spPrimeNumber 
----WHILE @count < 35
--  BEGIN 
--SET @count = @count + 1
----IF (@count = 28) 
--  SET @count = 4
--PRINT @count
--EXEC @Prime = spPrimeNumber @count, @maxDiv OUT 
--IF (@maxDiv != 1) PRINT  @maxDiv
--  PRINT @Prime
--  END 


--DROP PROC GPD
CREATE PROC GPD -- reads a column of numbers from the table and appends the result there
	 AS
DECLARE @count INT = 0, @maxDiv INT = 1 , @Numbers_cursor CURSOR 
SET @Numbers_cursor = CURSOR             --в переменную типа курсор запишем курсор
  FOR SELECT Number FROM Numbers
OPEN @Numbers_cursor                     
 
	WHILE @count < 30 --@@FETCH_STATUS = 0 
	BEGIN
      SET @count = @count + 1
       FETCH NEXT FROM @Numbers_cursor INTO @count 
       EXEC spPrimeNumber @count, @maxDiv OUT --передаем испытуемое число и переменую-макс. делитель
       --IF (@maxDiv != 1) PRINT 'Максимальный простой делитель: ' + CAST(@maxDiv AS VARCHAR)
       
       IF (@maxDiv != 1) INSERT INTO Numbers VALUES (@count, @maxDiv)
       SET @maxDiv = 1
  END 
CLOSE @Numbers_cursor
DEALLOCATE @Numbers_cursor 
GO

GPD
GO


