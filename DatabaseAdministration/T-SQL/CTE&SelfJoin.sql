-- ============================================
-- Self Joins
-- ============================================

-- Add a Manager column to simulate a self-referencing relationship
begin tran
alter table tblEmployee
add Manager int;
go

-- Assign a manager based on employee number pattern (for demo purposes)
update tblEmployee
set Manager = ((EmployeeNumber - 123) / 10) + 123
where EmployeeNumber > 123;

-- Perform a self join: each employee joins to their manager via the Manager column
select 
    E.EmployeeNumber, 
    E.EmployeeFirstName, 
    E.EmployeeLastName,
    M.EmployeeNumber as ManagerNumber, 
    M.EmployeeFirstName as ManagerFirstName, 
    M.EmployeeLastName as ManagerLastName
from tblEmployee as E
left join tblEmployee as M
    on E.Manager = M.EmployeeNumber;

rollback tran;

-- ============================================
-- Recursive CTE
-- ============================================

-- Setup the Manager field again to prepare for hierarchical query
begin tran
alter table tblEmployee
add Manager int;
go

-- Assign managers again as in the self-join above
update tblEmployee
set Manager = ((EmployeeNumber - 123) / 10) + 123
where EmployeeNumber > 123;

-- Recursive CTE to trace employee-manager hierarchy and assign levels
with myTable as (
    -- Anchor member: employees without managers (top of hierarchy)
    select 
        EmployeeNumber, 
        EmployeeFirstName, 
        EmployeeLastName, 
        0 as BossLevel
    from tblEmployee
    where Manager is null

    union all --UNION ALL!!!!

    -- Recursive member: employees who report to someone already listed
    select 
        E.EmployeeNumber, 
        E.EmployeeFirstName, 
        E.EmployeeLastName, 
        myTable.BossLevel + 1
    from tblEmployee as E
    join myTable 
        on E.Manager = myTable.EmployeeNumber
)

-- DIsplaty
select * from myTable;

rollback tran;
