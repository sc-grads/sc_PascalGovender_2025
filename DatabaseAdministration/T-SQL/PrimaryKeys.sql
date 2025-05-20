-- Syntax: 
-- ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY (column);
-- CREATE TABLE ... column_name datatype CONSTRAINT constraint_name PRIMARY KEY;
-- IDENTITY(seed, increment) is used to auto-generate primary key values.

-- Add a PRIMARY KEY constraint to the EmployeeNumber column
alter table tblEmployee
add constraint PK_tblEmployee PRIMARY KEY (EmployeeNumber)

insert into tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, 
EmployeeGovernmentID, DateOfBirth, Department) 
values (2004, 'FirstName', 'MiddleName', 'LastName', 'AB12345FI', '2014-01-01', 'Accounts')

delete from tblEmployee
where EmployeeNumber = 2004

-- Drop the PRIMARY KEY constraint from the table
alter table tblEmployee
drop constraint PK_tblEmployee

-- Create a new table with a PRIMARY KEY on EmployeeNumber using IDENTITY for auto-increment
create table tblEmployee2
(
  EmployeeNumber int CONSTRAINT PK_tblEmployee2 PRIMARY KEY IDENTITY(1,1),
  EmployeeName nvarchar(20)
)

insert into tblEmployee2
values ('My Name'),
('My Name')

select * from tblEmployee2

delete from tblEmployee2

truncate table tblEmployee2

-- Insert explicit values into an IDENTITY column by enabling IDENTITY_INSERT
SET IDENTITY_INSERT tblEmployee2 ON

insert into tblEmployee2(EmployeeNumber, EmployeeName)
values (3, 'My Name'), (4, 'My Name')

insert into tblEmployee2(EmployeeNumber, EmployeeName)
values (38, 'My Name'), (39, 'My Name')

SET IDENTITY_INSERT tblEmployee2 OFF

drop table tblEmployee2

-- Identity-related built-in functions (shown for completeness, not annotated)
select @@IDENTITY
select SCOPE_IDENTITY()
select IDENT_CURRENT('dbo.tblEmployee2')

-- Create another table with a PRIMARY KEY and IDENTITY
create table tblEmployee3
(
  EmployeeNumber int CONSTRAINT PK_tblEmployee3 PRIMARY KEY IDENTITY(1,1),
  EmployeeName nvarchar(20)
)

insert into tblEmployee3
values ('My Name'),
('My Name')
