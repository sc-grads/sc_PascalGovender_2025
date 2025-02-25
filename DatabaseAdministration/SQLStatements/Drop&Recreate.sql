--DROP TABLES AND RECREATE TABLES--

-- Drop the UserOrders Table if It Exists
IF OBJECT_ID('dbo.UserOrders', 'U') IS NOT NULL
    DROP TABLE dbo.userorders;
GO

-- Drop the Users Table if It Exists
IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE dbo.users;
GO

-- Create the Users Table
CREATE TABLE users (
    userid INT IDENTITY (1, 1) PRIMARY KEY,
    firstname NVARCHAR(50),
    lastname NVARCHAR(50),
    email NVARCHAR(50),
    dob DATE,
    amountpaid DECIMAL(10, 2),
    phonenumber NVARCHAR(15),
    country NVARCHAR(50),
    status NVARCHAR(10) DEFAULT 'Active'
);
GO

-- Create the UserOrders Table
CREATE TABLE userorders (
    orderid INT IDENTITY (1, 1) PRIMARY KEY,
    userid INT,
    orderamount DECIMAL(10, 2),
    orderdate DATE,
    orderstatus NVARCHAR(20),
    FOREIGN KEY (userid) REFERENCES users (userid)
);
GO
