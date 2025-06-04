USE [TimesheetDB]
Go

TRUNCATE TABLE Timesheet;
TRUNCATE TABLE ErrorRows;


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
    CONSTRAINT UQ_Timesheet_UniqueEntry UNIQUE (EmployeeName, Date, StartTime, EndTime)
);


DROP TABLE IF EXISTS [dbo].[Leave]
Go

CREATE TABLE Leave (
    LeaveID INT PRIMARY KEY IDENTITY(1,1),
    Type NVARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate Date NOT NULL,
    NumberDays INT NOT NULL,
    Approved NVARCHAR(50) NOT NULL,
	SickNote NVARCHAR(50) NOT NULL
)





DROP TABLE IF EXISTS [dbo].[ErrorRows]
Go

CREATE TABLE ErrorRows (
    EmployeeName NVARCHAR(50),
    Date DATE,
    DayOfWeek NVARCHAR(50),
    Client NVARCHAR(50),
    ClientProjectName NVARCHAR(50),
    Description NVARCHAR(50),
    Billable NVARCHAR(50),
    Comments NTEXT,
    TotalHours DECIMAL(5,2),
    StartTime TIME(0),
    EndTime TIME(0),
    ErrorDescription NVARCHAR(255)
);