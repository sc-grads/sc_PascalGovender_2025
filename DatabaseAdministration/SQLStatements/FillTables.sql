USE TESTDB
GO

-- Insert Sample Data into Users Table
INSERT INTO USERS (FIRSTNAME, LASTNAME, EMAIL, DOB, AMOUNTPAID, PHONENUMBER, COUNTRY)
VALUES
('John', 'Doe', 'john.doe@example.com', '1985-04-25', 200.50, '123-456-7890', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '1992-08-15', 150.75, '987-654-3210', 'Canada'),
('Michael', 'Johnson', 'michael.johnson@example.com', '1988-07-12', 120.00, '111-222-3333', 'UK'),
('Emily', 'Davis', 'emily.davis@example.com', '1990-03-01', 320.20, '222-333-4444', 'Australia'),
('Chris', 'Brown', 'chris.brown@example.com', '1982-11-30', 500.00, '333-444-5555', 'USA'),
('Sarah', 'Miller', 'sarah.miller@example.com', '1995-09-23', 180.00, '444-555-6666', 'Germany'),
('Daniel', 'Wilson', 'daniel.wilson@example.com', '1987-06-10', 220.80, '555-666-7777', 'USA'),
('Olivia', 'Moore', 'olivia.moore@example.com', '1994-12-05', 150.00, '666-777-8888', 'Canada');
GO

-- Insert Sample Data into UserOrders Table
INSERT INTO USERORDERS (USERID, ORDERAMOUNT, ORDERDATE, ORDERSTATUS)
VALUES
(1, 75.20, '2025-02-20', 'Pending'), -- Order for John Doe (UserID 1)
(1, 50.00, '2025-02-22', 'Completed'), -- Another order for John
(3, 45.00, '2025-02-21', 'Completed'), -- Order for Jane Smith (UserID 2)
(3, 60.00, '2025-02-18', 'Pending'), -- Order for Michael Johnson (UserID 3)
(3, 180.00, '2025-02-23', 'Completed'), -- Another order for Michael
(4, 100.00, '2025-02-19', 'Completed'), -- Order for Emily Davis (UserID 4)
(5, 200.00, '2025-02-20', 'Completed'), -- Order for Chris Brown (UserID 5)
(6, 50.75, '2025-02-21', 'Pending'), -- Order for Sarah Miller (UserID 6)
(7, 120.50, '2025-02-23', 'Completed'), -- Order for Daniel Wilson (UserID 7)
(8, 75.50, '2025-02-20', 'Pending'); -- Order for Olivia Moore (UserID 8)
GO
