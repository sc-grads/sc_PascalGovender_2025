Create Database TESTDB;
Go

Use TESTDB;
Go

Create Table USERS (
    USERID int Identity (1, 1) Primary Key,
    FIRSTNAME nvarchar(50),
    LASTNAME nvarchar(50),
    EMAIL nvarchar(50),
    DOB date,
    AMOUNTPAID decimal(10, 2)
);

Go
