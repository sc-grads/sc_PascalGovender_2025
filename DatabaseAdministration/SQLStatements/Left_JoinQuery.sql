--using a LEFT JOIN to show all users, even if they don't have an order--

SELECT U.FirstName, U.LastName, U.Email, O.OrderID, O.OrderAmount, O.OrderDate
FROM Users U
LEFT JOIN UserOrders O ON U.UserID = O.UserID;
GO