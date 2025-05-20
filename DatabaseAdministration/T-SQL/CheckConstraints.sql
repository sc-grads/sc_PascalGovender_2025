-- Syntax: ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK (condition);
--         CREATE TABLE ... column_name datatype [CONSTRAINT constraint_name CHECK (condition)];
--         ALTER TABLE table_name DROP CONSTRAINT constraint_name;

-- Add a CHECK constraint to ensure Amount is within a valid range
alter table tblTransaction
add constraint chkAmount check (Amount > -1000 and Amount < 1000)

insert into tblTransaction
values (1010, '2014-01-01', 1)

-- Add a CHECK constraint with NOCHECK to skip validation of existing data
-- Ensures middle name doesn't contain periods or is NULL
alter table tblEmployee with nocheck
add constraint chkMiddleName check
(REPLACE(EmployeeMiddleName, '.', '') = EmployeeMiddleName or EmployeeMiddleName is null)

alter table tblEmployee
drop constraint chkMiddleName  -- Drop the CHECK constraint

begin tran
  insert into tblEmployee
  values (2003, 'A', 'B.', 'C', 'D', '2014-01-01', 'Accounts')
  select * from tblEmployee where EmployeeNumber = 2003
rollback tran

-- Add a CHECK constraint on date range for DateOfBirth with NOCHECK
alter table tblEmployee with nocheck
add constraint chkDateOfBirth check (DateOfBirth between '1900-01-01' and getdate())

begin tran
  insert into tblEmployee
  values (2003, 'A', 'B', 'C', 'D', '2115-01-01', 'Accounts')
  select * from tblEmployee where EmployeeNumber = 2003
rollback tran

-- Create a table with an inline CHECK constraint on EmployeeMiddleName
create table tblEmployee2
(
  EmployeeMiddleName varchar(50) null, 
  constraint CK_EmployeeMiddleName check 
  (REPLACE(EmployeeMiddleName, '.', '') = EmployeeMiddleName or EmployeeMiddleName is null)
)

drop table tblEmployee2

-- Drop the CHECK constraints that were previously added
alter table tblEmployee
drop chkDateOfBirth

alter table tblEmployee
drop chkMiddleName

alter table tblTransaction
drop chkAmount
