USE TESTDB
GO
-- Inserting into Users table
INSERT INTO USERS (FIRSTNAME, LASTNAME, EMAIL, DOB, AMOUNTPAID, PHONENUMBER, COUNTRY)
VALUES
('John', 'Doe', 'john.doe@example.com', '1985-04-25', 200.50, '123-456-7890', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '1992-08-15', 150.75, '987-654-3210', 'Canada');
GO
-- Inserting into UserOrders table
INSERT INTO USERORDERS (USERID, ORDERAMOUNT, ORDERDATE, ORDERSTATUS)
VALUES
(1, 75.20, '2025-02-20', 'Pending'),
(3, 45.00, '2025-02-21', 'Completed');
GO
