/*26*/
SELECT SalesOrderID, ProductID, OrderQty,
	SUM(OrderQty) OVER() AS TotalQuantity,
	AVG(OrderQty) OVER() AS AvgQuantity,
	COUNT(OrderQty) OVER()  AS NoOfOrders
FROM Sales.SalesOrderDetail
WHERE SalesOrderID IN (43659, 43664) AND ProductID LIKE '71%'
ORDER BY ProductID ASC;

/*27*/
SELECT SalesOrderID, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue >100000;

/*28*/
SELECT ProductID, Name 
FROM Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID ASC;

/*29*/
SELECT ProductID, Name, ISNULL(Color,'') as Color
FROM Production.Product
ORDER BY ListPrice;

/*30*/
SELECT BusinessEntityID, JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY HireDate ASC;

/*31*/
SELECT LastName, FirstName
FROM Person.Person
WHERE LastName LIKE 'R%'
ORDER BY FirstName ASC, LastName DESC;

/*32*/
SELECT BusinessEntityID, 
	IIF(SalariedFlag = 1, 'True' , 'False') AS SalariedFlag
FROM HumanResources.Employee
ORDER BY 
	IIF(SalariedFlag = 1, -BusinessEntityID, BusinessEntityID);

/*33*/
--SELECT * FROM Sales.vSalesPerson
/*SELECT * FROM Sales.SalesTerritory
SELECT * FROM Person.Person
SELECT * FROM Sales.SalesPerson
SELECT * FROM Person.CountryRegion*/

SELECT SP.BusinessEntityID, P.LastName, ST.Name AS TerritoryName, CR.Name AS CountryRegionName
FROM Sales.SalesPerson AS SP
	JOIN Person.Person AS P ON SP.BusinessEntityID = P.BusinessEntityID
	JOIN Sales.SalesTerritory AS ST ON SP.TerritoryID = ST.TerritoryID
	JOIN Person.CountryRegion AS CR ON ST.CountryRegionCode = CR.CountryRegionCode
ORDER BY 
	IIF(CR.Name = 'United States', ST.Name, CR.Name);

/*34*/
SELECT P.FirstName, P.LastName,
	ROW_NUMBER() OVER(ORDER BY A.PostalCode) AS RowNumber,
	RANK() OVER(ORDER BY A.PostalCode) AS Rank,
	DENSE_RANK() OVER(ORDER BY A.PostalCode) AS DenseRank,
	NTILE(4) OVER(ORDER BY SP.SalesYTD) AS Quartile,
	SP.SalesYTD, A.PostalCode
FROM Sales.SalesPerson AS SP
	JOIN Sales.SalesTerritory AS ST ON SP.TerritoryID = ST.TerritoryID
	JOIN Person.Person AS P ON SP.BusinessEntityID = P.BusinessEntityID
	JOIN Person.BusinessEntityAddress AS BEA ON P.BusinessEntityID = BEA.BusinessEntityID
	JOIN Person.Address AS A ON BEA.AddressID = A.AddressID
WHERE SP.SalesYTD > 0
ORDER BY A.PostalCode ASC

/*35*/
/*SELECT DepartmentID, Name, GroupName FROM
	(SELECT DepartmentID, Name, GroupName, ROW_NUMBER() OVER(ORDER BY DepartmentID) AS RowNumber
	FROM HumanResources.Department) AS D
WHERE RowNumber > 10
ORDER BY DepartmentID*/

SELECT DepartmentID, Name, GroupName
FROM HumanResources.Department
ORDER BY DepartmentID OFFSET 10 ROWS

/*36*/
SELECT DepartmentID, Name, GroupName
FROM HumanResources.Department
ORDER BY DepartmentID
	OFFSET 5 ROWS
	FETCH NEXT 5 ROWS ONLY

/*37*/
SELECT Name, Color, ListPrice
FROM Production.Product
WHERE Color IN ('Blue', 'Red')
ORDER BY ListPrice;

/*38*/
SELECT P.Name, S.SalesOrderID
FROM Sales.SalesOrderDetail S 
	FULL OUTER JOIN Production.Product P ON S.ProductID = P.ProductID
ORDER BY P.Name;

/*39*/
SELECT P.Name, S.SalesOrderID
FROM Sales.SalesOrderDetail S
	RIGHT JOIN Production.Product P ON P.ProductID = S.ProductID
ORDER BY P.Name;

/*40*/
SELECT P.Name, S.SalesOrderID
FROM Sales.SalesOrderDetail S 
	INNER JOIN Production.Product P ON S.ProductID = P.ProductID
ORDER BY P.Name;

/*41*/
SELECT ISNULL(T.Name,'') AS Territory, P.BusinessEntityID
FROM Sales.SalesPerson P
	LEFT JOIN Sales.SalesTerritory T ON P.TerritoryID = T.TerritoryID
ORDER BY P.BusinessEntityID;

/*42*/
SELECT (P.FirstName+' '+P.LastName) AS Name, A.City
FROM Person.Person P
	JOIN Person.BusinessEntityAddress BEA ON BEA.BusinessEntityID = P.BusinessEntityID
	JOIN Person.Address A ON A.AddressID = BEA.AddressID
ORDER BY P.LastName, P.FirstName;

/*43*/
SELECT BusinessEntityID, FirstName, LastName
FROM (
		SELECT BusinessEntityID, FirstName, LastName
		FROM Person.Person
		WHERE PersonType = 'IN' AND LastName = 'Adams'
	) AS PT
ORDER BY PT.FirstName ASC;

/*44*/
SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID < 1500 
	AND LastName LIKE 'Al%' 
	AND FirstName LIKE 'M%'
ORDER BY BusinessEntityID;

/*45*/
SELECT ProductID, Name, Color
FROM (
		SELECT *
		FROM Production.Product) AS DT
WHERE Name IN ('Blade','Crown Race','AWC Logo Cap')

/*46*/
SELECT SalesPersonID, 
	COUNT(SalesPersonID) AS TotalSales, 
	YEAR(OrderDate) AS SalesYear
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, YEAR(OrderDate)
ORDER BY SalesPersonID, YEAR(OrderDate)

/*47*/
WITH SalesPerPerson AS 
(
	SELECT SalesPersonID, 
		COUNT(SalesPersonID) AS TotalSales
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID
)

SELECT AVG(TotalSales) AS AverageSales FROM SalesPerPerson

/*48*/
SELECT * 
FROM Production.ProductPhoto
WHERE LargePhotoFileName LIKE '%green_%'

/*49*/
/*Select * From Person.Address
Select * from Person.StateProvince*/

SELECT A.AddressLine1, A.AddressLine2, A.City, A.PostalCode, SP.CountryRegionCode 
FROM Person.Address A
	JOIN Person.StateProvince SP ON A.StateProvinceID = SP.StateProvinceID
WHERE SP.Name <> 'United States' AND A.City LIKE 'Pa%'

/*50*/
SELECT TOP 20 JobTitle, HireDate
FROM HumanResources.Employee
ORDER BY HireDate DESC;