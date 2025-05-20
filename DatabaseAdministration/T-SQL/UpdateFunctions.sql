-- ============================================================
-- AFTER Trigger Using @@ROWCOUNT
-- Executes if any rows were affected in DELETE/INSERT/UPDATE
-- ============================================================
ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
	-- Ensures code inside executes only if at least one row is affected
	IF @@ROWCOUNT > 0
	BEGIN
		select * from Inserted
		select * from Deleted
	END
END
GO

-- Test INSERT to trigger above
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
VALUES (123,'2015-07-11', 123)

-- View specific entry from the View
SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132

-- Delete using view
begin tran
delete from ViewByDepartment
where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran

-- ============================================================
-- AFTER Trigger Using UPDATE(column_name)
-- Executes only if a specific column (Amount) was updated
-- ============================================================
ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
	-- Use UPDATE(column_name) to check if "Amount" column was updated
	-- SELECT COLUMNS_UPDATED()
	-- Example of bitwise check : (COLUMNS_UPDATED() & POWER(2,1-1)) > 0
	IF UPDATE(Amount)
	BEGIN
		select * from Inserted
		select * from Deleted
	END
END
go

-- Trigger test via UPDATE on the view (ROLLBACK used)
begin tran
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
update ViewByDepartment
set TotalAmount = +2.77
where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran
