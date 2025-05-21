-- Drop the procedure if it already exists
if object_ID('AverageBalance','P') IS NOT NULL
    drop proc AverageBalance
go

-- Create the stored procedure
create proc AverageBalance(@EmployeeNumberFrom int, @EmployeeNumberTo int,  @AverageBalance int OUTPUT) as
begin
    SET NOCOUNT ON
    declare @TotalAmount decimal(5,2)
    declare @NumOfEmployee int

    begin try
        -- Print the range of employee numbers being processed
        print 'The employee numbers are from ' + convert(varchar(10),@EmployeeNumberFrom) 
              + ' to ' + convert(varchar(10),@EmployeeNumberTo)

        select @TotalAmount = sum(Amount) 
        from tblTransaction
        where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo

        select @NumOfEmployee = count(distinct EmployeeNumber) 
        from tblEmployee
        where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo

        set @AverageBalance = @TotalAmount / @NumOfEmployee

        RETURN 0
    end try

    begin catch
        -- Handle division by zero (error 8134)
        set @AverageBalance = 0
        if ERROR_NUMBER() = 8134
        begin
            -- Inform the user via print if no valid employees were found
            print 'There are no valid employees in this range.'
            Return 8134
        end
        else
        begin
            -- Raise other errors with the error message
            declare @ErrorMessage as varchar(255)
            select @ErrorMessage = error_Message()

            -- Raise a custom error with severity 16
            raiserror (@ErrorMessage, 16, 1)

            -- Alternatively, could use THROW for modern error handling (commented out)
            -- throw 56789, 'Too many flanges', 1
        end

        -- Test message to confirm the CATCH block was reached
        select 'Hi There'
    end catch
end
go

-- Test the procedure with a small range
DECLARE @AvgBalance int, @ReturnStatus int
EXEC @ReturnStatus = AverageBalance 4, 5, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status
GO

-- Test with a different range
DECLARE @AvgBalance int, @ReturnStatus int
execute @ReturnStatus = AverageBalance 223, 227, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status, 'Error did not stop us' as myMessage
GO

-- Named parameters test
DECLARE @AvgBalance int, @ReturnStatus int
exec @ReturnStatus = AverageBalance 
    @EmployeeNumberFrom = 323, 
    @EmployeeNumberTo = 327, 
    @AverageBalance = @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status
