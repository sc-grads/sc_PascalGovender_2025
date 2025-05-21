-- Declare a DATETIME variable (older SQL Server date/time type)
DECLARE @mydate AS DATETIME = '2015-06-24 12:34:56.124';
SELECT @mydate AS myDate;

-- DATETIME2 allows more accurate and has a larger date range than DATETIME
DECLARE @mydate2 AS DATETIME2(3) = '20150624 12:34:56.124';
SELECT @mydate2 AS MyDate;

-- Returns a DATE from individual year, month, day parts
SELECT DATEFROMPARTS(2015, 06, 24) AS ThisDate;

-- Constructs a DATETIME2 from detailed values
SELECT DATETIME2FROMPARTS(2015, 06, 24, 12, 34, 56, 124, 5) AS ThatDate;

-- Extracts individual date values from a DATETIME value
SELECT YEAR(@mydate) AS myYear, MONTH(@mydate) AS myMonth, DAY(@mydate) AS myDay;
--=========================================================================================
-----------------DATE FUNCTIONS

-- CURRENT_TIMESTAMP is ANSI SQL; equivalent to GETDATE()
SELECT CURRENT_TIMESTAMP AS RightNow;

-- Returns current date and time (with milliseconds)
SELECT GETDATE() AS RightNow;

-- Higher precision system datetime (includes fractional seconds beyond milliseconds)
SELECT SYSDATETIME() AS RightNow;

-- Add 1 year to a specified date
SELECT DATEADD(YEAR, 1, '2015-01-02 03:04:05') AS myYear;

-- Extracts just the hour part of the time
SELECT DATEPART(HOUR, '2015-01-02 03:04:05') AS myHour;

-- Returns the name of the weekday (e.g., Monday)
SELECT DATENAME(WEEKDAY, GETDATE()) AS myDay;

-- Difference in seconds between two date values
SELECT DATEDIFF(SECOND, '2015-01-02 03:04:05', GETDATE()) AS SecondsElapsed;

--=========================================================================================
---------------------DATE OFFSETS

-- DATETIMEOFFSET includes time zone offset info (e.g., +05:30)
DECLARE @myDateOffset AS DATETIMEOFFSET(2) = '2015-06-25 01:02:03.456 +05:30'; -- 8-10 bytes
SELECT @myDateOffset AS MyDateOffset;
GO

-- Converts a DATETIME2 to a DATETIMEOFFSET by assigning a time zone
DECLARE @myDate AS DATETIME2 = '2015-06-25 01:02:03.456';
SELECT TODATETIMEOFFSET(@myDate, '+05:30') AS MyDateOffset;

-- Creates a DATETIME2 from its parts
SELECT DATETIME2FROMPARTS(2015, 06, 25, 1, 2, 3, 456, 3);

-- Creates a DATETIMEOFFSET with full control over date, time, offset, and precision
SELECT DATETIMEOFFSETFROMPARTS(2015, 06, 25, 1, 2, 3, 456, 5, 30, 3) AS MyDateOffset;

-- Current system time with offset
SELECT SYSDATETIMEOFFSET() AS TimeNowWithOffset;

-- Current UTC system time (no offset)
SELECT SYSUTCDATETIME() AS TimeNowUTC;

-- Adjusts the time zone offset of a DATETIMEOFFSET (value stays same in UTC terms)
DECLARE @myDateOffset AS DATETIMEOFFSET = '2015-06-25 01:02:03.456 +05:30';
SELECT SWITCHOFFSET(@myDateOffset, '-05:00') AS MyDateOffsetTexas;

--=========================================================================================
----------------DATES TO STRINGS

-- Convert DATETIME to NVARCHAR with style 104 (German date format: dd.mm.yyyy)
DECLARE @mydate AS DATETIME = '2015-06-25 01:02:03.456';
SELECT 'The date and time is: ' + CONVERT(NVARCHAR(20), @mydate, 104) AS MyConvertedDate;
GO

-- Another way to convert: using CAST to NVARCHAR
DECLARE @mydate AS DATETIME = '2015-06-25 01:02:03.456';
SELECT CAST(@mydate AS NVARCHAR(20)) AS MyCastDate;

-- TRY_CONVERT attempts a conversion; returns NULL on failure
SELECT TRY_CONVERT(DATE, 'Thursday, 25 June 2015') AS MyConvertedDate;

-- PARSE supports date formats using language-specific parsing
SELECT PARSE('Thursday, 25 June 2015' AS DATE) AS MyParsedDate;

-- Parse a Spanish-format date using 'es-ES'
SELECT PARSE('Jueves, 25 de junio de 2015' AS DATE USING 'es-ES') AS MySpanishParsedDate;

-- FORMAT allows custom output formatting of date/time values
SELECT FORMAT(CAST('2015-06-25 01:02:03.456' AS DATETIME), 'D') AS MyFormattedLongDate; -- e.g., "Thursday, June 25, 2015"
SELECT FORMAT(CAST('2015-06-25 01:02:03.456' AS DATETIME), 'd') AS MyFormattedShortDate; -- e.g., "6/25/2015"
SELECT FORMAT(CAST('2015-06-25 01:59:03.456' AS DATETIME), 'dd-MM-yyyy') AS MyFormattedBritishDate; -- e.g., "25-06-2015"
SELECT FORMAT(CAST('2015-06-25 01:02:03.456' AS DATETIME), 'D', 'zh-CN') AS MyFormattedInternationalLongDate; -- Chinese format
