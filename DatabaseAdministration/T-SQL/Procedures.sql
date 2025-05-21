-- ============================================================
-- First Procedure
-- Syntax: CREATE PROC [procedureName] AS BEGIN {work to be done} END
-- ============================================================
-- Creates a basic stored procedure to return all employees
CREATE PROC NameEmployees AS
BEGIN
    SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName
    FROM tblEmployee
END
GO

-- Execute the stored procedure
NameEmployees
EXECUTE NameEmployees
EXEC NameEmployees

-- ============================================================
-- Parameters
-- ============================================================
-- Drop the procedure if it already exists
IF OBJECT_ID('NameEmployees','P') IS NOT NULL
    DROP PROC NameEmployees
GO

-- Create procedure that accepts an EmployeeNumber
CREATE PROC NameEmployees(@EmployeeNumber INT) AS
BEGIN
    IF EXISTS (SELECT * FROM tblEmployee WHERE EmployeeNumber = @EmployeeNumber)
    BEGIN
        SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName
        FROM tblEmployee
        WHERE EmployeeNumber = @EmployeeNumber
    END
END
GO

-- Call the procedure
NameEmployees 4
EXECUTE NameEmployees 223
EXEC NameEmployees 323

-- Using local variable
DECLARE @EmployeeName INT = 123
SELECT @EmployeeName

-- ============================================================
-- Exercise with IF (conditionals)
-- ============================================================

IF OBJECT_ID('NameEmployees','P') IS NOT NULL
    DROP PROC NameEmployees
GO

-- Procedure provides different result sets based on EmployeeNumber
CREATE PROC NameEmployees(@EmployeeNumber INT) AS
BEGIN
	-- Conditionals
    IF EXISTS (SELECT * FROM tblEmployee WHERE EmployeeNumber = @EmployeeNumber)
    BEGIN
        IF @EmployeeNumber < 300
        BEGIN
            SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName
            FROM tblEmployee
            WHERE EmployeeNumber = @EmployeeNumber
        END
        ELSE
        BEGIN
            SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName, Department
            FROM tblEmployee
            WHERE EmployeeNumber = @EmployeeNumber

            SELECT * FROM tblTransaction
            WHERE EmployeeNumber = @EmployeeNumber
        END
    END
END
GO

-- Test with values
NameEmployees 4
EXECUTE NameEmployees 223
EXEC NameEmployees 324

-- ============================================================
-- Multiple Arguments (conditionals)
-- ============================================================

IF OBJECT_ID('NameEmployees','P') IS NOT NULL
    DROP PROC NameEmployees
GO

-- Procedure to fetch multiple employees in a range
CREATE PROC NameEmployees(@EmployeeNumberFrom INT, @EmployeeNumberTo INT) AS -- Creating multiple arguments/parameters
BEGIN
    IF EXISTS (
        SELECT * FROM tblEmployee 
        WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo)
    BEGIN
        SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName
        FROM tblEmployee
        WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo
    END
END
GO

-- Execute with range of employee numbers
NameEmployees 4, 5
EXECUTE NameEmployees 223, 227
EXEC NameEmployees @EmployeeNumberFrom = 323, @EmployeeNumberTo = 327

-- ============================================================
-- WHILE loop (conditionals)
-- ============================================================

IF OBJECT_ID('NameEmployees','P') IS NOT NULL
    DROP PROC NameEmployees
GO

-- Looping through each employee and running separate SELECTs
CREATE PROC NameEmployees(@EmployeeNumberFrom INT, @EmployeeNumberTo INT) AS
BEGIN
    IF EXISTS (
        SELECT * FROM tblEmployee 
        WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo)
    BEGIN
        DECLARE @EmployeeNumber INT = @EmployeeNumberFrom
        WHILE @EmployeeNumber <= @EmployeeNumberTo
        BEGIN
            IF EXISTS (SELECT * FROM tblEmployee WHERE EmployeeNumber = @EmployeeNumber)
            BEGIN
                SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName
                FROM tblEmployee
                WHERE EmployeeNumber = @EmployeeNumber
            END
            SET @EmployeeNumber = @EmployeeNumber + 1
        END
    END
END
GO

-- Test the procedure with ranges
NameEmployees 4, 5
EXECUTE NameEmployees 223, 227
EXEC NameEmployees @EmployeeNumberFrom = 323, @EmployeeNumberTo = 1327


-- ============================================================
-- Returns (conditionals)
-- ============================================================

IF OBJECT_ID('NameEmployees','P') IS NOT NULL
    DROP PROC NameEmployees
GO

-- Procedure returns row count (via OUTPUT) and status (via RETURN)
CREATE PROC NameEmployees(@EmployeeNumberFrom INT,@EmployeeNumberTo INT,@NumberOfRows INT OUTPUT) AS
BEGIN
    IF EXISTS (
        SELECT * FROM tblEmployee 
        WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo)
    BEGIN
        SELECT EmployeeNumber, EmployeeFirstName, EmployeeLastName
        FROM tblEmployee
        WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo

        SET @NumberOfRows = @@ROWCOUNT
        RETURN 0 -- Returns for Success
    END
    ELSE
    BEGIN
        SET @NumberOfRows = 0
        RETURN 1 -- Returns for Failure
    END
END
GO

-- Call with OUTPUT and capture return value
DECLARE @NumberRows INT, @ReturnStatus INT
EXEC @ReturnStatus = NameEmployees 4, 5, @NumberRows OUTPUT
SELECT @NumberRows AS MyRowCount, @ReturnStatus AS Return_Status
GO

DECLARE @NumberRows INT, @ReturnStatus INT
EXECUTE @ReturnStatus = NameEmployees 4, 327, @NumberRows OUTPUT
SELECT @NumberRows AS MyRowCount, @ReturnStatus AS Return_Status
GO

DECLARE @NumberRows INT, @ReturnStatus INT
EXEC @ReturnStatus = NameEmployees 
     @EmployeeNumberFrom = 323, 
     @EmployeeNumberTo = 327, 
     @NumberOfRows = @NumberRows OUTPUT
SELECT @NumberRows AS MyRowCount, @ReturnStatus AS Return_Status
