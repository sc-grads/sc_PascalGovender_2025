--Get the Total Order Amount for Each User--

SELECT U.FirstName, U.LastName, SUM(O.OrderAmount) AS TotalSpent
FROM Users U
JOIN UserOrders O ON U.UserID = O.UserID
GROUP BY U.FirstName, U.LastName;
