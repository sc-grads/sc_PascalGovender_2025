--Users Who Placed Orders and Have Paid More Than $100--

SELECT U.FirstName, U.LastName, U.Email, SUM(O.OrderAmount) AS TotalSpent
FROM Users U
JOIN UserOrders O ON U.UserID = O.UserID
WHERE U.AmountPaid > 100
GROUP BY U.FirstName, U.LastName, U.Email;
