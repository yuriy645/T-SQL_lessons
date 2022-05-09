--Lesson No.: 11

--Additional task
--Determine the missing index type for the ticket table and create it.

--Task 1
--Create an index to fetch the flight number (FlightNumber), destination airport (ArrivalAirport) and its status (Status).

--Task 2
--After reviewing all previous homework assignments, create non-clustered indexes for
--all columns, which often appear in query predicates.

  --� ������� Tickets �������� ��� ������� ���� � FK PassangerId, �� �������� ���� ������� � ���� Passangers.
  --�������� �� ������ �� ����������, ���������� ������ ��� ���� �. �. ���������� PRIMARY KEY. ������ ������ ������������ ������������.
  --���� �������� ������ :
  CREATE INDEX index_Tickets_PassangerId 
  ON Tickets (PassangerId)
  
  --��������, ���� ����� ������� ������ ��� ��������������� ���� - BookDate. ���������� ������ ��� ����,
  --���������� ���� ���� �� �����. ������, ����� �������� ������������ ������������ ������.
  --������ ����� ��������� :
  CREATE INDEX index_Tickets_BookDate
  ON Tickets (BookDate)

 --������� 1
--Create an index to fetch the flight number (FlightNumber), destination airport (ArrivalAirport) and its status (Status).
  �� STATUS ����� �� ������ ��������, ������ ��� ��� ���� ��������������� � ��� ������ ���������� ��� ������������� ������.
  ����� ���� �� ��������� ������������ ������������ ������� �� ���� FlightNumber � ArrivalAirport ���, ��� ��� 
  �������� FOREIGN KEY. �� ������� Flights (� ����� FK FlightNumber)  ������ ��������, ��� ���, ��� ��� ������ �� ������.
  ������� :
  CREATE INDEX index_Schedule_ArrivalAirport
  ON Schedule (ArrivalAirport)

--Task 2
--After reviewing all previous homework assignments, create non-clustered indexes for
--all columns, which often appear in query predicates.
  --����������� ����� :

  --Planes- ������ ������� ��������� �� ����� �����- �������� �� ������.

  --Flights- ��� �� ���� ����� �� �����, ��� ��������� �������� ����������- �������� �� ������.

  --Tickets- ��� ������� � �������������� �������

  --Passangers- ��������� ����� ��������� ������ ���� �� PassangerName. ������ ������ �����������.
  CREATE INDEX index_Passangers_PassangerName
  ON Passangers (PassangerName)

  --AirPorts- �� City ����� ����� ���������. ������ �����������.
  CREATE INDEX index_AirPorts_City
  ON AirPorts (City)

  --Schedule- ��������� ����� ������� �� DepartureAirport, ArrivalAirport, ScheduledDeparture, ScheduledAirport
  CREATE INDEX index_Schedule_DepartureAirport
  ON Schedule (DepartureAirport)
  CREATE INDEX index_Schedule_ArrivalAirport
  ON Schedule (ArrivalAirport)
  CREATE INDEX index_Schedule_ScheduledDeparture
  ON Schedule (ScheduledDeparture)
  CREATE INDEX index_Schedule_ScheduledAirport
  ON Schedule (ScheduledAirport)

  --Aircrafts- ����� ����� ������������� AircraftCode
  CREATE INDEX index_Aircrafts_AircraftCode
  ON Aircrafts (AircraftCode)

  TicketFlies- ������ �� TicketNumber, FareConditions
  CREATE INDEX index_TicketFlies_TicketNumber
  ON TicketFlies (TicketNumber)
  CREATE INDEX index_TicketFlies_TicketNumber
  ON TicketFlies (TicketNumber)



--DROP DATABASE HomeTask_9 
CREATE DATABASE HomeTask_9 
 GO     

ALTER DATABASE HomeTask_9
COLLATE Cyrillic_General_CI_AS	
GO

USE HomeTask_9

--������� AirPorts - ���������.Cities + AirPorts
--� ����� ������ ������ ����� ���� ��������� ����������. ������� ������ ����� �����������.
--��������� ���� ������ ��������� �� � ����������� GPS, � � ������, �. �. ���������� �������� ��������� ���� 
--����������� ��� ����������������� �������� � ������ ������ ������ ����� ���������� ��������� ���� ��������� ����.
--������ ����� � ��������� ����� ������� � ��������� �������.
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
		('134','n1234','�����������','10','98',4),
		('356','n9234','lviv',       '26','23',5),
		('758','n1234','varshava',   '46','54',6),
		('125','n7234','Chandler',   '85','79',7),
		('769','n9z34','odesa',      '68','37',8),
		('879','n9j34','��������',  '35','19',9),
		('435','n9h34','Berlin',    '54','40',10),
    ('135','n7234','Chandler',   '85','79',11),
		('136','n9z34','odesa',      '68','37',12),
		('491','n9j34','��������',  '35','19',13),
		('679','n9h34','Berlin',    '54','40',14)
	GO										   

--������� AirCrafts - �������. Planes + AirCrafts
--������� �� �������� ���� - AircraftCode, ������ Model � ���� ������������� ������. ��������� ������� ������, ��� �������� �����, ������� ������, ��������������� ������ ����� �����������.
--������, ���� ������� ������� ���������� ����., � � ����. AirCrafts ����������� Id ������ ��������.
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

--������� TicketFlies- ��� �� ������ ���� "������� �����", �. �. �������� ����� ���������� � ��������� �������� ��������������, 
--��������������� ����������� ��������� �� ������� ����. ���� ����������� �������� ����� ���������, �� ����� ������������ : 
--FlightId- ����� �����, BoardingNumber- ����� ������� (����, � ����� �� ����, ��������, ��� ���� ����������� �� TicketNumber ��� ����� �������������),
--SeatNumber- ������������� �������. 
--��������� ������� ��� ������ �����������. FareConditions- ������� ������- ����� ������� ��������� ��������, �. �. ������� �� �����.
--Ammount- ���� ��������������, ����� ��� ����� ���� ��������� ������������ FareConditions, �� ����� ��������������� ������������� �������� ������ 
--������� ��������� ��� ����� ����� ���� ������ �������� �������������� ����.
--TicketNumber- ������ ����� �������������������� � ������� �������� ��������.

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

--����. Tickets - ������ Passangers + Tickets
--�������� ������� �� 2-� ������ : 
--1 ���� � �������� �������
--2 ���� � ����������, ������� ����� �����������
--������ ���������� ������� � ��������� �������.

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
   ( '451345'  ,'����1', NULL), 
	 ( '899999'  ,'����2','���� �������'),
	 ( '839999'  ,'����3','���� 3 ������ �����'), 
	 ( '899929'  ,'����2','���� 5 ���� �����'),
   ( '45143345','����', NULL), 
	 ( '893999'  ,'����','���� �������'),
	 ( '6499999' ,'����','���� 3 ������ �����'),
   ( '6499599' ,'����','���� 3 ������ �����'),
   ( '4514345' ,'��������', NULL), 
	 ( '89391099','�����','���� �������')
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


--������� Flights  Schedule + Flights
--�������� �������� ������������� ����� �����, ������� ����� ������� � PK FlightNumber � ��������� ����� ����� �� ���������� �������,
--������� ����������� �� �����.

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



    --*++