
--first value is total length, second value is how many of total is after the decimal
DECLARE @myvar as numeric(7,2) 
--DECLARE @myvar as decimal(7,2)

SET @myvar = 12345.67

SELECT @myvar AS myVariable

GO

DECLARE @myvar as numeric(18,8) -- 9 bytes needed
--DECLARE @myvar as decimal(18,8)

SET @myvar = 1000000000.12345678

SELECT @myvar AS myVariable 

-- 1,000,000,000.12345678 is numeric(18,8)

GO

DECLARE @myvar AS smallmoney = 123456.78917

select @myvar as myVariable

GO

DECLARE @myvar AS float(24) = 123456.7891

Select @myvar as myVariable 
