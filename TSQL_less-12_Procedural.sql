--Lesson No.: 12
--Additional task
--Create a loop that will break as soon as its integer counter is a multiple of 3, 4, 5.

--Task 1
--Write an algorithm to determine whether the value of some integer variable is a prime number.

--Task 2
--Write an algorithm that will determine the largest prime divisor of the value of some integer variable.


--Additional task
--Create a loop that will break as soon as its integer counter is a multiple of 3, 4, 5.
  
  --С ифом 
DECLARE @counter int = 0
WHILE @counter < 30
BEGIN	
	
  SET @counter = @counter + 1
	PRINT 'counter: ' + CAST(@counter as varchar)

	IF @counter % 3 = 0
    BEGIN
    PRINT 'кратно 3' 
    BREAK
    END 

  IF @counter % 4 = 0
    BEGIN
    PRINT 'кратно 4' 
    BREAK
    END
      
  IF @counter % 5 = 0
    BEGIN
    PRINT 'кратно 5' 
    BREAK 
    END
 
END

  --C кейсом 
DECLARE @counter int = 0
WHILE @counter < 30
BEGIN	
	
  SET @counter = @counter + 1
	PRINT 'counter: ' + CAST(@counter as varchar)

 PRINT CASE 
		WHEN @counter %3 = 0 THEN  'кратно 3' 
		WHEN @counter %4 = 0 THEN  'кратно 4' 
		WHEN @counter %5 = 0 THEN  'кратно 5' 
	END

END

  

---Task 1
--Write an algorithm to determine whether the value of some integer variable is a prime number.
DECLARE @counter int = 0
DECLARE @x INT

WHILE @counter < 30
BEGIN	
	 
	PRINT 'counter: ' + CAST(@counter as varchar)

 SET @x = 2
 WHILE @x < @counter --делю испытуемое число на все, кроме 1 и себя самого. Если есть хоть один 0-вой остаток от деления, то число не простое
  BEGIN
    IF (@counter % @x = 0) BEGIN  PRINT 'число НЕ простое' BREAK END
    SET @x = @x + 1	
  END

SET @counter = @counter + 1

END


--Task 2
--Write an algorithm that will determine the largest prime divisor of the value of some integer variable.


DECLARE @counter int = 0
DECLARE @x INT
DECLARE @x1 INT
DECLARE @maxDiv INT
DECLARE @oneCount INT 

WHILE @counter < 30
BEGIN	
	 
	PRINT 'counter: ' + CAST(@counter as varchar)

 SET @x = 2
 SET @maxDiv = 1
 WHILE @x < @counter --делю испытуемое число на все, кроме 1 и себя самого. Если есть хоть один 0-вой остаток от деления, то число не простое
  
  BEGIN --поиск делителя
    IF (@counter % @x = 0) --если обнаружился делитель

      BEGIN  
      PRINT 'у числа есть делитель: ' + CAST(@counter/@x as varchar)  --выводим его
         -----тут проверим, простой ли он. если непростой, то выведем его и учтем для поиска максимального
            SET @x1 = 2
            SET @oneCount = 0
           
           WHILE @x1 < @counter/@x --новая переменная @x1 для поиска непростого числа уже среди делителей
           BEGIN    
           IF ((@counter/@x) % @x1 = 0) --если обнаружился НЕ простой делитель   
                
                BEGIN
             
                IF @oneCount = 0 PRINT 'найденный делитель ' + CAST(@counter/@x as varchar) + ' не простой'
                SET @oneCount= @oneCount+1 --чтоб 1 раз выводить, что обнаружился НЕ простой делитель 

                IF ((@counter/@x) > @maxDiv) SET @maxDiv = @counter/@x --запоминаем его, если он > предыдущего
                END
                
            SET @x1 = @x1 + 1	
            END    
               
          ------
      END

    SET @x = @x + 1	
  END
  IF @maxDiv>1 PRINT 'Максимальный не простой делитель: ' + CAST(@maxDiv as varchar)  --если макс делитель находился- то выводим его

SET @counter = @counter + 1

END
--****

