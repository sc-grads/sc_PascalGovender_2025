-- Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'AutoTestDB')
BEGIN
    CREATE DATABASE AutoTestDB;
END
GO

-- Use Database
USE AutoTestDB;
GO

-- Create User Table
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'user')
BEGIN
    CREATE TABLE [user] (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100),
        Surname NVARCHAR(100),
        Email NVARCHAR(100)
    );
END
GO

-- Create User Login
IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'Auto_user')
BEGIN
    CREATE LOGIN Auto_user WITH PASSWORD = '123456';
    CREATE USER Auto_user FOR LOGIN Auto_user;
    ALTER ROLE db_owner ADD MEMBER Auto_user;
END
GO
