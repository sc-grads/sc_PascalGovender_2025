USE [TimesheetDB]
Go

TRUNCATE TABLE Timesheet;
TRUNCATE TABLE Leave;

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

CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    Operation VARCHAR(10) NOT NULL,
    TableName VARCHAR(50) NOT NULL,
    Timestamp DATETIME NOT NULL DEFAULT GETDATE(),
    EmployeeName VARCHAR(50),
    UserName VARCHAR(50) NOT NULL,
    Details TEXT
);
 
CREATE TABLE ErrorLog (
    ErrorID INT PRIMARY KEY IDENTITY(1,1),
    FilePath VARCHAR(255),
    ErrorMessage TEXT,
    Timestamp DATETIME DEFAULT GETDATE()
);