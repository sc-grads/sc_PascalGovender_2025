-- Syntax:
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name 
-- FOREIGN KEY (column) REFERENCES other_table(primary_key_column)
-- [ON DELETE action] [ON UPDATE action];

BEGIN TRAN

-- Allow NULLs in the foreign key column to support optional or defaulted values
ALTER TABLE tblTransaction ALTER COLUMN EmployeeNumber INT NULL 

-- Add a DEFAULT value to be used when a referenced row is deleted (via ON DELETE SET DEFAULT)
ALTER TABLE tblTransaction ADD CONSTRAINT DF_tblTransaction DEFAULT 124 FOR EmployeeNumber

-- Add a FOREIGN KEY constraint with cascading update and default on delete
ALTER TABLE tblTransaction WITH NOCHECK
ADD CONSTRAINT FK_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber)
REFERENCES tblEmployee(EmployeeNumber)
ON UPDATE CASCADE             -- If EmployeeNumber in tblEmployee changes, update in tblTransaction
ON DELETE SET DEFAULT         -- If a referenced employee is deleted, set EmployeeNumber to default (124)

-- UPDATE tblEmployee SET EmployeeNumber = 9123 Where EmployeeNumber = 123
DELETE tblEmployee Where EmployeeNumber = 123

SELECT E.EmployeeNumber, T.*
FROM tblEmployee as E
RIGHT JOIN tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.Amount IN (-179.47, 786.22, -967.36, 957.03)

ROLLBACK TRAN
