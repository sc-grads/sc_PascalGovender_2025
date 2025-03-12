--ORDER BY queries + where statements--

SELECT * FROM [HumanResources].[EmployeePayHistory]
ORDER BY rate

SELECT * FROM [HumanResources].[EmployeePayHistory]
ORDER BY rate ASC

SELECT * FROM [HumanResources].[EmployeePayHistory]
ORDER BY rate DESC


SELECT * FROM [HumanResources].[EmployeePayHistory]
WHERE modifieddate >= '2010-06-30 00:00:00'
ORDER BY modifieddate DESC

SELECT * FROM [HumanResources].[EmployeePayHistory]
WHERE year(modifieddate) >= '2014'
ORDER BY modifieddate DESC

SELECT * FROM [HumanResources].[EmployeePayHistory]
WHERE month(modifieddate) = '06'
ORDER BY modifieddate DESC
