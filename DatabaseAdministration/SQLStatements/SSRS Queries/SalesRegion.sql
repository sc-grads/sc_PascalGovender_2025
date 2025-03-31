SELECT 
    st.Name AS Territory, 
    SUM(soh.TotalDue) AS SalesAmount
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY SalesAmount DESC;
