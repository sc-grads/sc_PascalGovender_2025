USE master;
GO

-- Check if the database exists, if not, create it
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTestDB')
BEGIN
    CREATE DATABASE AutoTestDB;
END
GO

USE AutoTestDB;
GO

-- Check if the table exists, if not, create it
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'user')
BEGIN
    CREATE TABLE [user] (
        ID INT IDENTITY(1,1) PRIMARY KEY,
        Name NVARCHAR(100),
        Surname NVARCHAR(100),
        Email NVARCHAR(100)
    );
END
GO

-- Check if the login exists, create if not
IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'Auto_user')
BEGIN
    CREATE LOGIN Auto_user WITH PASSWORD = '123456';
END
GO

-- Create user in the database
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Auto_user')
BEGIN
    CREATE USER Auto_user FOR LOGIN Auto_user;
END
GO

-- Grant full access to Auto_user
ALTER ROLE db_owner ADD MEMBER Auto_user;
GO

-- Create a stored procedure to automate future deployments
IF OBJECT_ID('CreateAndDeployAutoTestDB', 'P') IS NOT NULL
    DROP PROCEDURE CreateAndDeployAutoTestDB;
GO

CREATE PROCEDURE CreateAndDeployAutoTestDB
AS
BEGIN
    -- Ensure database exists
    IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'AutoTestDB')
    BEGIN
        CREATE DATABASE AutoTestDB;
    END

    -- Ensure table exists
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'user')
    BEGIN
        CREATE TABLE [user] (
            ID INT IDENTITY(1,1) PRIMARY KEY,
            Name NVARCHAR(100),
            Surname NVARCHAR(100),
            Email NVARCHAR(100)
        );
    END

    -- Ensure login exists
    IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'Auto_user')
    BEGIN
        CREATE LOGIN Auto_user WITH PASSWORD = '123456';
    END

    -- Ensure user exists
    IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = 'Auto_user')
    BEGIN
        CREATE USER Auto_user FOR LOGIN Auto_user;
    END

    -- Ensure user has full access
    ALTER ROLE db_owner ADD MEMBER Auto_user;

    PRINT 'Deployment successful: AutoTestDB, user table (with ID), and Auto_user created!';
END;
GO

-- Execute the stored procedure
EXEC CreateAndDeployAutoTestDB;
GO
