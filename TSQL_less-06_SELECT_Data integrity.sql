--Lesson No.: 6
--Additional Task
--After analyzing the HomeTask database tables, ensure entity/referential integrity using learned approaches

--Exercise 1
--Add some custom input restrictions to handle possible invalid values.

--Task 2
--After analyzing the tables and options for possible queries to them, impose restrictions on the uniqueness of values for possible target fields of tables.

DROP DATABASE HomeTask_6 
CREATE DATABASE HomeTask_6 -- создание базы данных с параметрами по-умолчанию
      
ALTER DATABASE HomeTask_6
COLLATE Cyrillic_General_CI_AS	-- параметры сортировки дл¤ базы данных по умолчанию

USE HomeTask_6

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
--(AirportCode, AirportName, City, Longitude, Latitude, TimeZone)
	VALUES
		('500','n1234','kyiv',       '25','34','-2'),
		('678','n7204','kharkiv',    '78','45','-6'),
		('490','n9234','Antalya',    '37','67','4'),
		('134','n1234','воскресенка','10','98','54'),
		--('510','n7234','kharkiv',    '76','64','-46'),
		('356','n9234','lviv',       '26','23','47'),
		('758','n1234','varshava',   '46','54','52'),
		('125','n7234','Chandler',   '85','79','35'),
		('769','n9z34','odesa',      '68','37','24'),
		('879','n9j34','бобруйск',  '35','19','-34'),
		('435','n9h34','Berlin',    '54','40','-12')

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
ADD CONSTRAINT CK_AirCrafts_SeatsNumber CHECK (SeatsNumber <= Range/2) -- ограничение дл¤ таблицы

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
	 ('4362268', 'f4','sed do eiusmod',         '593','4235','24')
	 
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
--(column_1, column_2)
	VALUES
		('f1','1234','20201225','20201226','500','356','1',      'aircraft19',       '20201227','lviv'),
		('f2','7234','20201225','20201226','678','758','1',  'aircraft35',    '20211227','бобруйск'),
		('f3','9234','20201225','20201226','490','125','1','aircraft44','20201228','varshava'),
		('f4','1234','20201225','20201226','134','769','1',       'aircraft19',       '20201227','lviv')
		--(,' ',),



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
   VALUES --получить следующие результаты: ƒаты: сегодн¤, три мес¤ца назад и 5 дней назад
     ('1513551', '55','451345','¬ас¤1', NULL), 
	 ('4362265', '100','899999','¬ас¤2','дата сегодн¤'),
	 ('4362265', '100','899999','¬ас¤3','дата 3 мес¤ца назад'), 
	 ('4362265', '100','899999','¬ас¤2','дата 5 дней назад')
	 
GO

