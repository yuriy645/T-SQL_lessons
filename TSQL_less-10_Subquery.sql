--Lesson No.: 10
--Using the approaches studied, make the following selections:
-- - List of flight numbers for aircraft with maximum range.
-- - Flight numbers, names of destination cities, aircraft models.
-- - Names of passengers, cost of their last ticket.

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



--Using the approaches studied, make the following selections:
-- - List of flight numbers for aircraft with maximum range.
-- - Flight numbers, names of destination cities, aircraft models.
-- - Names of passengers, cost of their last ticket.


--  1) List of flight numbers for aircraft with maximum range.
  --тоесть из расписания выбрать рейсы, выполненные самолётами с максимальным радиусом действия
SELECT f.FlightId, f.FlightNumber FROM Flights f                              --найти такие номера полетов в расписании,
WHERE f.AircraftCode IN (SELECT ac.AircraftCode FROM AirCrafts ac -- у которых бортовые номера AircraftCode в списке  номеров AircraftCode таблицы самолетов AirCrafts
			WHERE ac.PlaneId IN (SELECT p.PlaneId FROM Planes p         -- у которых номера PlaneId в списке номеров PlaneId таблицы моделей самолетов Planes
          WHERE Range = (SELECT MAX(Range) FROM Planes)))          --у которых макс радиус действия
              
SELECT * FROM Flights f --проверка с join 
  JOIN AirCrafts ac
  ON f.AircraftCode = ac.AircraftCode
  JOIN Planes p
  ON ac.PlaneId = p.PlaneId  
WHERE p.Range = (SELECT MAX(p.Range) FROM Planes p)
  

  --  2) Flight numbers, names of destination cities, aircraft models.
SELECT s.FlightNumber,                                                                    --Номера рейсов

  (SELECT ap.City FROM AirPorts ap WHERE s.ArrivalAirport = ap.AirportCode) ArrivalCity,  --названия городов назначения

  (SELECT p.Model FROM Planes p                                                           --модели самолетов
     WHERE p.PlaneId IN (SELECT ac.PlaneId FROM AirCrafts ac 
      WHERE ac.AircraftCode IN (SELECT f.AircraftCode FROM Flights f
       WHERE f.FlightNumber = s.FlightNumber))) PlanesModel

  FROM Schedule s                              --найти такие номера полетов в расписании,


  SELECT TOP(100) s.FlightNumber, ap.City, p.Model  FROM Schedule s  --проверка с join 
  JOIN AirPorts ap
  ON s.ArrivalAirport = ap.AirportCode
  JOIN Flights f
  ON s.FlightNumber = f.FlightNumber
    JOIN AirCrafts ac
    ON f.AircraftCode = ac.AircraftCode
    JOIN Planes p
    ON ac.PlaneId = p.PlaneId
    ORDER BY p.Model


--  3) Names of passengers, cost of their last ticket.
  
  -- ТАК НЕ РАБОТАЕТ
  SELECT pa.PassangerName,

    (SELECT t.TotalAmount FROM Tickets t
    WHERE   (pa.PassangerId = t.PassangerId) AND (t.BookDate = MAX(t.BookDate))  )--где соответствие пассажира билету и дата максимальная
    

    FROM Passangers pa

  -- Переделал
	SELECT  --эта 1 часть позволяет вывести все поля
	DISTINCT

    (SELECT t.TotalAmount FROM Tickets t  --сумма, как  у меня, но правильно
    WHERE   (pa.PassangerId = t.PassangerId) 
	AND (t.BookDate IN ( SELECT MAX(t.BookDate) AS BookDate FROM Tickets t))  
	) AS TotalAmount,

	pa.PassangerName--где соответствие пассажира билету и дата максимальная

	, (SELECT MAX(t.BookDate) FROM Tickets t --выод даты ещё
    WHERE   (pa.PassangerId = t.PassangerId) 
    ) AS BookDate,

	pa.PassangerName --то же имя пассажира
  --  pa.PassangerId если тут выводить PassangerId, то будет тоже Петя 2 раза и 10 записей

    FROM Passangers pa 

	INNER JOIN 
    
 (  SELECT pa.PassangerName FROM Passangers pa,Tickets t -- а эта 2 часть не даёт повторений т.к. если добавить в select  t.TotalAmount -то будут, т к придется и в group добавлять

    WHERE pa.PassangerId = t.PassangerId 
	AND ( t.BookDate) IN

	(SELECT  MAX(t.BookDate) FROM Tickets t 
	WHERE pa.PassangerId = t.PassangerId
        GROUP BY t.TotalAmount)

		GROUP BY pa.PassangerName) AS Unq

		ON pa.PassangerName = Unq.PassangerName



    

