--CREATE DATABASE TimesheetDB
---GO

USE [TimesheetDB]
Go
DROP TABLE IF EXISTS [dbo].[Leave]
Go
DROP TABLE IF EXISTS [dbo].[Timesheet]
Go
DROP TABLE IF EXISTS [dbo].[AuditLog]
Go

DROP TABLE IF EXISTS [dbo].[Employee]
Go
CREATE TABLE Employee (
	 EmployeeID INT PRIMARY KEY IDENTITY(1,1),
	 EmployeeName NVARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS [dbo].[Client]
Go
CREATE TABLE Client (
	 ClientID INT PRIMARY KEY IDENTITY(1,1),
	 ClientName NVARCHAR(255) NOT NULL
);



CREATE TABLE Timesheet (
    TimesheetID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    Date DATE NOT NULL,
    DayOfWeek NVARCHAR(255) NOT NULL,
    ClientID INT NULL,
    ClientProjectName NVARCHAR(255),
    Description NVARCHAR(255) NULL,
    Billable NVARCHAR(255) NULL,
    Comments  NVARCHAR(MAX) NULL,
    TotalHours DECIMAL(5,2) NOT NULL,
    StartTime TIME(0),
    EndTime TIME(0),
    CONSTRAINT UQTimesheetUniqueEntry UNIQUE (EmployeeID, Date, StartTime, EndTime),
	CONSTRAINT FKTimesheetEmployee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    CONSTRAINT FKClient FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);


CREATE TABLE Leave (
    LeaveID INT PRIMARY KEY IDENTITY(1,1),
	EmployeeID INT NOT NULL,
    Type NVARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate Date NOT NULL,
    NumberDays INT NOT NULL,
    Approved NVARCHAR(255) NULL,
	SickNote NVARCHAR(255) NULL
	CONSTRAINT UQLeaveUniqueEntry UNIQUE (EmployeeID, StartDate, EndDate),
	CONSTRAINT FKLeaveEmployee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
)


CREATE TABLE AuditLog (
    AuditID INT PRIMARY KEY IDENTITY(1,1),
	Filename NVARCHAR(1000),
	EmployeeID INT,
	Month NVARCHAR(255),
    Type NVARCHAR(255) NOT NULL,
    Task NVARCHAR(255),
	Timestamp DATETIME NULL DEFAULT GETDATE(),
	CONSTRAINT FKAuditEmployee FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

DROP TABLE IF EXISTS [dbo].[ErrorLog]
Go
 
CREATE TABLE ErrorLog (
	ErrorID INT PRIMARY KEY IDENTITY(1,1),
	FilePath NVARCHAR(1000),
	ErrorCode NVarchar(255),
	ErrorDescription NVARCHAR(1000),
	Timestamp DATETIME DEFAULT GETDATE()
);

--Reset tables
TRUNCATE TABLE [dbo].[Timesheet];
TRUNCATE TABLE Leave;
TRUNCATE TABLE AuditLog;
TRUNCATE TABLE ErrorLog;
--TRUNCATE TABLE Client;
--TRUNCATE TABLE Employee;

-- View data in all tables
Select * from [dbo].[Timesheet]
Select * from [dbo].[Leave]
Select * from [dbo].[AuditLog]
Select * from [dbo].[ErrorLog]
Select * from [dbo].Client
Select * from [dbo].Employee