-- Drop the procedure if it already exists
IF OBJECT_ID('AverageBalance','P') IS NOT NULL
    DROP PROC AverageBalance
GO

-- ============================================================
-- TRY CATCH
-- Syntax:
-- BEGIN TRY
--    -- {Code that might cause an error}
-- END TRY
-- BEGIN CATCH
--    -- {Error handling code}
-- END CATCH

-- ============================================================

CREATE PROC AverageBalance(
    @EmployeeNumberFrom INT,
    @EmployeeNumberTo INT,
    @AverageBalance INT OUTPUT
) AS
BEGIN
    SET NOCOUNT ON

    DECLARE @TotalAmount MONEY
    DECLARE @NumOfEmployee INT
	-- Syntax : BEGIN TRY ..... END TRY
    BEGIN TRY
        -- Sum the transaction amounts for the given employee range
        SELECT @TotalAmount = SUM(Amount)
        FROM tblTransaction
        WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo

        -- Count distinct employees in the given range
        SELECT @NumOfEmployee = COUNT(DISTINCT EmployeeNumber)
        FROM tblEmployee
        WHERE EmployeeNumber BETWEEN @EmployeeNumberFrom AND @EmployeeNumberTo

        -- Calculate average balance (integer division)
        SET @AverageBalance = @TotalAmount / @NumOfEmployee

        RETURN 0  -- Indicate success
    END TRY

    BEGIN CATCH
        -- If error occurs, set output to 0 and return error info
        SET @AverageBalance = 0

        SELECT 
            ERROR_MESSAGE() AS ErrorMessage,
            ERROR_LINE() AS ErrorLine,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_PROCEDURE() AS ErrorProcedure,
            ERROR_SEVERITY() AS ErrorSeverity,  -- Informational (0-10), Default-Errors (11-16), Fatal (17-25)
            ERROR_STATE() AS ErrorState

        RETURN 1  -- Indicate failure
    END CATCH
END
GO

DECLARE @AvgBalance INT, @ReturnStatus INT
EXEC @ReturnStatus = AverageBalance 4, 5, @AvgBalance OUTPUT
SELECT @AvgBalance AS Average_Balance, @ReturnStatus AS Return_Status
GO

DECLARE @AvgBalance INT, @ReturnStatus INT
EXECUTE @ReturnStatus = AverageBalance 223, 227, @AvgBalance OUTPUT
SELECT @AvgBalance AS Average_Balance, @ReturnStatus AS Return_Status
GO

DECLARE @AvgBalance INT, @ReturnStatus INT
EXEC @ReturnStatus = AverageBalance 
     @EmployeeNumberFrom = 323, 
     @EmployeeNumberTo = 327, 
     @AverageBalance = @AvgBalance OUTPUT
SELECT @AvgBalance AS Average_Balance, @ReturnStatus AS Return_Status

-- TRY_CONVERT fails but does not throw an error (returns NULL instead)
SELECT TRY_CONVERT(INT, 'two') AS TryResult  -- Returns NULL
