--Simple selects --
SELECT * FROM Person.Address;

SELECT
    Addressid,
    City,
    Modifieddate
FROM Person.Address;

SELECT
    City,
    Addressid,
    Modifieddate
FROM Person.Address;

SELECT TOP 10 * FROM Person.Address;


--SELECT USING WHERE with differen operators--

SELECT * FROM Person.Address
WHERE Postalcode = '98011'

SELECT * FROM Person.Address
WHERE Postalcode != '98011'

SELECT * FROM Person.Address
WHERE Postalcode != '98011'


--Where with boolean operators--

SELECT * FROM [Production].[ProductCostHistory]
WHERE Startdate = '2013-05-30 00:00:00'

SELECT * FROM [Production].[ProductCostHistory]
WHERE Startdate = '2013-05-30 00:00:00' AND Standardcost >= 200

SELECT * FROM [Production].[ProductCostHistory]
WHERE (Startdate = '2013-05-30 00:00:00' AND Standardcost >= 200) OR Productid > 800

SELECT * FROM [Production].[ProductCostHistory]
WHERE (Startdate = '2013-05-30 00:00:00' AND Standardcost >= 200) AND Productid > 800

SELECT * FROM [Production].[ProductCostHistory]
WHERE Productid IN (802, 803, 820, 900)

SELECT * FROM [Production].[ProductCostHistory]
WHERE Enddate IS NULL

SELECT * FROM [Production].[ProductCostHistory]
WHERE Enddate IS NOT NULL

SELECT count(*) FROM Person.Address
WHERE Postalcode != '98011'

SELECT * FROM Person.Address
WHERE Modifieddate >= '2013-11-08 00:00:00'

SELECT * FROM Person.Address
WHERE Modifieddate <= '2013-11-08 00:00:00'


--WHERE with LIKE --

SELECT * FROM Person.Person
WHERE Firstname LIKE 'mat%'  --start with for % on end--

SELECT * FROM Person.Person
WHERE Firstname LIKE '%ew'  --ends with for % at front--

SELECT * FROM Person.Person
WHERE Firstname LIKE '%EW'


-------
SELECT * FROM [HumanResources].[EmployeePayHistory]

SELECT max(Rate) FROM [HumanResources].[EmployeePayHistory]

SELECT max(Rate) AS Maxpayrate FROM [HumanResources].[EmployeePayHistory]

SELECT min(Rate) AS [Min Pay rate] FROM [HumanResources].[EmployeePayHistory]
