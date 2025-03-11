--TABLE CREATION--

CREATE TABLE [dbo].[salesStaff](
	[staffid] [int] NOT NULL PRIMARY KEY,
	[fName] [nvarchar](30) NULL,
	[lName] [nvarchar](30) NULL
	)


GO

--INSERT STATEMENTS for salesStaff

INSERT INTO [dbo].[salesStaff] (STAFFID,FNAME,LNAME) VALUES (200,'Abbas','Mehmood')

INSERT INTO [dbo].[salesStaff] (STAFFID,FNAME,LNAME) VALUES (300,'Imran','Afzal'),(325,'John','Vick'),(314,'James','Dino')

-----------------------------------------------------

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

-------------------------------------

 INSERT INTO nameOnlyTable (fname,lname)
SELECT fname,lname FROM salesStaffNew WHERE id >= 3

--------------------------------

SELECT * into salesStaffNew_bkp FROM salesStaffNew
