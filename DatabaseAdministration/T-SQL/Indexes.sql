-- ===============================
-- Clustered Index
-- ===============================

-- Creates a clustered index on EmployeeNumber (physically orders the table by this column)
create clustered index idx_tblEmployee on [dbo].[tblEmployee]([EmployeeNumber])

-- Drops the clustered index
drop index idx_tblEmployee on [dbo].[tblEmployee]

-- Queries to observe index effects
select * from [dbo].[tblEmployee2] where [EmployeeNumber] = 127  -- Likely index seek
select * from [dbo].[tblEmployee2]  -- Full table scan

-- New table
select *
into [dbo].[tblEmployee2]
from [dbo].[tblEmployee]
where EmployeeNumber <> 131

-- Seek vs Scan:
-- seek = fast lookup using index
-- scan = slow, reads entire table

-- Add primary key (also creates a clustered index by default if none exists)
alter table [dbo].[tblEmployee2]
add constraint pk_tblEmployee2 PRIMARY KEY(EmployeeNumber)

-- Create a table with a primary key (also clustered index unless specified otherwise)
create table myTable (Field1 int primary key)

-- ===============================
-- Non-clustered Index
-- ===============================

-- Creates a non-clustered index on DateOfBirth
create nonclustered index idx_tblEmployee_DateOfBirth on [dbo].[tblEmployee]([DateOfBirth])

-- Composite index on DateOfBirth and Department
create nonclustered index idx_tblEmployee_DateOfBirth_Department 
on [dbo].[tblEmployee]([DateOfBirth], Department)

-- Drops the clustered index (if it exists with that name)
drop index idx_tblEmployee on [dbo].[tblEmployee]

-- Testing query again with index
select * from [dbo].[tblEmployee2] where [EmployeeNumber] = 127
select * from [dbo].[tblEmployee2]

-- Range query can benefit from the non-clustered index
select DateOfBirth, Department
from [dbo].[tblEmployee]
where DateOfBirth >= '1992-01-01' and DateOfBirth < '1993-01-01'

-- Index behavior:
-- seek = uses index efficiently
-- scan = reads full table when index not useful

-- ===============================
-- Unique Constraint (also creates a unique index)
-- ===============================
alter table [dbo].[tblDepartment]
add constraint unq_tblDepartment UNIQUE(Department)

-- ===============================
-- Filtered Indexes
-- ===============================

-- Index only rows where EmployeeNumber < 139 (filtered index)
CREATE NONCLUSTERED INDEX idx_tblEmployee_Employee  
    ON dbo.tblEmployee(EmployeeNumber) 
    WHERE EmployeeNumber < 139;

-- Index on EmployeeNumber including EmployeeFirstName in leaf level (INCLUDE = covering index)
CREATE NONCLUSTERED INDEX idx_tblEmployee_Employee  
    ON dbo.tblEmployee(EmployeeNumber) 
    INCLUDE (EmployeeFirstName);

-- Drops the filtered index
DROP INDEX idx_tblEmployee_Employee ON dbo.tblEmployee

-- ===============================
-- Query Testing with Client Statistics (Index usage insights)
-- ===============================

-- Full table scan
select *
from [dbo].[tblEmployee] as E

-- Should perform index seek if proper index exists
select *
from [dbo].[tblEmployee] as E
where E.EmployeeNumber = 134 

-- Still a Table Scan if no suitable index or query can't leverage one
