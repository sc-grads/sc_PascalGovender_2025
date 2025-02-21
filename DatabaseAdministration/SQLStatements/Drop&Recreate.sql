--DROP TABLES AND RECREATE TABLES--

-- Drop the UserOrders Table if It Exists
IF OBJECT_ID('dbo.UserOrders', 'U') IS NOT NULL
    DROP TABLE dbo.UserOrders;
GO

-- Drop the Users Table if It Exists
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE dbo.Users;
GO

-- Create the Users Table
CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(50),
    DOB DATE,
    AmountPaid DECIMAL(10,2),
    PhoneNumber NVARCHAR(15),
    Country NVARCHAR(50),
    Status NVARCHAR(10) DEFAULT 'Active'
);
GO

-- Create the UserOrders Table
CREATE TABLE UserOrders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATE,
    OrderStatus NVARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO
