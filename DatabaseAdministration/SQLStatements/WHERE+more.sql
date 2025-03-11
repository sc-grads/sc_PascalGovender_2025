
--Simple selects --
SELECT * FROM Person.address;

SELECT AddressID,City,ModifiedDate FROM Person.Address;

SELECT City,AddressID,ModifiedDate FROM Person.Address;

SELECT top 10 * FROM Person.Address;


--SELECT USING WHERE with differen operators--

SELECT * FROM Person.address WHERE postalcode = '98011'

SELECT * FROM Person.address WHERE postalcode != '98011'

SELECT * FROM Person.address WHERE postalcode <> '98011'


--Where with boolean operators--

SELECT * FROM [Production].[ProductCostHistory] WHERE startdate = '2013-05-30 00:00:00'

SELECT * FROM [Production].[ProductCostHistory] WHERE startdate = '2013-05-30 00:00:00' AND StandardCost >= 200

SELECT * FROM [Production].[ProductCostHistory] WHERE( startdate = '2013-05-30 00:00:00' AND StandardCost >= 200) OR ProductID >800

SELECT * FROM [Production].[ProductCostHistory] WHERE( startdate = '2013-05-30 00:00:00' AND StandardCost >= 200) AND ProductID >800

SELECT * FROM [Production].[ProductCostHistory] WHERE ProductID IN (802,803,820,900)

SELECT * FROM [Production].[ProductCostHistory] WHERE EndDate IS NULL

SELECT * FROM [Production].[ProductCostHistory] WHERE EndDate IS NOT NULL

SELECT count(*) FROM Person.address WHERE postalcode <> '98011'

SELECT * FROM Person.address WHERE ModifiedDate >= '2013-11-08 00:00:00'

SELECT * FROM Person.address WHERE ModifiedDate <= '2013-11-08 00:00:00'


--WHERE with LIKE --

SELECT * FROM Person.Person WHERE FirstName like 'mat%'  --start with for % on end--

SELECT * FROM Person.Person WHERE FirstName like '%ew'  --ends with for % at front--

SELECT * FROM Person.Person WHERE FirstName like '%EW' 


-------
SELECT * FROM [HumanResources].[EmployeePayHistory]

SELECT MAX(rate) FROM [HumanResources].[EmployeePayHistory]

SELECT MAX(rate) AS MaxPayrate FROM [HumanResources].[EmployeePayHistory]

SELECT MIN(rate) AS [Min Pay rate] FROM [HumanResources].[EmployeePayHistory]