--найти стоимости последних билетов всех пассажиров:
  --Тут именно всех пассажиров
  --ЭТО НЕ ПОДХОДИТ
    SELECT t.PassangerId, t.TotalAmount FROM Tickets t
    WHERE  t.BookDate = MAX(t.BookDate)  --где соответствие пассажира билету и дата максимальная

    --Переделал
    SELECT  t.PassangerId, t.TotalAmount FROM Tickets t
    WHERE  t.BookDate = ( SELECT MAX(t.BookDate) AS BookDate FROM Tickets t)  --где соответствие пассажира билету и дата максимальная
	GROUP BY t.PassangerId, t.TotalAmount

 
 
 -- НАДО ТОЛЬКО ТАК
      SELECT t.PassangerId, t.TotalAmount, MAX(t.BookDate) FROM Tickets t --найти все суммы с последней датой
        GROUP BY t.TotalAmount, t.PassangerId

 -- ОСТАЛОСЬ ПРИДЕЛАТЬ ИМЕНА
   -- не работает
SELECT pa.PassangerName,

(SELECT t.PassangerId, t.TotalAmount, MAX(t.BookDate) FROM Tickets t --найти все суммы с последней датой --А ПОТОМУ, ЧТО, ЕСЛИ ВО ВЛОЖЕННЫХ ЦИКЛАХ ИСПОЛЬЗ-СЯ GROUP BY, 
                                                                       --ТО В select-e М. Б. ТОЛЬКО ОДНО ВЫРАЖЕНИЕ (и если подзапрос не вводится с помощью EXIST)
  WHERE t.PassangerId = t.PassangerId
        GROUP BY t.TotalAmount, t.PassangerId)

  FROM Passangers pa

-- что-то такое тоже не работает
  SELECT pa.PassangerName FROM Passangers pa
    WHERE ( t.BookDate) IN

(SELECT t.TotalAmount, MAX(t.BookDate) FROM Tickets t 
 -- WHERE pa.PassangerId = t.PassangerId
        GROUP BY t.TotalAmount)
  
  
--предложенный запрос из телеграма 1. Отлично работает!
  --++++++++++++++++++
  -- В списке выбора можно указать только одно выражение, 
  -- если подзапрос не вводится с помощью EXISTS.
	SELECT 

    (SELECT t.PassangerId FROM Tickets t 
  WHERE t.PassangerId = pa.PassangerId
        GROUP BY t.TotalAmount, t.PassangerId), --вот так можно GROUP BY делать

    pa.PassangerId, -- выводит тот же PassangerId, только из таблицы pa

    (SELECT t.TotalAmount FROM Tickets t 
  WHERE t.PassangerId = pa.PassangerId
        GROUP BY t.TotalAmount, t.PassangerId),

    (SELECT MAX(t.BookDate) FROM Tickets t 
  WHERE t.PassangerId = pa.PassangerId
        GROUP BY t.TotalAmount, t.PassangerId),

    pa.PassangerName

  FROM Passangers pa 
   --+++++++++++++++++++

    --предложенный запрос 2. Отлично работает! --По сути, это тот же JOIN, но максимальное ищется в блоке ON, а не SELECT, откуда, его потом убирать приходилось.
  --*************************
