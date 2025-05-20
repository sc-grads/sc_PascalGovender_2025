-- ============================================================
-- Creating an AFTER trigger

-- Syntax: AFTER triggers fire automatically after INSERT, UPDATE, or DELETE
--CREATE TRIGGER TriggerName
--    ON [dbo].[TableName]
--    AFTER DELETE, INSERT, UPDATE
--    AS
--    BEGIN
--    SET NOCOUNT ON
--    END
-- ============================================================

CREATE TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
	-- Inserted table holds new rows (from INSERT or UPDATE)
	-- Deleted table holds old rows (from DELETE or UPDATE)

	-- insert into tblTransaction2
	select *, 'Inserted' from Inserted

	-- insert into tblTransaction2 
	select *, 'Deleted' from Deleted
END
GO

-- Example transaction that would trigger the above trigger
BEGIN TRAN
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
VALUES (123,'2015-07-10', 123)
--delete tblTransaction 
--where EmployeeNumber = 123 and DateOfTransaction = '2015-07-10'
ROLLBACK TRAN
GO

-- Disabling and enabling the trigger on the table
DISABLE TRIGGER TR_tblTransaction ON tblTransaction;
GO
ENABLE TRIGGER TR_tblTransaction ON tblTransaction;
GO

-- Dropping the trigger
DROP TRIGGER TR_tblTransaction;
GO

-- ============================================================
-- Creating an INSTEAD OF trigger (only choose one)
-- Syntax: INSTEAD OF triggers override the action (used for views)
--CREATE TRIGGER TriggerName
--    ON [dbo].[TableName]
--    AFTER DELETE, INSERT, UPDATE
--    AS
--    BEGIN
--    SET NOCOUNT ON
--    END
-- ============================================================

Create TRIGGER tr_ViewByDepartment
ON dbo.ViewByDepartment
INSTEAD OF DELETE
AS
BEGIN
	-- Declare variables to hold the values from the deleted row
    declare @EmployeeNumber as int
	declare @DateOfTransaction as smalldatetime
	declare @Amount as smallmoney

	-- Capture the deleted row's values
	select @EmployeeNumber = EmployeeNumber, @DateOfTransaction = DateOfTransaction,  @Amount = TotalAmount
	from deleted

	-- Delete the corresponding row in the base table (tblTransaction)
	delete tblTransaction
	from tblTransaction as T
	where T.EmployeeNumber = @EmployeeNumber
	and T.DateOfTransaction = @DateOfTransaction
	and T.Amount = @Amount
END

-- Test deleting from view, which routes to base table via trigger
begin tran
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
delete from ViewByDepartment
where TotalAmount = -2.77 and EmployeeNumber = 132

--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran
