-- ============================================
-- SQL Script for Learning Subqueries and Joins
-- ============================================

-- (Previous sections are assumed above...)

-- ============================================
-- WITH Statement
-- ============================================

-- Use of Common Table Expression (CTE) with RANK() window function to rank employees within departments
with tblWithRanking as (
    select D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName,
           rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
    from tblDepartment as D 
    join tblEmployee as E on D.Department = E.Department
)
select * from tblWithRanking 
where TheRank <= 5
order by Department, EmployeeNumber;

-- Using multiple CTEs to combine ranking and transactions from 2014
with tblWithRanking as (
    select D.Department, EmployeeNumber, EmployeeFirstName, EmployeeLastName,
           rank() over(partition by D.Department order by E.EmployeeNumber) as TheRank
    from tblDepartment as D 
    join tblEmployee as E on D.Department = E.Department
),
Transaction2014 as (
    select * from tblTransaction where DateOfTransaction < '2015-01-01'
)
select * from tblWithRanking 
left join Transaction2014 
on tblWithRanking.EmployeeNumber = Transaction2014.EmployeeNumber
where TheRank <= 5
order by Department, tblWithRanking.EmployeeNumber;

-- ============================================
-- Generating a List of NUmbers
-- ============================================

-- Identify employees who have never had a transaction (anti-join pattern)
select E.EmployeeNumber 
from tblEmployee as E 
left join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where T.EmployeeNumber IS NULL
order by E.EmployeeNumber;

-- get a sequence of numbers up to the max EmployeeNumber using row_number and TOP
with Numbers as (
    select top (select max(EmployeeNumber) from tblTransaction) 
           row_number() over(order by (select null)) as RowNumber
    from tblTransaction as U
)
-- Find which employee numbers are missing in the transaction table
select U.RowNumber 
from Numbers as U
left join tblTransaction as T
on U.RowNumber = T.EmployeeNumber
where T.EmployeeNumber is null
order by U.RowNumber;

-- get set of row numbers using a system table cross join
select row_number() over(order by(select null)) 
from sys.objects O 
cross join sys.objects P;

-- ============================================
-- Grouping Numbers
-- ============================================

-- make a sequence of employee numbers up to the max used
with Numbers as (
    select top (select max(EmployeeNumber) from tblTransaction) 
           row_number() over(order by (select null)) as RowNumber
    from tblTransaction as U
),

-- filter for transactions in 2014 only
Transactions2014 as (
    select * 
    from tblTransaction 
    where DateOfTransaction >= '2014-01-01' and DateOfTransaction < '2015-01-01'
),

-- Identify gaps (employees with no transaction in 2014)
tblGap as (
    select U.RowNumber, 
           RowNumber - lag(RowNumber) over(order by RowNumber) as PreviousRowNumber, 
           lead(RowNumber) over(order by RowNumber) - RowNumber as NextRowNumber,
           case 
               when RowNumber - lag(RowNumber) over(order by RowNumber) = 1 then 0 
               else 1 
           end as GroupGap
    from Numbers as U
    left join Transactions2014 as T
    on U.RowNumber = T.EmployeeNumber
    where T.EmployeeNumber is null
),

-- Group consecutive gaps together using SUM() window function
tblGroup as (
    select *, 
           sum(GroupGap) over (order by RowNumber) as TheGroup
    from tblGap
)

-- Return grouped ranges of missing employee numbers
select 
    min(RowNumber) as StartingEmployeeNumber, 
    max(RowNumber) as EndingEmployeeNumber,
    max(RowNumber) - min(RowNumber) + 1 as NumberEmployees
from tblGroup
group by TheGroup
order by TheGroup;
