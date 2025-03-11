SELECT * FROM [Production].[Product]
SELECT * FROM [Production].[ProductInventory]
SELECT * FROM [dbo].Employee;

--SUBQUERIES--

SELECT * FROM [HumanResources].[EmployeePayHistory]
  WHERE [BusinessEntityID] 
  IN (SELECT BusinessEntityID FROM [HumanResources].[EmployeePayHistory] WHERE Rate > 60)


SELECT * FROM [HumanResources].[EmployeePayHistory]
  WHERE [BusinessEntityID] 
  IN (SELECT BusinessEntityID FROM [HumanResources].[EmployeePayHistory] WHERE Rate = 39.06)


 SELECT * FROM [Production].[Product]
 WHERE ProductID 
 IN ( SELECT ProductID FROM [Production].[ProductInventory] WHERE Quantity > 300)
