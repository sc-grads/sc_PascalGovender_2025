Select BusinessEntityID, FirstName,LastName, Title
from Person.Person
where title = 'mr.'

-- # used to create and tell that it is a temp table--
--temp table are created and stored only within the session--

DROP TABLE #TempPersonTable;
CREATE TABLE #TempPersonTable(
BusinessEntityID int,
FirstName nvarchar(50),
LastName nvarchar(50),
Title nvarchar(50)
)

--temp table is created of existing data
DROP TABLE #TempPersonTable;
Select BusinessEntityID, FirstName,LastName, Title
into #TempPersonTable                                --name and to create a temporary table
from Person.Person
where title = 'mr.'

Select * FROM #TempPersonTable;