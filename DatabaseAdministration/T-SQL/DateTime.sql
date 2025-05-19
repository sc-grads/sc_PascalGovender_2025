declare @mydate as datetime = '2015-06-24 12:34:56.124'
select @mydate as myDate

declare @mydate2 as datetime2(3) = '20150624 12:34:56.124'
select @mydate2 as MyDate

select DATEFROMPARTS(2015,06,24) as ThisDate;
select DATETIME2FROMPARTS(2015,06,24,12,34,56,124,5) as ThatDate;
select year(@mydate) as myYear, month(@mydate) as myMonth, day(@mydate) as myDay;

----------------------------------------------------------------------------------------------------
-----------------DATE FUNCTIONS
SELECT CURRENT_TIMESTAMP as RightNow;
select getdate() as RightNow;
select SYSDATETIME() AS RightNow;
select dateadd(year,1,'2015-01-02 03:04:05') as myYear;
select datepart(hour,'2015-01-02 03:04:05') as myHour;
select datename(weekday, getdate()) as myDay;
select datediff(second,'2015-01-02 03:04:05',getdate()) as SecondsElapsed;

----------------------------------------------------------------------------------------------------
---------------------DATE OFFSETS
declare @myDateOffset as datetimeoffset(2) = '2015-06-25 01:02:03.456 +05:30' -- 8-10 bytes
select @myDateOffset as MyDateOffset
go
declare @myDate as datetime2 = '2015-06-25 01:02:03.456'
select TODATETIMEOFFSET(@myDate,'+05:30') as MyDateOffset;

select DATETIME2FROMPARTS     (2015,06,25,1,2,3,456,     3);
select DATETIMEOFFSETFROMPARTS(2015,06,25,1,2,3,456,5,30,3) as MyDateOffset;

select SYSDATETIMEOFFSET() as TimeNowWithOffset;
select SYSUTCDATETIME() as TimeNowUTC;

declare @myDateOffset as datetimeoffset = '2015-06-25 01:02:03.456 +05:30'
select SWITCHOFFSET(@myDateOffset,'-05:00') as MyDateOffsetTexas
----------------------------------------------------------------------------------------------------
----------------DATES TO STRINGS
declare @mydate as datetime = '2015-06-25 01:02:03.456'
select 'The date and time is: ' + @mydate ---won't work...
go

declare @mydate as datetime = '2015-06-25 01:02:03.456'
select 'The date and time is: ' + convert(nvarchar(20),@mydate,104) as MyConvertedDate
go

declare @mydate as datetime = '2015-06-25 01:02:03.456'
select cast(@mydate as nvarchar(20)) as MyCastDate;

select try_convert(date,'Thursday, 25 June 2015') as MyConvertedDate;
select parse('Thursday, 25 June 2015' as date) as MyParsedDate;
select parse('Jueves, 25 de junio de 2015' as date using 'es-ES') as MySpanishParsedDate;

select format(cast('2015-06-25 01:02:03.456' as datetime),'D') as MyFormattedLongDate;
select format(cast('2015-06-25 01:02:03.456' as datetime),'d') as MyFormattedShortDate;
select format(cast('2015-06-25 01:59:03.456' as datetime),'dd-MM-yyyy') as MyFormattedBritishDate;
select format(cast('2015-06-25 01:02:03.456' as datetime),'D','zh-CN') as MyFormattedInternationalLongDate;

