Select
    BUSINESSENTITYID,
    FIRSTNAME,
    LASTNAME,
    TITLE
From PERSON.PERSON
Where TITLE = 'mr.'

-- # used to create and tell that it is a temp table--
--temp table are created and stored only within the session--

Drop Table #TempPersonTable;
Create Table #TempPersonTable (
    BUSINESSENTITYID int,
    FIRSTNAME nvarchar(50),
    LASTNAME nvarchar(50),
    TITLE nvarchar(50)
)

--temp table is created of existing data
Drop Table #TempPersonTable;
Select
    BUSINESSENTITYID,
    FIRSTNAME,
    LASTNAME,
    TITLE
Into #TempPersonTable                                --name and to create a temporary table
From PERSON.PERSON
Where TITLE = 'mr.'

Select * From #TempPersonTable;
