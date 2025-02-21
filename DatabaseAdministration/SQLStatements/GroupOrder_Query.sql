--Get the Top 3 Users Who Spent the Most--

SELECT TOP 3 U.FirstName, U.LastName, SUM(O.OrderAmount) AS TotalSpent
FROM Users U
JOIN UserOrders O ON U.UserID = O.UserID
GROUP BY U.FirstName, U.LastName
ORDER BY TotalSpent DESC;
