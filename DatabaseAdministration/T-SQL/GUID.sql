-- ============================================
-- GUIDs and Sequential IDs
-- ============================================

-- Generate a random GUID using NEWID()
DECLARE @newvalue AS uniqueidentifier; -- GUID
SET @newvalue = NEWID();
SELECT @newvalue AS TheNewID;
GO

-- Generate a random seed using system datetime to feed into RAND()
DECLARE @randomnumbergenerator INT = DATEPART(MILLISECOND, SYSDATETIME()) 
                                   + 1000 * (DATEPART(SECOND, SYSDATETIME()) 
                                   + 60 * (DATEPART(MINUTE, SYSDATETIME()) 
                                   + 60 * DATEPART(HOUR, SYSDATETIME())));
SELECT RAND(@randomnumbergenerator) AS RandomNumber;

-- ============================================
-- Creating a Table with NEWID() as Default GUID
-- ============================================
BEGIN TRAN;

-- Table with UniqueIdentifier (GUID) as default NEWID(), and unique constraint on EmployeeNumber
CREATE TABLE tblEmployee4
(
    UniqueID uniqueidentifier CONSTRAINT df_tblEmployee4_UniqueID DEFAULT NEWID(),
    EmployeeNumber INT CONSTRAINT uq_tblEmployee4_EmployeeNumber UNIQUE
);

-- Insert sample values
INSERT INTO tblEmployee4(EmployeeNumber)
VALUES (1), (2), (3);

-- View inserted values
SELECT * FROM tblEmployee4;

-- Rollback transaction to prevent actual changes during testing
ROLLBACK TRAN;
GO

-- ============================================
-- Creating a Table with NEWSEQUENTIALID()
-- ============================================
BEGIN TRAN;

-- Using NEWSEQUENTIALID() for more index-friendly GUIDs
CREATE TABLE tblEmployee4
(
    UniqueID uniqueidentifier CONSTRAINT df_tblEmployee4_UniqueID DEFAULT NEWSEQUENTIALID(),
    EmployeeNumber INT CONSTRAINT uq_tblEmployee4_EmployeeNumber UNIQUE
);

-- Insert sample data again
INSERT INTO tblEmployee4(EmployeeNumber)
VALUES (1), (2), (3);

-- View contents
SELECT * FROM tblEmployee4;

-- Rollback again to clean up
ROLLBACK TRAN;
