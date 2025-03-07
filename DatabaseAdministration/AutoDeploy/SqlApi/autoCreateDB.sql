-- Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'AutoTestDB')
BEGIN
    CREATE DATABASE AutoTestDB;
END
GO

-- Use Database
USE AutoTestDB;
GO

-- Create Table with Surname
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'User')
BEGIN
    CREATE TABLE [User] (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(100) NOT NULL,
        Surname NVARCHAR(100) NOT NULL,  -- Added Surname column
        Email NVARCHAR(255) NOT NULL UNIQUE
    );
END
GO

-- Create Stored Procedure with Surname
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'AddUser')
BEGIN
    CREATE PROCEDURE AddUser
        @Username NVARCHAR(100),
        @Surname NVARCHAR(100),  -- Added Surname parameter
        @Email NVARCHAR(255)
    AS
    BEGIN
        INSERT INTO [User] (Username, Surname, Email) VALUES (@Username, @Surname, @Email);
    END
END
GO
