WITH HighValueOrders AS (
    SELECT UserID, OrderAmount FROM UserOrders WHERE OrderAmount > 300
)
SELECT u.FirstName, u.LastName, h.OrderAmount 
FROM Users u 
JOIN HighValueOrders h ON u.UserID = h.UserID;
