-- Step 1: Create Database if it doesn't exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'TimesheetDB')
BEGIN
    CREATE DATABASE TimesheetDB;
    PRINT 'Database "TimesheetDB" created successfully';
END
ELSE
BEGIN
    PRINT 'Database "TimesheetDB" already exists.';
END

GO

-- Step 2: Use the new database
USE TimesheetDB;
GO

-- Step 3: Create Employee table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employee')
BEGIN
    CREATE TABLE Employee (
        EmployeeID INT PRIMARY KEY IDENTITY(1,1),
        EmployeeName NVARCHAR(255) NOT NULL
    );
    PRINT 'Table "Employee" created successfully and being initialized';
END
ELSE
BEGIN
    PRINT 'Table "Employee" already exists';
END

GO

-- Step 4: Create Client table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Client')
BEGIN
    CREATE TABLE Client (
        ClientID INT PRIMARY KEY IDENTITY(1,1),
        ClientName NVARCHAR(255) NOT NULL
    );
    PRINT 'Table "Client" created successfully and being initialized';
END
ELSE
BEGIN
    PRINT 'Table "Client" already exists';
END

GO

-- Step 5: Create Timesheet table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Timesheet')
BEGIN
    CREATE TABLE Timesheet (
        TimesheetID INT PRIMARY KEY IDENTITY(1,1),
        EmployeeID INT NOT NULL,
        Date DATE NOT NULL,
        DayOfWeek NVARCHAR(255) NOT NULL,
        ClientID INT NULL,
        ClientProjectName NVARCHAR(255),
        Description NVARCHAR(255) NULL,
        Billable NVARCHAR(255) NULL,
        Comments NVARCHAR(MAX) NULL,
        TotalHours DECIMAL(5,2) NOT NULL,
        StartTime TIME(0),
        EndTime TIME(0),
        CONSTRAINT UQTimesheetUniqueEntry UNIQUE (EmployeeID, Date, StartTime, EndTime),
        CONSTRAINT FKTimesheetEmployee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
        CONSTRAINT FKClient FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
    );
    PRINT 'Table "Timesheet" created successfully and being initialized';
END
ELSE
BEGIN
    PRINT 'Table "Timesheet" already exists';
END

GO

-- Step 6: Create Leave table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Leave')
BEGIN
    CREATE TABLE Leave (
        LeaveID INT PRIMARY KEY IDENTITY(1,1),
        EmployeeID INT NOT NULL,
        Type NVARCHAR(255) NOT NULL,
        StartDate DATE NOT NULL,
        EndDate DATE NOT NULL,
        NumberDays INT NOT NULL,
        Approved NVARCHAR(255) NULL,
        SickNote NVARCHAR(255) NULL,
        CONSTRAINT UQLeaveUniqueEntry UNIQUE (EmployeeID, StartDate, EndDate),
        CONSTRAINT FKLeaveEmployee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
    );
    PRINT 'Table "Leave" created successfully and being initialized';
END
ELSE
BEGIN
    PRINT 'Table "Leave" already exists';
END

GO

-- Step 7: Create AuditLog table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AuditLog')
BEGIN
    CREATE TABLE AuditLog (
        AuditID INT PRIMARY KEY IDENTITY(1,1),
        Filename NVARCHAR(1000),
        EmployeeName NVARCHAR(1000),
        Month NVARCHAR(255),
        Type NVARCHAR(255) NOT NULL,
        Task NVARCHAR(255),
        Timestamp DATETIME NULL DEFAULT GETDATE()
    );
    PRINT 'Table "AuditLog" created successfully and being initialized';
END
ELSE
BEGIN
    PRINT 'Table "AuditLog" already exists';
END

GO

-- Step 8: Create ErrorLog table if it doesn't exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ErrorLog')
BEGIN
    CREATE TABLE ErrorLog (
        ErrorID INT PRIMARY KEY IDENTITY(1,1),
        FilePath NVARCHAR(1000),
        ErrorCode NVARCHAR(255),
        ErrorDescription NVARCHAR(1000),
        Timestamp DATETIME DEFAULT GETDATE()
    );
    PRINT 'Table "ErrorLog" created successfully and being initialized';
END
ELSE
BEGIN
    PRINT 'Table "ErrorLog" already exists';
END

GO

-- Step 9: View data in all tables
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Timesheet')
    SELECT * FROM [dbo].[Timesheet];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Leave')
    SELECT * FROM [dbo].[Leave];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AuditLog')
    SELECT * FROM [dbo].[AuditLog];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ErrorLog')
    SELECT * FROM [dbo].[ErrorLog];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Client')
    SELECT * FROM [dbo].[Client];
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Employee')
    SELECT * FROM [dbo].[Employee];
PRINT 'Data from all tables displayed';

GO
