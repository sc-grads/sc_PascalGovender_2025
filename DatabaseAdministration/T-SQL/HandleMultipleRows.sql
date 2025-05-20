-- ============================================================
-- INSTEAD OF DELETE Trigger (Bad)
-- Handles only one row at a time (scalar variables used)
-- ============================================================
alter TRIGGER tr_ViewByDepartment
ON dbo.ViewByDepartment
INSTEAD OF DELETE
AS
BEGIN
    -- Scalar variables only store one row from 'deleted', so this fails on multi-row deletes
    declare @EmployeeNumber as int
	declare @DateOfTransaction as smalldatetime
	declare @Amount as smallmoney

	select @EmployeeNumber = EmployeeNumber, @DateOfTransaction = DateOfTransaction,  @Amount = TotalAmount
	from deleted  -- Will only retain the last row if multiple are passed

	-- Deletes only one matching row from tblTransaction
	delete tblTransaction
	from tblTransaction as T
	where T.EmployeeNumber = @EmployeeNumber
	and T.DateOfTransaction = @DateOfTransaction
	and T.Amount = @Amount
END

begin tran
SELECT * FROM ViewByDepartment where EmployeeNumber = 132
delete from ViewByDepartment
where EmployeeNumber = 132
SELECT * FROM ViewByDepartment where EmployeeNumber = 132
rollback tran

-- ============================================================
-- INSTEAD OF DELETE Trigger (Good)
-- Supports deleting multiple rows using a JOIN to 'deleted'
-- ============================================================
alter TRIGGER tr_ViewByDepartment
ON dbo.ViewByDepartment
INSTEAD OF DELETE
AS
BEGIN
	-- Optional: Debug output to see which rows will be deleted
	SELECT *, 'To Be Deleted' FROM deleted

	-- Deletes multiple matching rows using a JOIN with the deleted pseudo-table
    delete tblTransaction
	from tblTransaction as T
	join deleted as D
	on T.EmployeeNumber = D.EmployeeNumber
	and T.DateOfTransaction = D.DateOfTransaction
	and T.Amount = D.TotalAmount
END
GO

begin tran
SELECT *, 'Before Delete' FROM ViewByDepartment where EmployeeNumber = 132
delete from ViewByDepartment
where EmployeeNumber = 132 --and TotalAmount = 861.16
SELECT *, 'After Delete' FROM ViewByDepartment where EmployeeNumber = 132
rollback tran
