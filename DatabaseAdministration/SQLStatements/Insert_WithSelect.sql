--NEW TABLE- salesStaffNew--

CREATE TABLE [dbo].[salesStaffNew](
	ID [int] not null IDENTITY PRIMARY KEY,
	[staffid] [int] NOT NULL,
	[fName] [nvarchar](30),
	[lName] [nvarchar](30)
	)

GO

SELECT * FROM salesStaffNew

INSERT INTO [dbo].[salesStaffNew] (STAFFID,FNAME,LNAME) VALUES (200,'Abbas','Mehmood')

INSERT INTO [dbo].[salesStaffNew] (STAFFID,FNAME,LNAME) VALUES (300,'Imran','Afzal'),(325,'John','Vick'),(314,'James','Dino')

-----------------------------------

--nameOnlyTable insert--

CREATE TABLE [dbo].[nameOnlyTable](
	
	[fName] [nvarchar](30),
	[lName] [nvarchar](30)
	)


GO

SELECT * FROM [nameOnlyTable]

 INSERT INTO nameOnlyTable (fname,lname)
SELECT fname,lname FROM salesStaffNew WHERE id >= 3


--INSERTING USING A SELECT STATEMENT--

SELECT * into salesStaffNew_bkp FROM salesStaffNew