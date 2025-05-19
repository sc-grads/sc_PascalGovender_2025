Use [70-461]
Go

Select [dbo].[tblEmployee].EmployeeNumber, EmployeeFirstName,EmployeeLastName, SUM(Amount) As SumOfAmount
FROM tblEmployee
JOIN tblTransaction
ON tblEmployee.EmployeeNumber = tblTransaction.EmployeeNumber
GROUP BY tblEmployee.EmployeeNumber, EmployeeFirstname,EmployeeLastName
ORDER BY EmployeeNumber