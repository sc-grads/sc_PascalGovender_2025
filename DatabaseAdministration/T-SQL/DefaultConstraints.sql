-- Syntax: ALTER TABLE table_name ADD column_name datatype [DEFAULT default_value];
--         CREATE TABLE ... column_name datatype [DEFAULT default_value];
--         ALTER TABLE table_name DROP COLUMN column_name;
--         ALTER TABLE table_name DROP CONSTRAINT constraint_name;

alter table tblTransaction
add DateOfEntry datetime  -- Add a new column without default initially

alter table tblTransaction
add constraint defDateOfEntry DEFAULT GETDATE() for DateOfEntry;  -- Add DEFAULT constraint to existing column

delete from tblTransaction where EmployeeNumber < 3

insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
values (1, '2014-01-01', 1)
insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber, DateOfEntry)
values (2, '2014-01-02', 1, '2013-01-01')

select * from tblTransaction where EmployeeNumber < 3

-------------------------------------------------------------

-- Create new table with a column that has a DEFAULT constraint defined inline
create table tblTransaction2
(
  Amount smallmoney not null,
  DateOfTransaction smalldatetime not null,
  EmployeeNumber int not null,
  DateOfEntry datetime null CONSTRAINT tblTransaction2_defDateOfEntry DEFAULT GETDATE()
)

insert into tblTransaction2(Amount, DateOfTransaction, EmployeeNumber)
values (1, '2014-01-01', 1)
insert into tblTransaction2(Amount, DateOfTransaction, EmployeeNumber, DateOfEntry)
values (2, '2014-01-02', 1, '2013-01-01')

select * from tblTransaction2 where EmployeeNumber < 3

drop table tblTransaction2  -- Remove the test table

alter table tblTransaction
drop column DateOfEntry  -- Drop the column from existing table

alter table tblTransaction
drop constraint defDateOfEntry  -- Drop the default constraint separately

BEGIN TRAN

-- Add column with DEFAULT constraint in a single statement, and apply default to existing rows using WITH VALUES
ALTER TABLE tblTransaction
ADD DateOfEntry datetime
DEFAULT GETDATE() WITH VALUES

SELECT * FROM tblTransaction

ROLLBACK TRAN