SELECT pa.PassangerName, pa.PassangerId FROM Passangers pa,Tickets t 

    WHERE pa.PassangerId = t.PassangerId --по сути сджойнили две таблицы и выбрали дату на (ON)
  AND ( t.BookDate) IN

(SELECT  MAX(t.BookDate) FROM Tickets t 
  WHERE pa.PassangerId = t.PassangerId
        GROUP BY t.TotalAmount) --f чтоб по сумме в итоге было

    GROUP BY pa.PassangerName,  pa.PassangerId -- без этого GROUP BY верхний select не выполняется
  --************************

     --предложенный запрос 2, переделал с JOIN. Так выводятсятолько неповтор-ся имена. Еесли добавить еще столбец на вывод- то начнут повторяться
  --*************************
SELECT pa.PassangerName FROM Passangers pa
  JOIN Tickets t

    ON (pa.PassangerId = t.PassangerId) 
       AND ( t.BookDate) IN

(SELECT  MAX(t.BookDate) FROM Tickets t 
  WHERE pa.PassangerId = t.PassangerId
        GROUP BY t.TotalAmount)

    GROUP BY pa.PassangerName   --это GROUP BY убирает дубликаты верхнего select-а
  --************************


--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--Тут самые правильные данные получились
-- Теперь обращаемся в подзапросе к данным которые есть в источнике
SELECT PassangerName, BookDate,TotalAmount
FROM
 (
  
  SELECT pa.PassangerName, T.BookDate , (SELECT TOP(1) tt.TotalAmount FROM 
  Tickets tt ) AS TotalAmount
  FROM Passangers pa,Tickets t 
	
    WHERE pa.PassangerId = t.PassangerId 
	AND ( t.BookDate) IN

(SELECT  MAX(t.BookDate) FROM Tickets t 
  WHERE pa.PassangerId = t.PassangerId
        GROUP BY t.TotalAmount)

		GROUP BY pa.PassangerName,T.BookDate
	
  ) AS One --написать имя подзапроса обязательно!

--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
--Тут самые правильные данные получились --ПЕРЕПИСАНО С JOIN, убран неправильный столбец и попытки его переделывать
-- Теперь обращаемся в подзапросе к данным которые есть в источнике
  
  SELECT pa.PassangerName, t.BookDate FROM Passangers pa
	  JOIN Tickets t 
    
    ON (pa.PassangerId = t.PassangerId)          --объединение таблиц по Id 
	     AND ( t.BookDate) IN                      --и по тому признаку, что дата максимальная из возможных

       (SELECT  MAX(t.BookDate) FROM Tickets t 
        WHERE pa.PassangerId = t.PassangerId )    --для Id пассажира, который рассмвтривается во внешнем select-e
      
		GROUP BY pa.PassangerName,T.BookDate--, t.TotalAmount --убирание дубликатов по имени
	
--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 --пришлось делать join, ТУТ ВСЁ ПРОСТО
  SELECT pa.PassangerName, t.TotalAmount, MAX(t.BookDate) FROM Tickets t 
    JOIN Passangers pa
    ON t.PassangerId = pa.PassangerId
        GROUP BY t.TotalAmount, pa.PassangerName
    

    --но СТОП, последнюю колонку не надо выводить. ТЕПЕРЬ ВСЁ ОК!
   SELECT PassNam, LastDate FROM 

  (SELECT pa.PassangerName PassNam,  MAX(t.BookDate) LastDate FROM Tickets t 
    JOIN Passangers pa
    ON t.PassangerId = pa.PassangerId
        GROUP BY pa.PassangerName ) SubQuery --написать имя подзапроса обязательно!

    GROUP BY PassNam, LastDate
    --НО дубликаты по имени я так и не убрал. они возникают от того, что людей с одним именем много в списке купленных билетов
    




    --*
