--Alter the existing Users table--

USE TestDB;
GO

-- Add PhoneNumber and Country columns to the Users table--
ALTER TABLE Users
ADD PhoneNumber nvarchar(15),  
    Country nvarchar(50);       
GO

-- Modify AmountPaid column to increase precision to allow larger values--
ALTER TABLE Users
ALTER COLUMN AmountPaid decimal(15,2);  -- Increased precision and scale for AmountPaid
GO

-- Add a new Status column to track if the user is Active or Inactive--
ALTER TABLE Users
ADD Status nvarchar(10) DEFAULT 'Active'; 
GO

--Create a new UserOrders table--
CREATE TABLE UserOrders (
    OrderID int IDENTITY(1,1) PRIMARY KEY,   -- Auto-increment OrderID
    UserID int FOREIGN KEY REFERENCES Users(UserID),  -- Link to Users table
    OrderAmount decimal(10,2),      -- Amount of the order
    OrderDate date,                 -- Date the order was placed
    OrderStatus nvarchar(20)        -- Order status ('Pending', 'Completed')
);
GO
