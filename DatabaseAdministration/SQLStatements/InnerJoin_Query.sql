USE TestDB
GO

SELECT U.FirstName, U.LastName, U.Email, O.OrderID, O.OrderAmount, O.OrderDate
FROM Users U
INNER JOIN UserOrders O ON U.UserID = O.UserID;
GO