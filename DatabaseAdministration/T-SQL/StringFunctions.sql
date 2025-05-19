
DECLARE @chrASCII as varchar(10) = 'hellothere'

DECLARE @chrUNICODE as nvarchar(10) = N'helloϞ'
select @chrASCII + ' '+@chrASCII

select left(@chrASCII,2) as myASCII, right(@chrUNICODE,2) as myUNICODE

select substring(@chrASCII,3,2) as middleletters

--left trim and right trim
select ltrim(rtrim(@chrASCII)) as myTRIM

--replacing letters
select replace(@chrASCII,'l','L') as myReplace

--lower() for lower case
select upper(@chrASCII) as myUPPER
