SELECT * from tblTransaction
WHERE EmployeeNumber between 3 and 11
order by EmployeeNumber

select sum(Amount) from tblTransaction 
Where EmployeeNumber between 3 and 11

select count(Distinct EmployeeNumber) from tblTransaction 
Where EmployeeNumber between 3 and 11


select count(Distinct EmployeeNumber) from tblEmployee 
Where EmployeeNumber between 3 and 11

-- ============================================================
-- PROCEDURE Exercise
-- ============================================================

if object_ID('AverageBalance','P') IS NOT NULL
drop proc AverageBalance
go
create proc AverageBalance(@EmployeeNumberFrom int, @EmployeeNumberTo int, @AverageBalance int OUTPUT) as
begin

	declare @TotalAmount money
	declare @NumOfEmployee int

	select @TotalAmount = sum(Amount) from tblTransaction
	where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo

	select @NumOfEmployee = count(distinct EmployeeNumber) from tblEmployee
	where EmployeeNumber between @EmployeeNumberFrom and @EmployeeNumberTo

	set @AverageBalance = @TotalAmount / @NumOfEmployee
		
end
go

DECLARE @AvgBalance int, @ReturnStatus int
EXEC @ReturnStatus = AverageBalance 4, 5, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status
GO

DECLARE @AvgBalance int, @ReturnStatus int
execute @ReturnStatus = AverageBalance 223, 227, @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status
GO

DECLARE @AvgBalance int, @ReturnStatus int
exec @ReturnStatus = AverageBalance @EmployeeNumberFrom = 323, @EmployeeNumberTo = 327, @AverageBalance = @AvgBalance OUTPUT
select @AvgBalance as Average_Balance, @ReturnStatus as Return_Status

