-- ============================================================
-- Nested Triggers Example
-- Syntax: @@NESTLEVEL returns the current level of trigger nesting.
-- Nested triggers occur when a trigger causes another trigger to fire.
-- ============================================================

ALTER TRIGGER TR_tblTransaction
ON tblTransaction
AFTER DELETE, INSERT, UPDATE
AS
BEGIN
    -- Check if this is the outermost trigger call
    if @@NESTLEVEL = 1
	begin
		-- Select rows affected in the outermost trigger context
		select *,'TABLEINSERT' from Inserted
		select *, 'TABLEDELETE' from Deleted
	end
END
GO

-- ============================================================
-- Trigger Test (from table directly)
-- ============================================================
BEGIN TRAN
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
VALUES (123,'2015-07-10', 123)
ROLLBACK TRAN

-- ============================================================
-- Trigger Test (from view, which may fire INSTEAD OF or further triggers)
-- ============================================================
begin tran
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
delete from ViewByDepartment
where TotalAmount = -2.77 and EmployeeNumber = 132
--SELECT * FROM ViewByDepartment where TotalAmount = -2.77 and EmployeeNumber = 132
rollback tran

-- ============================================================
-- Viewing and Disabling Nested Triggers
-- Use this to control whether nested triggers are allowed at the server level
-- ============================================================

EXEC sp_configure 'nested triggers'; -- View current setting

EXEC sp_configure 'nested triggers', 0; -- Disable nested triggers
RECONFIGURE
GO
