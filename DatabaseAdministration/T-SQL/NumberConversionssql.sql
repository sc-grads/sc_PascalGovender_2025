DECLARE @myvar as Decimal(5,2) = 3
SELECT @myvar

--convert(type, value)
SELECT CONVERT(decimal(5,2),3)

--cast(value as type)
SELECT CAST(3 as decimal(5,2))

SELECT CONVERT(INT,12.345) + CONVERT(INT,12.7) 
SELECT CONVERT(INT,12.345 + 12.7)

--try_convert(type, value)
--used if values cannot be converted so returns null for such instead of throwing errors