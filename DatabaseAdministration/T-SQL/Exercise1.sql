SELECT DATENAME(MONTH, DateOfBirth) AS MonthName,
COUNT(*) AS NumberEmployees,
COUNT(EmployeeMiddleName) AS NumberOfMiddleNames,
COUNT(*) - COUNT(EmployeeMiddleName) AS NoMiddleName,
FORMAT(MIN(DateOfBirth), 'dd-MM-yy') AS EarliestDateOfBirth,
FORMAT(MAX(DateOfBirth), 'D') AS LatestDateOfBirth
FROM tblEmployee
GROUP BY DATENAME(MONTH, DateOfBirth), DATEPART(MONTH, DateOfBirth)
ORDER BY DATEPART(MONTH, DateOfBirth);

