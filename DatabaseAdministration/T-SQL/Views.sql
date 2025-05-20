-- ================================================
-- Creating Views
-- Syntax: CREATE VIEW view_name AS SELECT ...
-- ================================================

select 1
go

-- Create a view that shows transactions per department for specific employees
create view ViewByDepartment as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
--order by D.Department, T.EmployeeNumber
go

-- Create a summarized view grouping transactions by department and employee
create view ViewSummary as 
select D.Department, T.EmployeeNumber as EmpNum, sum(T.Amount) as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
group by D.Department, T.EmployeeNumber
--order by D.Department, T.EmployeeNumber
go

select * from ViewByDepartment
select * from ViewSummary

-- ================================================
-- Altering and Dropping Views
-- Syntax: DROP VIEW view_name
-- ================================================

USE [70-461]
GO

-- Drop view if it exists using INFORMATION_SCHEMA
if exists(select * from INFORMATION_SCHEMA.VIEWS
where [TABLE_NAME] = 'ViewByDepartment' and [TABLE_SCHEMA] = 'dbo')
   drop view dbo.ViewByDepartment
go

-- Recreate the view after dropping
CREATE view [dbo].[ViewByDepartment] as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
--order by D.Department, T.EmployeeNumber
GO

-- ================================================
-- Adding New Rows to Views
-- Note: Works only if the view is updatable and all base columns are included
-- ================================================

begin tran

insert into ViewByDepartment(EmployeeNumber,DateOfTransaction,TotalAmount)
values (132,'2015-07-07', 999.99)

select * from ViewByDepartment order by Department, EmployeeNumber

rollback tran

begin tran
select * from ViewByDepartment order by EmployeeNumber, DateOfTransaction

update ViewByDepartment
set EmployeeNumber = 142
where EmployeeNumber = 132

select * from ViewByDepartment order by EmployeeNumber, DateOfTransaction
rollback tran

-- ================================================
-- Adding WITH CHECK OPTION to a View
-- Enforces the WHERE clause when inserting/updating via the view
-- ================================================

USE [70-461]
GO

if exists(select * from INFORMATION_SCHEMA.VIEWS
where [TABLE_NAME] = 'ViewByDepartment' and [TABLE_SCHEMA] = 'dbo')
   drop view dbo.ViewByDepartment
go

CREATE view [dbo].[ViewByDepartment] as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from tblDepartment as D
left join tblEmployee as E
on D.Department = E.Department
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
WITH CHECK OPTION
--order by D.Department, T.EmployeeNumber
GO

-- ================================================
-- Deleting Rows via Views
-- ================================================

SELECT * FROM ViewByDepartment

-- Delete rows from the view (which affects the base table)
delete from ViewByDepartment
where TotalAmount = 999.99 and EmployeeNumber = 132
GO

-- Create a simple view over the entire base table
CREATE VIEW ViewSimple
as
SELECT * FROM tblTransaction
GO

BEGIN TRAN
delete from ViewSimple
where EmployeeNumber = 132
select * from ViewSimple
ROLLBACK TRAN

-- ================================================
-- Creating an Indexed View
-- Syntax: Must use SCHEMABINDING and all referenced columns must be explicitly named
-- ================================================

USE [70-461]
GO

if exists(select * from INFORMATION_SCHEMA.VIEWS
where [TABLE_NAME] = 'ViewByDepartment' and [TABLE_SCHEMA] = 'dbo')
   drop view dbo.ViewByDepartment
go

-- Create a view with SCHEMABINDING required for indexing
CREATE view [dbo].[ViewByDepartment] with schemabinding as 
select D.Department, T.EmployeeNumber, T.DateOfTransaction, T.Amount as TotalAmount
from dbo.tblDepartment as D
inner join dbo.tblEmployee as E
on D.Department = E.Department
inner join dbo.tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber between 120 and 139
GO

-- Create a unique clustered index to materialize the view (makes it indexed)
CREATE UNIQUE CLUSTERED INDEX inx_ViewByDepartment on dbo.ViewByDepartment(EmployeeNumber, Department)

-- Test rollback behavior related to the view
begin tran
drop table tblEmployee
rollback tran
