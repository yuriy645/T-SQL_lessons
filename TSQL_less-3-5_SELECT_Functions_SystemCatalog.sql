--lesson number: 3
--Additional task

--From the database created in the previous lesson, get the following selections:

-- -Numbers of aircraft whose flight distance exceeds 1000 or is indefinite.

-- - The names of all airports, the first character of the city name of which is the letter A, B or C, also, the time zone has a positive time component.

-- -Only unique flight numbers whose destination airports did not match the real airport where the plane landed.

CREATE DATABASE HomeTask_3 -- создание базы данных с параметрами по-умолчанию
      
ALTER DATABASE HomeTask_3
COLLATE Cyrillic_General_CI_AS	-- параметры сортировки для базы данных по умолчанию
--Latin1_General — локаль или используемый язык;
--CI — Case Insensitive — без учета регистра;
--AS — Accent Sensitive — с учетом аксонов или диакритических знаков, проще говоря 'a' не считается равным 'ấ'.

USE HomeTask_3

DROP TABLE AirPorts
CREATE TABLE AirPorts
(
	AirportCode int NOT NULL,-- UNIQUE, 
	AirportName nvarchar(30) NOT NULL, 
	City nvarchar(30) NOT NULL, 
	Longitude decimal(9, 6) NOT NULL, 
	Latitude decimal(9, 6) NOT NULL, 
	TimeZone int NOT NULL 
); GO

INSERT INTO AirPorts
	VALUES
		('1','n1234','kyiv',       '25','34','-2'),
		('2','n7234','kharkiv',    '78','45','-6'),
		('3','n9234','Antalya',    '37','67','4'),
		('4','n1234','воскресенка','10','98','54'),
		('5','n7234','kharkiv',    '76','64','-46'),
		('6','n9234','lviv',       '26','23','47'),
		('7','n1234','varshava',   '46','54','52'),
		('8','n7234','Chandler',   '85','79','35'),
		('9','n9z34','odesa',      '68','37','24'),
		('10','n9j34','бобруйск',  '35','19','-34'),
		('11','n9h34','Berlin',    '54','40','-12')

DROP TABLE Flights

CREATE TABLE Flights
(
	FlightId nvarchar(30) NOT NULL UNIQUE,
	FlightNumber int NULL, 
	ScheduledDeparture datetime NULL, 
	ScheduledArrival datetime NULL, 
	DepartureAirport nvarchar(30) NULL, 
	ArrivalAirport nvarchar(30) NULL, 
	Status bit NOT NULL, 
	AircraftCode nvarchar(30) NULL, 
	ActualDeparture datetime NULL, 
	ActualArrival nvarchar(30) NULL 
);
GO

INSERT INTO Flights 
--(column_1, column_2)
	VALUES
		('f1','1234','20201225','20201226','kyiv','lviv','1','aircraft19',       '20201227','lviv'),
		('f2','7234','20201225','20201226','kharkiv','odesa','1','aircraft35',    '20211227','бобруйск'),
		('f3','9234','20201225','20201226','Antalya','varshava','1','aircraft44','20201228','varshava'),
		('f4','1234','20201225','20201226','kyiv','lviv','1','aircraft19',       '20201227','lviv'),
		('f5','7234','20201225','20201226','kharkiv','Berlin','1','aircraft35',   '20200221','Berlin'),
		('f6','9234','20201225','20201226','lviv','varshava','1','aircraft44',   '20201228','varshava'),
		('f7','1234','20201225','20201226','kyiv','lviv','1','aircraft19',       '20201227','воскресенка'),
		('f8','7234','20201225','20201226','Chandler','odesa','1','aircraft35',   '20211227','odesa'),
		('f9','9234','20201225','20201226','lviv','varshava','1','aircraft44',   '20201228','varshava')
		--(,' ',),
		
CREATE TABLE AirCrafts
(
    AircraftCode int NULL, 
	Model nvarchar(30) NOT NULL, 
	Range int NULL, 
	SeatsNumber int NOT NULL, 
	FareConditions nvarchar(30) 
);
GO

INSERT AirCrafts 
   VALUES
     ('1513551','boeing1'        ,'500','400','Lorem ipsum'),
	 ('4362265','lockheed martin','900','2','dolor sit amet'),
	 ('9486435','space x'        ,'7000','31','consectetur adipiscing'),
	 ('3451513','boeing2'        ,null,'300','sed do eiusmod')
GO

---Numbers of aircraft whose flight distance exceeds 1000 or is indefinite.
SELECT AircraftCode FROM AirCrafts 
WHERE Range > 1000 OR Range IS NULL
GO


-- - The names of all airports, the first character of the city name of which is the letter A, B or C, also, the time zone has a positive time component.
SELECT AirportName, City, TimeZone FROM Airports
WHERE (City LIKE '[A-C]%') AND (TimeZone > 0)

SELECT Flights.DepartureAirport, Flights.ArrivalAirport FROM Flights
WHERE (DepartureAirport LIKE '[A-C]%') OR (ArrivalAirport LIKE '[A-C]%') 

