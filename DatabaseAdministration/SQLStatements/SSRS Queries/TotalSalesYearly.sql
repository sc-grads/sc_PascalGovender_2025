SELECT 
    YEAR(OrderDate) AS SalesYear, 
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY SalesYear DESC;
