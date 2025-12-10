/*1*/
SELECT * FROM HumanResources.Employee 
ORDER BY JobTitle ASC;

/*2*/
SELECT * FROM Person.Person P
ORDER BY P.LAStName ASC;

/*3*/
SELECT FirstName, LastName, BusinessEntityID AS Employee_ID 
FROM Person.Person
ORDER BY LastName ASC;

/*4*/
SELECT P.ProductID, P.ProductNumber, P.Name 
FROM Production.Product P
WHERE SellStartDate IS NOT NULL AND P.ProductLine = 'T'
ORDER BY P.Name ASC;

/*5*/
SELECT SalesOrderID, CustomerID, OrderDate, SubTotal,
(TaxAmt / SubTotal) * 100 AS TaxPercentage
FROM Sales.SalesOrderHeader
ORDER BY SubTotal DESC;

/*6*/
SELECT DISTINCT(JobTitle) FROM HumanResources.Employee 
ORDER BY JobTitle ASC;

/*7*/
SELECT CustomerID, SUM(Freight) AS TotalFreight
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
ORDER BY CustomerID ASC;

/*8*/
SELECT CustomerID, SalesPersonID,
	AVG(SubTotal) AS AvgSubTotal,
	SUM(SubTotal) AS SumSubTotal
FROM Sales.SalesOrderHeader
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID DESC;

/*9*/
SELECT ProductID,SUM(Quantity) AS TotalQuantity 
FROM Production.ProductInventory
WHERE Shelf IN ('A','C','H')
GROUP BY ProductID
HAVING SUM(Quantity) > 500
ORDER BY ProductID ASC;

/*10*/
SELECT (Sum(Quantity)) AS TotalQuantity 
FROM Production.ProductInventory
GROUP BY LocationID;

/*11*/
SELECT P.BusinessEntityID, P.FirstName, P.LastName, N.PhoneNumber 
FROM Person.Person P LEFT JOIN Person.PersonPhone N ON P.BusinessEntityID = N.BusinessEntityID
WHERE LastName LIKE 'L%'
ORDER BY LastName, P.FirstName;

/*12*/
SELECT DISTINCT(SalesPersonID), CustomerID, SUM(Subtotal) AS SumSubtotal
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, CustomerID
ORDER BY SalesPersonID ASC;

/*13*/
SELECT LocationID, Shelf, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY LocationID, Shelf;

/*14*/
SELECT LocationID,Shelf, SUM(Quantity) AS TotalQuantity
FROM Production.ProductInventory
GROUP BY ROLLUP (LocationID, Shelf)
ORDER BY LocationID, Shelf;

/*15*/
SELECT LocationID, Sum(Quantity) AS TotalQuantity 
FROM Production.ProductInventory
GROUP BY ROLLUP(LocationID);

/*16*/
SELECT City, COUNT(AddressID) AS NoOfEmployees 
FROM Person.Address
GROUP BY City
ORDER BY City ASC;

/*17*/
SELECT YEAR(OrderDate) AS Year, SUM(TotalDue) AS OrderAmount
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC;

/*18*/
SELECT YEAR(OrderDate) AS Year,SUM(TotalDue) AS OrderAmount
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) <= 2016
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC;

/*19*/
SELECT ContactTypeID, Name 
FROM Person.ContactType
WHERE Name LIKE '%Manager'
ORDER BY ContactTypeID DESC;

/*20*/ 
SELECT   P.BusinessEntityID, P.FirstName, P.LastName
FROM Person.Person AS P 
	JOIN Person.BusinessEntityContact AS B ON P.BusinessEntityID = B.BusinessEntityID
	JOIN Person.ContactType AS C ON B.ContactTypeID = C.ContactTypeID
WHERE C.Name = 'Purchasing Manager'
ORDER BY P.LastName ASC, P.FirstName ASC;

/*21
SELECT TOP(5) *
FROM Sales.SalesPerson
SELECT TOP(5) *
FROM Person.Person
SELECT TOP(5) *
FROM Person.Address
SELECT TOP(5) *
FROM Person.BusinessEntityAddress*/
SELECT * FROM Sales.SalesOrderHeader

SELECT ROW_NUMBER() OVER(PARTITION BY A.PostalCode ORDER BY SP.SalesYTD DESC) AS RowNum, 
	P.LastName, SP.SalesYTD, A.PostalCode 
FROM Sales.SalesPerson AS SP
	JOIN Person.Person AS P ON SP.BusinessEntityID = P.BusinessEntityID
	JOIN Person.BusinessEntityAddress AS BEA ON P.BusinessEntityID = BEA.BusinessEntityID
	JOIN Person.Address AS A ON BEA.AddressID = A.AddressID
WHERE 
    SP.TerritoryID IS NOT NULL      -- must belong to a territory
    AND SP.SalesYTD <> 0       
ORDER BY SP.SalesYTD DESC, A.PostalCode ASC;


/*22*/
/*Select * from  Person.ContactType
Select * from Person.BusinessEntityContact*/

SELECT C.ContactTypeID, C.Name, COUNT(BC.ContactTypeID) AS NoContacts 
FROM Person.ContactType C JOIN Person.BusinessEntityContact BC 
ON C.ContactTypeID = BC.ContactTypeID
GROUP BY C.ContactTypeID, C.Name
HAVING COUNT(BC.ContactTypeID)>=100
ORDER BY COUNT(BC.ContactTypeID) DESC

/*23*/
SELECT FORMAT(E.RateChangeDate, 'yyyy-MM-dd') AS FromDate,
	CONCAT(  P.FirstName, ', ', P.MiddleName, ' ', LEFT(P.LastName,1)) AS NameInFull,
	E.Rate * 40 AS SalaryInAWeek
FROM HumanResources.EmployeePayHistory AS E
	JOIN Person.Person AS P ON E.BusinessEntityID = P.BusinessEntityID
ORDER BY NameInFull ASC;

/*24*/
SELECT FromDate, NameInFull, SalaryInAWeek FROM(
	SELECT FORMAT(E.RateChangeDate, 'yyyy-MM-dd') AS FromDate,
		CONCAT(  P.FirstName, ', ', P.MiddleName, ' ', LEFT(P.LastName,1)) AS NameInFull,
		E.Rate * 40 AS SalaryInAWeek,
		ROW_NUMBER() OVER( PARTITION BY E.BusinessEntityID ORDER BY E.RateChangeDate DESC) AS RN
	FROM HumanResources.EmployeePayHistory AS E
		JOIN Person.Person AS P ON E.BusinessEntityID = P.BusinessEntityID) AS PAY
WHERE RN = 1
ORDER BY NameInFull ASC;

/*25*/
SELECT S.SalesOrderID, S.ProductID, S.OrderQty,
	SUM(S.OrderQty) OVER() AS TotalQuantity,
	AVG(S.OrderQty) OVER() AS AvgQuantity,
	COUNT(S.OrderQty) OVER()  AS NoOfOrders,
	MIN(S.OrderQty) OVER() AS MinQuanity,
	MAX(S.OrderQty) OVER() AS MaxQuantity
FROM Sales.SalesOrderDetail S
WHERE S.SalesOrderID IN (43659, 43664)