--SELECT * FROM Flights
--WHERE (DepartureAirport LIKE 'A%') OR (DepartureAirport LIKE 'C%')


-- -Only unique flight numbers whose destination airports did not match the real airport where the plane landed.
SELECT FlightId FROM Flights
WHERE ArrivalAirport != ActualArrival

--*******************************************************************************
--lesson number: 4
--Additional task
--Using the functions learned in the lesson, get the following results: Dates:
--today, three months ago and 5 days ago, also present all these dates as constituent parts

--Exercise 1
--Using the functions learned in the lesson, get the following results:
---Get a selection of all booking objects that were made in the last month. Implement several options.
---Get a selection from the ticket table, replace all missing values of the user's contact information with the string "Undefined"
--№ урока: 4  

USE HomeTask_3
DROP TABLE Tickets

CREATE TABLE Tickets
(
	TicketNumber int NOT NULL,-- UNIQUE, 
	BookDate datetime NOT NULL, 
	TotalAmount  int,--decimal(10,4) NULL,
	PassangerId nvarchar(30) NOT NULL, 
	PassangerName nvarchar(30) NOT NULL, 
	ContactData nvarchar(30) NULL 
)
GO

INSERT Tickets 
   VALUES --get the following results: Dates: today, three months ago and 5 days ago
     ('1513551', '20210720' ,'55','451345','Вася1', NULL), 
	 ('4362265', GETDATE() ,'100','899999','Вася2','дата сегодня'),
	 ('4362265', DATEADD(month, -3, GETDATE()) ,'100','899999','Вася3','дата 3 месяца назад'), 
	 ('4362265', DATEADD(day, -5, GETDATE()) ,'100','899999','Вася2','дата 5 дней назад')
	 
GO

--also present all these dates as constituent parts
SELECT BookDate, DATEPART(day, BookDate) as day, DATEPART(month, BookDate) as month, DATEPART(year, BookDate) as year FROM Tickets 

--Get a selection of all booking objects that were made in the last month. Implement several options.
SELECT * FROM Tickets
WHERE DATEDIFF(month, BookDate, GETDATE()) <= 1

SELECT * FROM Tickets
WHERE DATEDIFF(day, BookDate, GETDATE()) <= 30

SELECT * FROM Tickets
WHERE BookDate >= GETDATE() - 30

--Get a selection from the ticket table, replace all missing values of the user's contact information with the string "Undefined"
SELECT [TicketNumber]
      ,[BookDate]
      ,[TotalAmount]
      ,[PassangerId]
      ,[PassangerName] 
	  ,IIF(ContactData IS NULL, 'Undefined', ContactData) AS ContactData FROM Tickets


--********************************************************************************************************************

--No. Lesson: 5
--Additional task
--Connecting to the HomeTask database, using aggregate functions and system tables, count the number of tables in this database.

--Exercise 1
--Get the average of the range of the aircraft and the average of the unique ranges.


--Task 2
--Get the number of bookings and their average cost

--Connecting to the HomeTask database, using aggregate functions and system tables, count the number of tables in this database. 
USE HomeTask_3
-- чтоб знать кол-во таблиц- надо посчитать кол-во строк в системной таблице, получаемой так: EXEC sp_tables 
-- но процедуру с ключевым словом EXEC нельзя использовать в выражении типа такого: SELECT COUNT(*) AS Qty_tables FROM ( EXEC sp_tables )
-- по э создаем табличную временную переменную с такими же столбцами и копируем в нее системные данные
-- а потом уже в э переменной считаем кол-во строк
DECLARE @temp TABLE (TABLE_QUALIFIER varchar(30), TABLE_OWNER varchar(30), TABLE_NAME varchar(30), TABLE_TYPE varchar(30), REMARKS varchar(30));
INSERT INTO @temp EXEC sp_tables @table_owner='dbo';
SELECT COUNT(*) AS Qty_tables FROM @temp;-- подсчет всех строк в таблице

--EXEC sp_tables @table_owner='dbo' --только таблицы со схемой dbo 
--2 способ
SELECT COUNT(*) AS Qty_tables FROM sys.tables --(в полной тиблице больше колонок, чем в 3 способе)

--3 способ
SELECT COUNT(*) AS Qty_tables FROM sys.objects --sys.objects выводит инфо о всех скущностях, кот есть в текущей БД
WHERE type = 'U'



--Get the average of the range of the aircraft and the average of the unique ranges.
SELECT AVG(Range) [AVG_Range    .], MAX(Range) [MAX_Range    .], MIN(Range) [MIN_Range    .], (MAX(Range)-MIN(Range))/2 FROM  AirCrafts 
WHERE Range IS NOT NULL

--Get the number of bookings and their average cost
SELECT COUNT(*) [QtyReservation    .], AVG(TotalAmount) [AVG_Price    .] FROM Tickets

--***********************************************************************************************************************
*

