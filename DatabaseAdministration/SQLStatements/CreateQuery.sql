Create DATABASE TestDB;
GO

Use TestDB;
GO

Create Table Users (
UserID int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(50),
LastName nvarchar(50),
Email nvarchar(50),
DOB date,
AmountPaid decimal(10,2)
);

GO