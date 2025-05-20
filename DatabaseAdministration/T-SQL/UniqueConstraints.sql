-- Syntax: ALTER TABLE table_name ADD CONSTRAINT constraint_name UNIQUE (column1, column2, ...);

alter table tblEmployee
ADD CONSTRAINT unqGovernmentID UNIQUE (EmployeeGovernmentID);  -- Add UNIQUE constraint on a single column


select EmployeeGovernmentID, count(EmployeeGovernmentID) as MyCount from tblEmployee
group by EmployeeGovernmentID
having count(EmployeeGovernmentID)>1

select * from tblEmployee where EmployeeGovernmentID IN ('HN513777D', 'TX593671R')

begin tran
delete from tblEmployee
where EmployeeNumber < 3

delete top(2) from tblEmployee
where EmployeeNumber in (131, 132)

select * from tblEmployee where EmployeeGovernmentID IN ('HN513777D', 'TX593671R')

commit tran

-------------------------------------------------

-- Add UNIQUE constraint on multiple columns (composite constraint)
-- Enforces uniqueness only when all specified column values combined are unique
alter table tblTransaction
add constraint unqTransaction UNIQUE (Amount, DateOfTransaction, EmployeeNumber)

delete from tblTransaction
where EmployeeNumber = 131

insert into tblTransaction
VALUES (1,'2015-01-01', 131)
insert into tblTransaction
VALUES (1,'2015-01-01', 131)

-- Drop a previously added UNIQUE constraint
alter table tblTransaction
Drop constraint unqTransaction

-------------------------------------------------

-- Create a new table with a composite UNIQUE constraint already defined
create table tblTransaction2
(
  Amount smallmoney not null,
  DateOfTransaction smalldatetime not null,
  EmployeeNumber int not null,
  CONSTRAINT unqTransaction2 UNIQUE (Amount,DateOfTransaction,EmployeeNumber)
)

drop table tblTransaction2
