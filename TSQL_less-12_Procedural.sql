--Lesson No.: 12
--Additional task
--Create a loop that will break as soon as its integer counter is a multiple of 3, 4, 5.

--Task 1
--Write an algorithm to determine whether the value of some integer variable is a prime number.

--Task 2
--Write an algorithm that will determine the largest prime divisor of the value of some integer variable.


--Additional task
--Create a loop that will break as soon as its integer counter is a multiple of 3, 4, 5.
  
  --� ���� 
DECLARE @counter int = 0
WHILE @counter < 30
BEGIN	
	
  SET @counter = @counter + 1
	PRINT 'counter: ' + CAST(@counter as varchar)

	IF @counter % 3 = 0
    BEGIN
    PRINT '������ 3' 
    BREAK
    END 

  IF @counter % 4 = 0
    BEGIN
    PRINT '������ 4' 
    BREAK
    END
      
  IF @counter % 5 = 0
    BEGIN
    PRINT '������ 5' 
    BREAK 
    END
 
END

  --C ������ 
DECLARE @counter int = 0
WHILE @counter < 30
BEGIN	
	
  SET @counter = @counter + 1
	PRINT 'counter: ' + CAST(@counter as varchar)

 PRINT CASE 
		WHEN @counter %3 = 0 THEN  '������ 3' 
		WHEN @counter %4 = 0 THEN  '������ 4' 
		WHEN @counter %5 = 0 THEN  '������ 5' 
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
 WHILE @x < @counter --���� ���������� ����� �� ���, ����� 1 � ���� ������. ���� ���� ���� ���� 0-��� ������� �� �������, �� ����� �� �������
  BEGIN
    IF (@counter % @x = 0) BEGIN  PRINT '����� �� �������' BREAK END
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
 WHILE @x < @counter --���� ���������� ����� �� ���, ����� 1 � ���� ������. ���� ���� ���� ���� 0-��� ������� �� �������, �� ����� �� �������
  
  BEGIN --����� ��������
    IF (@counter % @x = 0) --���� ����������� ��������

      BEGIN  
      PRINT '� ����� ���� ��������: ' + CAST(@counter/@x as varchar)  --������� ���
         -----��� ��������, ������� �� ��. ���� ���������, �� ������� ��� � ����� ��� ������ �������������
            SET @x1 = 2
            SET @oneCount = 0
           
           WHILE @x1 < @counter/@x --����� ���������� @x1 ��� ������ ���������� ����� ��� ����� ���������
           BEGIN    
           IF ((@counter/@x) % @x1 = 0) --���� ����������� �� ������� ��������   
                
                BEGIN
             
                IF @oneCount = 0 PRINT '��������� �������� ' + CAST(@counter/@x as varchar) + ' �� �������'
                SET @oneCount= @oneCount+1 --���� 1 ��� ��������, ��� ����������� �� ������� �������� 

                IF ((@counter/@x) > @maxDiv) SET @maxDiv = @counter/@x --���������� ���, ���� �� > �����������
                END
                
            SET @x1 = @x1 + 1	
            END    
               
          ------
      END

    SET @x = @x + 1	
  END
  IF @maxDiv>1 PRINT '������������ �� ������� ��������: ' + CAST(@maxDiv as varchar)  --���� ���� �������� ���������- �� ������� ���

SET @counter = @counter + 1

END
--****

