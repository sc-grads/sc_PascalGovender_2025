SELECT TOP 10 
    p.Name AS ProductName, 
    SUM(sod.OrderQty) AS QuantitySold,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalSales DESC;
