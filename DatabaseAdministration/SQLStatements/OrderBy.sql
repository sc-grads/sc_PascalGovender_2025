--ORDER BY queries + where statements--

SELECT * FROM [HumanResources].[EmployeePayHistory] ORDER BY rate 

SELECT * FROM [HumanResources].[EmployeePayHistory] ORDER BY rate ASC

SELECT * FROM [HumanResources].[EmployeePayHistory] ORDER BY rate DESC


SELECT * FROM [HumanResources].[EmployeePayHistory] WHERE  ModifiedDate >= '2010-06-30 00:00:00' ORDER BY ModifiedDate DESC

SELECT * FROM [HumanResources].[EmployeePayHistory] WHERE  year(ModifiedDate) >= '2014' ORDER BY ModifiedDate DESC

SELECT * FROM [HumanResources].[EmployeePayHistory] WHERE  month(ModifiedDate) = '06' ORDER BY ModifiedDate DESC