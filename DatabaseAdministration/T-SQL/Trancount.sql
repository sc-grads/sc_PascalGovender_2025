-- =======================================
-- TRANCOUNT: Nesting and Managing Transactions
-- Value changes according to how deep within the nexted transactions are
-- Rollback aborts everything,
-- Commit leaves the transaction and reduces the coutnt
-- =======================================

update [dbo].[tblEmployee]
set EmployeeNumber = 123
where EmployeeNumber = 122;

select * from [dbo].[tblEmployee];

-- Check current transaction count (should be 0)
select @@TRANCOUNT; -- 0

-- Begin outer transaction
begin tran
	select @@TRANCOUNT; -- 1

	-- Begin nested transaction
	begin tran
		update [dbo].[tblEmployee]
		set EmployeeNumber = 122
		where EmployeeNumber = 123;

		select @@TRANCOUNT; -- 2
	commit tran -- Commits inner transaction

	select @@TRANCOUNT; -- 1
-- Commit outer transaction if still active
if @@TRANCOUNT > 0
	commit tran

-- Confirm transaction fully committed
select @@TRANCOUNT; -- 0

-- Final state of the table
select * from [dbo].[tblEmployee];
