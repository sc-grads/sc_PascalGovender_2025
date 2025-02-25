--count the number of orders for each user:--

SELECT U.FirstName, U.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Users U
LEFT JOIN UserOrders O ON U.UserID = O.UserID
GROUP BY U.FirstName, U.LastName;
