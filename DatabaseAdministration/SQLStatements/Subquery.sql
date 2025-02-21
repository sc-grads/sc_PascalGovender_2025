--users who spent more than the average amount--

SELECT FirstName, LastName, SUM(O.OrderAmount) AS TotalSpent
FROM Users U
JOIN UserOrders O ON U.UserID = O.UserID
GROUP BY U.FirstName, U.LastName
HAVING SUM(O.OrderAmount) > (SELECT AVG(OrderAmount) FROM UserOrders);
