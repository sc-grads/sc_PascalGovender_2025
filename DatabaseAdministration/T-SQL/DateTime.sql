DECLARE @mydate AS DATETIME = '2015-06-24 12:34:56.124';
SELECT @mydate AS myDate;

DECLARE @mydate2 AS DATETIME2(3) = '20150624 12:34:56.124';
SELECT @mydate2 AS MyDate;

SELECT DATEFROMPARTS(2015, 06, 24) AS ThisDate;
SELECT DATETIME2FROMPARTS(2015, 06, 24, 12, 34, 56, 124, 5) AS ThatDate;
SELECT YEAR(@mydate) AS myYear, MONTH(@mydate) AS myMonth, DAY(@mydate) AS myDay;

----------------------------------------------------------------------------------------------------
-----------------DATE FUNCTIONS
SELECT CURRENT_TIMESTAMP AS RightNow;
SELECT GETDATE() AS RightNow;
SELECT SYSDATETIME() AS RightNow;
SELECT DATEADD(YEAR, 1, '2015-01-02 03:04:05') AS myYear;
SELECT DATEPART(HOUR, '2015-01-02 03:04:05') AS myHour;
SELECT DATENAME(WEEKDAY, GETDATE()) AS myDay;
SELECT DATEDIFF(SECOND, '2015-01-02 03:04:05', GETDATE()) AS SecondsElapsed;

----------------------------------------------------------------------------------------------------
---------------------DATE OFFSETS
DECLARE @myDateOffset AS DATETIMEOFFSET(2) = '2015-06-25 01:02:03.456 +05:30'; -- 8-10 bytes
SELECT @myDateOffset AS MyDateOffset;
GO

DECLARE @myDate AS DATETIME2 = '2015-06-25 01:02:03.456';
SELECT TODATETIMEOFFSET(@myDate, '+05:30') AS MyDateOffset;

SELECT DATETIME2FROMPARTS(2015, 06, 25, 1, 2, 3, 456, 3);
SELECT DATETIMEOFFSETFROMPARTS(2015, 06, 25, 1, 2, 3, 456, 5, 30, 3) AS MyDateOffset;

SELECT SYSDATETIMEOFFSET() AS TimeNowWithOffset;
SELECT SYSUTCDATETIME() AS TimeNowUTC;

DECLARE @myDateOffset AS DATETIMEOFFSET = '2015-06-25 01:02:03.456 +05:30';
SELECT SWITCHOFFSET(@myDateOffset, '-05:00') AS MyDateOffsetTexas;

----------------------------------------------------------------------------------------------------
----------------DATES TO STRINGS
DECLARE @mydate AS DATETIME = '2015-06-25 01:02:03.456';
SELECT 'The date and time is: ' + @mydate; ---won't work...
GO

DECLARE @mydate AS DATETIME = '2015-06-25 01:02:03.456';
SELECT 'The date and time is: ' + CONVERT(NVARCHAR(20), @mydate, 104) AS MyConvertedDate;
GO

DECLARE @mydate AS DATETIME = '2015-06-25 01:02:03.456';
SELECT CAST(@mydate AS NVARCHAR(20)) AS MyCastDate;

SELECT TRY_CONVERT(DATE, 'Thursday, 25 June 2015') AS MyConvertedDate;
SELECT PARSE('Thursday, 25 June 2015' AS DATE) AS MyParsedDate;
SELECT PARSE('Jueves, 25 de junio de 2015' AS DATE USING 'es-ES') AS MySpanishParsedDate;

SELECT FORMAT(CAST('2015-06-25 01:02:03.456' AS DATETIME), 'D') AS MyFormattedLongDate;
SELECT FORMAT(CAST('2015-06-25 01:02:03.456' AS DATETIME), 'd') AS MyFormattedShortDate;
SELECT FORMAT(CAST('2015-06-25 01:59:03.456' AS DATETIME), 'dd-MM-yyyy') AS MyFormattedBritishDate;
SELECT FORMAT(CAST('2015-06-25 01:02:03.456' AS DATETIME), 'D', 'zh-CN') AS MyFormattedInternationalLongDate;
