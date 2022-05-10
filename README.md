# T-SQL_lessons
## Lesson No.: 3
--Additional task

--From the database created in the previous lesson, get the following selections:
-- -Numbers of aircraft whose flight distance exceeds 1000 or is indefinite.
-- - The names of all airports, the first character of the city name of which is the letter A, B or C, also, the time zone has a positive time component.
-- -Only unique flight numbers whose destination airports did not match the real airport where the plane landed.

## Lesson No.: 4
--Additional task
--Using the functions learned in the lesson, get the following results: Dates:
--today, three months ago and 5 days ago, also present all these dates as constituent parts

--Task 1
--Using the functions learned in the lesson, get the following results:
---Get a selection of all booking objects that were made in the last month. Implement several options.
---Get a selection from the ticket table, replace all missing values of the user's contact information with the string "Undefined"

## Lesson No.: 5
--Additional task
--Connecting to the HomeTask database, using aggregate functions and system tables, count the number of tables in this database.

--Task 1
--Get the average of the range of the aircraft and the average of the unique ranges.

--Task 2
--Get the number of bookings and their average cost

--Connecting to the HomeTask database, using aggregate functions and system tables, count the number of tables in this database. 

## Lesson No.: 6
--Additional Task
--After analyzing the HomeTask database tables, ensure entity/referential integrity using learned approaches

--Task 1
--Add some custom input restrictions to handle possible invalid values.

--Task 2
--After analyzing the tables and options for possible queries to them, impose restrictions on the uniqueness of values for possible target fields of tables.

## Lesson No.: 7
--Additional task
--After analyzing the HomeTask database tables, ensure entity/referential integrity using learned approaches

--Task 1
--Normalize the given table.

--Task 2
--Normalize all database tables. Argue the need for normal forms for each table.

## Lesson No.: 8
--Task 1
--Take samples that meet the following criteria:
-- - Airport with the most flights
-- - Name of cities and cost of tickets to them
-- - Names of passengers, the cost of the tickets they booked, the cost of the reservation and other tickets of these passengers

## Lesson No.: 9
--Additional task
-- Using set operators, get a list of flights that have scheduled and
-- actual destination airport does not match

--Task 1
-- Create views for the following selections:
-- - Ticket number, flight number, destination airport name, actual arrival airport name
-- - Flight number, tail number of the aircraft, number of seats in it.

## Lesson No.: 10
--Using the approaches studied, make the following selections:
-- - List of flight numbers for aircraft with maximum range.
-- - Flight numbers, names of destination cities, aircraft models.
-- - Names of passengers, cost of their last ticket.

## Lesson No.: 11

--Additional task
--Determine the missing index type for the ticket table and create it.

--Task 1
--Create an index to fetch the flight number (FlightNumber), destination airport (ArrivalAirport) and its status (Status).

--Task 2
--After reviewing all previous homework assignments, create non-clustered indexes for
--all columns, which often appear in query predicates.

## Lesson No.: 12
--Additional task
--Create a loop that will break as soon as its integer counter is a multiple of 3, 4, 5.

--Task 1
--Write an algorithm to determine whether the value of some integer variable is a prime number.

--Task 2
--Write an algorithm that will determine the largest prime divisor of the value of some integer variable.

## Lesson No.: 13
--Additional task
--Create a procedure that will make a selection for task 3 of lesson 10.
--perform the following selection: Names of passengers, cost of their last ticket.

--Task 1
--Write a function that will be a filter function for the flight distance of the aircraft.
--Using this function, get a selection of unique aircraft models whose flight range exceeds 500 km.

--Task 2
--Rewrite task 3 of the previous lesson using procedures.
--Write an algorithm that will determine the largest prime divisor of the value of some integer variable
