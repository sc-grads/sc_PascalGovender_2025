-- ============================================
-- Defining SEQUENCES
-- ============================================

BEGIN TRAN;

-- Create a BIGINT sequence starting from 1, incrementing by 1
CREATE SEQUENCE newSeq AS BIGINT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    CACHE 50;

-- Create another sequence with INT datatype
CREATE SEQUENCE secondSeq AS INT;

-- View all sequences in the database
SELECT * FROM sys.sequences;

-- Undo changes
ROLLBACK TRAN;


-- ============================================
-- NEXT VALUE FOR Sequence
-- ============================================

BEGIN TRAN;

-- Create a new BIGINT sequence for demonstration
CREATE SEQUENCE newSeq AS BIGINT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    CACHE 50;

-- Get the next value from the sequence
SELECT NEXT VALUE FOR newSeq AS NextValue;

-- Optional: Apply sequence to rows with a function
-- SELECT *, NEXT VALUE FOR newSeq OVER (ORDER BY DateOfTransaction) AS NextNumber
-- FROM tblTransaction;

-- Undo changes (for testing only)
ROLLBACK TRAN;


-- ============================================
-- Add Column with Sequence Default
-- ============================================

-- Create sequence again (if needed)
CREATE SEQUENCE newSeq AS BIGINT
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    CACHE 50;

-- Add a column that auto-generates using the sequence
ALTER TABLE tblTransaction
ADD NextNumber INT CONSTRAINT DF_Transaction DEFAULT NEXT VALUE FOR newSeq;

-- Drop constraint and column (cleanup)
ALTER TABLE tblTransaction DROP CONSTRAINT DF_Transaction;
ALTER TABLE tblTransaction DROP COLUMN NextNumber;

-- Alternative approach: Add column first, then constraint
ALTER TABLE tblTransaction ADD NextNumber INT;
ALTER TABLE tblTransaction 
ADD CONSTRAINT DF_Transaction DEFAULT NEXT VALUE FOR newSeq FOR NextNumber;


-- ============================================
-- Using Sequence in INSERT and UPDATE
-- ============================================

BEGIN TRAN;

-- View data before insert
SELECT * FROM tblTransaction;

-- Insert a new row; default constraint will assign a sequence number
INSERT INTO tblTransaction (Amount, DateOfTransaction, EmployeeNumber)
VALUES (1, '2017-01-01', 123);

-- Check inserted row
SELECT * FROM tblTransaction WHERE EmployeeNumber = 123;

-- Update any NULLs in NextNumber using sequence
UPDATE tblTransaction
SET NextNumber = NEXT VALUE FOR newSeq
WHERE NextNumber IS NULL;

-- Confirm updated values
SELECT * FROM tblTransaction;

-- Rollback to undo all changes
ROLLBACK TRAN;


-- ============================================
-- Reset and Drop Sequence
-- ============================================

-- Restart the sequence from 1
ALTER SEQUENCE newSeq RESTART WITH 1;

-- Drop default constraint and column
ALTER TABLE tblTransaction DROP CONSTRAINT DF_Transaction;
ALTER TABLE tblTransaction DROP COLUMN NextNumber;

-- Drop the sequence
DROP SEQUENCE newSeq;
