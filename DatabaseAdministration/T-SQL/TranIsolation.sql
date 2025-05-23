-- ===========================================
-- Isolation Levels Demo
-- Transaction 1: Data Modification
-- ===========================================
begin transaction;

-- Modify data (e.g., simulate concurrent access scenario)
update [dbo].[tblEmployee]
set EmployeeNumber = 122
where EmployeeNumber = 123;

-- Commit transaction 1
commit tran;

update [dbo].[tblEmployee]
set EmployeeNumber = 123
where EmployeeNumber = 122;

insert into [dbo].[tblEmployee](
	[EmployeeNumber], [EmployeeFirstName], [EmployeeMiddleName],
	[EmployeeLastName], [EmployeeGovernmentID], [DateOfBirth], [Department])
values (122, 'H', 'I', 'T', 'H', '2010-01-01', 'H');

delete from [dbo].[tblEmployee]
where EmployeeNumber = 122;

-- ===========================================
-- Transaction 2: Isolation Level - Read Committed
-- ===========================================

-- Set isolation level (default is READ COMMITTED)
set transaction isolation level read committed;

-- Begin transaction 2
begin tran;

-- First read - should get committed data only
select * from [dbo].[tblEmployee];

-- Simulate a delay
waitfor delay '00:00:20';

-- Second read - may show different results if another transaction committed in between
select * from [dbo].[tblEmployee];

-- Commit transaction
commit tran;

-- ===========================================
-- Other Isolation Levels
-- ===========================================

-- ============================================================
-- Transaction Isolation Levels: Simple Examples
-- ============================================================

-- 1. READ UNCOMMITTED
-- Allows dirty reads (can read uncommitted changes from other transactions)
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRAN
SELECT * FROM [dbo].[tblEmployee]; -- May include uncommitted data
COMMIT;

-- 2. READ COMMITTED (Default)
-- Prevents dirty reads. Only reads committed data.
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRAN
SELECT * FROM [dbo].[tblEmployee]; -- Waits if another transaction is modifying
COMMIT;

-- 3. REPEATABLE READ
-- Prevents dirty reads and non-repeatable reads (but phantom rows possible)
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN
SELECT * FROM [dbo].[tblEmployee]; -- Locks rows so others can't modify until committed
COMMIT;

-- 4. SERIALIZABLE
-- Most strict. Prevents dirty, non-repeatable, and phantom reads.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN
SELECT * FROM [dbo].[tblEmployee]; -- Locks range of rows; no inserts allowed until committed
COMMIT;

-- 5. SNAPSHOT
-- Reads data as it existed at the beginning of the transaction (versioned)
-- Requires ALLOW_SNAPSHOT_ISOLATION to be ON at DB level
-- ALTER DATABASE [YourDatabaseName] SET ALLOW_SNAPSHOT_ISOLATION ON;
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRAN
SELECT * FROM [dbo].[tblEmployee]; -- Sees consistent snapshot regardless of concurrent changes
COMMIT;
