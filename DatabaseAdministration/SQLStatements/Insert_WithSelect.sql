--NEW TABLE- salesStaffNew--

CREATE TABLE [dbo].[salesStaffNew] (
    ID [int] NOT NULL IDENTITY PRIMARY KEY,
    [staffid] [int] NOT NULL,
    [fName] [nvarchar](30),
    [lName] [nvarchar](30)
)

GO

SELECT * FROM SALESSTAFFNEW

INSERT INTO [dbo].[salesStaffNew] (STAFFID, FNAME, LNAME) VALUES (200, 'Abbas', 'Mehmood')

INSERT INTO [dbo].[salesStaffNew] (STAFFID, FNAME, LNAME) VALUES (300, 'Imran', 'Afzal'), (325, 'John', 'Vick'), (314, 'James', 'Dino')

-----------------------------------

--nameOnlyTable insert--

CREATE TABLE [dbo].[nameOnlyTable] (

    [fName] [nvarchar](30),
    [lName] [nvarchar](30)
)


GO

SELECT * FROM [nameOnlyTable]

INSERT INTO NAMEONLYTABLE (FNAME, LNAME)
SELECT
    FNAME,
    LNAME
FROM SALESSTAFFNEW
WHERE ID >= 3


--INSERTING USING A SELECT STATEMENT--

SELECT * INTO SALESSTAFFNEW_BKP FROM SALESSTAFFNEW
