SELECT 
    YEAR(OrderDate) AS SalesYear, 
    MONTH(OrderDate) AS SalesMonth, 
    SUM(TotalDue) AS MonthlySales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY SalesYear DESC, SalesMonth;
