-- ============================================================
-- Basic MERGE
-- ============================================================
BEGIN TRAN

MERGE INTO tblTransaction as T
USING tblTransactionNew as S
ON T.EmployeeNumber = S.EmployeeNumber AND T.DateOfTransaction = S.DateOfTransaction
WHEN MATCHED THEN
    -- Update matching records
    UPDATE SET Amount = T.Amount + S.Amount
WHEN NOT MATCHED BY TARGET THEN
    -- Insert new records from source that don't exist in target
    INSERT ([Amount], [DateOfTransaction], [EmployeeNumber])
    VALUES (S.Amount, S.DateOfTransaction, S.EmployeeNumber);

ROLLBACK TRAN

-- - tblTransaction (target) may have no matching rows
-- - tblTransactionNew (source) may have 1 or more rows per key
-- - This script assumes 1-to-1 or 1-to-many scenarios from source

-- ============================================================
-- MERGE using GROUP BY
-- ============================================================

SELECT DateOfTransaction, EmployeeNumber, COUNT(*) AS NumberOfRows
FROM tblTransactionNew 
GROUP BY DateOfTransaction, EmployeeNumber
HAVING COUNT(*) > 1

-- Merge after grouping
BEGIN TRAN
GO

DISABLE TRIGGER TR_tblTransaction ON dbo.tblTransaction
GO

MERGE INTO tblTransaction as T
USING (
    SELECT DateOfTransaction, EmployeeNumber, MIN(Amount) as Amount
    FROM tblTransactionNew
    GROUP BY DateOfTransaction, EmployeeNumber
) as S
ON T.EmployeeNumber = S.EmployeeNumber AND T.DateOfTransaction = S.DateOfTransaction
WHEN MATCHED THEN
    UPDATE SET Amount = T.Amount + S.Amount
WHEN NOT MATCHED THEN
    INSERT (Amount, DateOfTransaction, EmployeeNumber)
    VALUES (S.Amount, S.DateOfTransaction, S.EmployeeNumber)
OUTPUT deleted.*, inserted.*;

ROLLBACK TRAN

-- ============================================================
-- MERGE with Additional Column (Comments)
-- ============================================================

BEGIN TRAN

-- Add new column 'Comments' for tracking update/inserts
ALTER TABLE tblTransaction
ADD Comments varchar(50) NULL
GO

MERGE TOP (5) PERCENT INTO tblTransaction as T -- DML operation
USING (
    SELECT EmployeeNumber, DateOfTransaction, SUM(Amount) as Amount
    FROM tblTransactionNew
    GROUP BY EmployeeNumber, DateOfTransaction
) as S
ON T.EmployeeNumber = S.EmployeeNumber AND T.DateOfTransaction = S.DateOfTransaction
WHEN MATCHED AND T.Amount + S.Amount > 0 THEN
    -- Update with new total and comment
    UPDATE SET Amount = T.Amount + S.Amount, Comments = 'Updated Row'
WHEN MATCHED THEN
    -- Delete rows that do not meet the above condition
    DELETE
WHEN NOT MATCHED BY TARGET THEN
    -- Insert entirely new rows
    INSERT ([Amount], [DateOfTransaction], [EmployeeNumber], Comments)
    VALUES (S.Amount, S.DateOfTransaction, S.EmployeeNumber, 'Inserted Row')
WHEN NOT MATCHED BY SOURCE THEN
    -- For unmatched target rows (no matching source rows)
    UPDATE SET Comments = 'Unchanged'
OUTPUT inserted.*, deleted.*, $action;


--SELECT * FROM tblTransaction ORDER BY EmployeeNumber, DateOfTransaction

ROLLBACK TRAN
