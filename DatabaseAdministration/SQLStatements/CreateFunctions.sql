/****** Script for SelectTopNRows command from SSMS  ******/

CREATE TABLE [dbo].[FunctionEmployee](
	[EmpID] INT NOT NULL,
	[FirstName] VARCHAR(50) NULL,
	[LastName] VARCHAR(50) NULL,
	[Salary] INT NULL,
	[Address] VARCHAR (100) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


--------insertting information-------------

INSERT INTO [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) VALUES (1,'Jackie','Mohammed', 20000, 'Delhi')
INSERT INTO [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) VALUES (2,'Pascal','Govender', 500000, 'Delhi')
INSERT INTO [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) VALUES (3,'Karol','Gerrard', 10000, 'Delhi')
INSERT INTO [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) VALUES (4,'Jaga','Babu', 30000, 'Delhi')
INSERT INTO [FunctionEmployee] ([EmpID],[FirstName],[LastName],[Salary],[Address]) VALUES (5,'Jayden','Ebrahim', 60000, 'Delhi')
-------------------------------------------


CREATE FUNCTION [dbo].[fnGetEmpFullName]( @FirstName VARCHAR(50), @LastName VARCHAR(50))
RETURNS VARCHAR(101)
AS
BEGIN
RETURN (select @FirstName + ' '+@LastName);
END
GO

------Testing function------------

select dbo.fnGetEmpFullName (firstname,lastname) as Fullname , salary from FunctionEmployee

select firstname + ' ' +lastname as Fullname , salary from FunctionEmployee



------Another function---------

CREATE FUNCTION [dbo].[fnGetEmployee]
returns Table
As
return (select * from FunctionEmployee)
GO


select * from dbo.fnGetEmployee() ---call test--
