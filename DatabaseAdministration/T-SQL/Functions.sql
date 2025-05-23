-- ============================================
-- Scalar Functions
-- ============================================

-- Create a scalar function that returns the input amount + 1
CREATE FUNCTION AmountPlusOne(@Amount smallmoney)
RETURNS smallmoney
AS
BEGIN
    RETURN @Amount + 1
END
GO

-- Use the scalar function in a SELECT query
select DateOfTransaction, EmployeeNumber, Amount, 
       dbo.AmountPlusOne(Amount) as AmountAndOne
from tblTransaction;

-- Call the scalar function from a T-SQL variable
DECLARE @myValue smallmoney;
EXEC @myValue = dbo.AmountPlusOne @Amount = 345.67;
select @myValue;

-- ============================================
-- Scalar Functions Advanced
-- ============================================

-- Drop the function if it exists
IF OBJECT_ID(N'NumberOfTransactions', N'FN') IS NOT NULL
    DROP FUNCTION NumberOfTransactions;
GO

-- Create a scalar function to return the count of transactions for a given employee
CREATE FUNCTION NumberOfTransactions(@EmployeeNumber int)
RETURNS int
AS
BEGIN
    DECLARE @NumberOfTransactions INT;
    SELECT @NumberOfTransactions = COUNT(*) 
    FROM tblTransaction
    WHERE EmployeeNumber = @EmployeeNumber;
    RETURN @NumberOfTransactions;
END;

SELECT *, dbo.NumberOfTransactions(EmployeeNumber) as TransNum FROM tblEmployee

-- ============================================
-- Inline Table Function
-- ============================================

-- Create an inline table-valued function that returns transactions for a specific employee
CREATE FUNCTION TransactionList(@EmployeeNumber int)
RETURNS TABLE AS
RETURN (
    SELECT * FROM tblTransaction
    WHERE EmployeeNumber = @EmployeeNumber
);

-- Use the function to fetch transactions for a specific employee
SELECT * 
FROM dbo.TransactionList(123);

-- Use the inline table function with EXISTS for filtering
SELECT * 
FROM tblEmployee
WHERE EXISTS (SELECT * FROM dbo.TransactionList(EmployeeNumber));

-- Equivalent using JOIN
SELECT DISTINCT E.*
FROM tblEmployee as E
JOIN tblTransaction as T
    ON E.EmployeeNumber = T.EmployeeNumber;

-- Another equivalent EXISTS clause
SELECT *
FROM tblEmployee as E
WHERE EXISTS (
    SELECT EmployeeNumber 
    FROM tblTransaction as T 
    WHERE E.EmployeeNumber = T.EmployeeNumber
);

-- ============================================
-- Apply
-- ============================================

-- Reuse the inline table function with APPLY operator

-- Call the function directly
SELECT * 
FROM dbo.TransList(123);
GO

-- Use a scalar subquery inside SELECT to count transactions
SELECT *, 
       (SELECT COUNT(*) FROM dbo.TransList(E.EmployeeNumber)) as NumTransactions
FROM tblEmployee as E;

-- Use OUTER APPLY to return all employees, matching rows from the function if available
SELECT *
FROM tblEmployee as E
OUTER APPLY TransList(E.EmployeeNumber) as T;

-- Use CROSS APPLY to return only employees with matching transactions
SELECT *
FROM tblEmployee as E
CROSS APPLY TransList(E.EmployeeNumber) as T;

-- APPLY = JOIN with a table-valued function
-- OUTER APPLY = LEFT JOIN
-- CROSS APPLY = INNER JOIN

-- Use APPLY for filtering based on number of transactions
SELECT *
FROM tblEmployee as E
WHERE (SELECT COUNT(*) FROM dbo.TransList(E.EmployeeNumber)) > 3;
