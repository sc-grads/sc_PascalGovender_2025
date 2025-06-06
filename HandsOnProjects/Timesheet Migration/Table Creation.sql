USE [TimesheetDB]
Go

--Reset tables
--TRUNCATE TABLE [dbo].[Timesheet];
--TRUNCATE TABLE Leave;
--TRUNCATE TABLE AuditLog;
--TRUNCATE TABLE ErrorLog;

-- View data in all tables
--Select * from [dbo].[Timesheet]
--Select * from [dbo].[Leave]
--Select * from [dbo].[AuditLog]
--Select * from [dbo].[ErrorLog]

DROP TABLE IF EXISTS [dbo].[Timesheet]
Go
-- Timesheets Table

CREATE TABLE Timesheet (
    TimesheetID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName NVARCHAR(50) NOT NULL,
    Date DATE NOT NULL,
    DayOfWeek NVARCHAR(50) NOT NULL,
    Client NVARCHAR(50) NULL,
    ClientProjectName NVARCHAR(50),
    Description NVARCHAR(50) NULL,
    Billable NVARCHAR(50) NULL,
    Comments  NVARCHAR(MAX) NULL,
    TotalHours DECIMAL(5,2) NOT NULL,
    StartTime TIME(0),
    EndTime TIME(0),
    CONSTRAINT UQTimesheetUniqueEntry UNIQUE (EmployeeName, Date, StartTime, EndTime)
);

DROP TABLE IF EXISTS [dbo].[Leave]
Go

CREATE TABLE Leave (
    LeaveID INT PRIMARY KEY IDENTITY(1,1),
	EmployeeName NVARCHAR(50) NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate Date NOT NULL,
    NumberDays INT NOT NULL,
    Approved NVARCHAR(50) NOT NULL,
	SickNote NVARCHAR(50) NULL
	CONSTRAINT UQLeaveUniqueEntry UNIQUE (EmployeeName, StartDate, EndDate)
)

DROP TABLE IF EXISTS [dbo].[AuditLog]
Go

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(50)NULL,
    Timestamp DATETIME NULL DEFAULT GETDATE(),
    EmployeeName NVARCHAR(50),
    UserName NVARCHAR(50) NULL,
    Details NVARCHAR(MAX)
);

DROP TABLE IF EXISTS [dbo].[ErrorLog]
Go
 
CREATE TABLE ErrorLog (
	ErrorID INT PRIMARY KEY IDENTITY(1,1),
	FilePath NVARCHAR(1000),
	ErrorCode NVarchar(15),
	ErrorDescription NVARCHAR(1000),
	Timestamp DATETIME DEFAULT GETDATE()
);