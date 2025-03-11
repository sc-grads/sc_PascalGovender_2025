--Alter the existing Users table--

USE TESTDB;
GO

-- Add PhoneNumber and Country columns to the Users table--
ALTER TABLE USERS
ADD PHONENUMBER nvarchar(15),
COUNTRY nvarchar(50);
GO

-- Modify AmountPaid column to increase precision to allow larger values--
ALTER TABLE USERS
ALTER COLUMN AMOUNTPAID decimal(15, 2);  -- Increased precision and scale for AmountPaid
GO

-- Add a new Status column to track if the user is Active or Inactive--
ALTER TABLE USERS
ADD STATUS nvarchar(10) DEFAULT 'Active';
GO

--Create a new UserOrders table--
CREATE TABLE USERORDERS (
    ORDERID int IDENTITY (1, 1) PRIMARY KEY,   -- Auto-increment OrderID
    USERID int FOREIGN KEY REFERENCES USERS (USERID),  -- Link to Users table
    ORDERAMOUNT decimal(10, 2),      -- Amount of the order
    ORDERDATE date,                 -- Date the order was placed
    ORDERSTATUS nvarchar(20)        -- Order status ('Pending', 'Completed')
);
GO
