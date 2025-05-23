-- =========================
-- Hints : Forcing a table to do something in a certain wway
-- =================================

-- === NOLOCK (allows dirty reads, no shared locks) ===
SELECT D.Department, D.DepartmentHead, E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName 
FROM [dbo].[tblDepartment] AS D WITH (NOLOCK) -- Not recommended for critical data
LEFT JOIN [dbo].[tblEmployee] AS E ON D.Department = E.Department
WHERE D.Department = 'HR';

-- === REPEATABLEREAD (prevents others from updating the data while it's being read) ===
SELECT D.Department, D.DepartmentHead, E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName 
FROM [dbo].[tblDepartment] AS D WITH (REPEATABLEREAD) -- Maintains consistency within the transaction
LEFT JOIN [dbo].[tblEmployee] AS E ON D.Department = E.Department
WHERE D.Department = 'HR';

-- === UPDLOCK (useful before update statements to avoid race conditions) ===
SELECT *
FROM [dbo].[tblEmployee] WITH (UPDLOCK) -- Locks the rows for update, but doesn’t update them yet
WHERE EmployeeNumber = 124;

-- === HOLDLOCK (equivalent to SERIALIZABLE) ===
SELECT *
FROM [dbo].[tblEmployee] WITH (HOLDLOCK) -- Locks range to avoid phantom reads
WHERE Department = 'Commercial';

-- === XLOCK (exclusive lock, prevents other reads/writes) ===
SELECT *
FROM [dbo].[tblEmployee] WITH (XLOCK) -- Caution: Can cause blocking
WHERE EmployeeNumber = 125;

-- === TABLOCKX (table-level exclusive lock) ===
SELECT *
FROM [dbo].[tblEmployee] WITH (TABLOCKX) -- Entire table is locked
WHERE Department = 'Customer Relations';

-- === FORCESEEK (force index seek if index exists) ===
-- Make sure index on EmployeeNumber exists (as in your clustered index)
SELECT EmployeeNumber, EmployeeFirstName
FROM [dbo].[tblEmployee] WITH (FORCESEEK) -- May fail if index can't be used
WHERE EmployeeNumber = 128;

-- === FAST n (return first N rows quickly) ===
SELECT *
FROM [dbo].[tblEmployee]
OPTION (FAST 3); -- Prioritize fast retrieval of top 3 rows

-- === MAXDOP (limit CPU parallelism) ===
SELECT *
FROM [dbo].[tblTransaction]
OPTION (MAXDOP 1); -- Restrict to single CPU, useful for reducing CPU contention

-- === OPTIMIZE FOR (override parameter sniffing) ===
DECLARE @empNum INT = 132;
SELECT *
FROM [dbo].[tblTransactionBig]
WHERE EmployeeNumber = @empNum
OPTION (OPTIMIZE FOR (@empNum = 1)); -- Use statistics as if value is 1

-- === RECOMPILE (new plan each time, avoids caching issues) ===
DECLARE @empNum2 INT = 1;
SELECT *
FROM [dbo].[tblTransactionBig]
WHERE EmployeeNumber = @empNum2
OPTION (RECOMPILE); -- Avoids bad cached execution plans

-- === FORCEPLAN (preserves join order) ===
SELECT *
FROM [dbo].[tblEmployee] AS E
INNER JOIN [dbo].[tblTransaction] AS T
    ON E.EmployeeNumber = T.EmployeeNumber
OPTION (FORCEPLAN); -- Optimizer uses written join order
