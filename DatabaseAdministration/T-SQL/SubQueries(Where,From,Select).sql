-- ============================================
-- Table Structure
-- ============================================

select * from tblDepartment;
select * from tblEmployee;
select * from tblTransaction;

-- Aggregate functions: MIN and MAX
select min(EmployeeNumber) as MinNumber, max(EmployeeNumber) as MaxNumber
from tblTransaction;

select min(EmployeeNumber) as MinNumber, max(EmployeeNumber) as MaxNumber
from tblEmployee;

-- ============================================
-- Subquery – WHERE
-- ============================================

select T.* 
from tblTransaction as T
inner join tblEmployee as E
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeLastName like 'y%'
order by T.EmployeeNumber;

-- Subquery in WHERE clause (IN): Same result using subquery instead of join
select * 
from tblTransaction as T
where EmployeeNumber in
    (select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber;

-- ============================================
-- Subquery – WHERE and NOT IN
-- ============================================

-- Get transactions for employees whose last name does NOT start with 'y'
-- Using IN with a subquery
select * 
from tblTransaction as T
where EmployeeNumber in
    (select EmployeeNumber from tblEmployee where EmployeeLastName not like 'y%')
order by EmployeeNumber; -- behaves like an INNER JOIN

-- Using NOT IN with a subquery
select * 
from tblTransaction as T
where EmployeeNumber not in
    (select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber; -- behaves like a LEFT JOIN (excludes matching rows)

-- ============================================
-- Subquery – WHERE and ANY, SOME and ALL
-- ============================================

-- SOME / ANY: Returns rows where EmployeeNumber matches ANY result from subquery
select * 
from tblTransaction as T
where EmployeeNumber = some
    (select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber;

-- <> ANY: Logical mismatch – may return unintended results
select * 
from tblTransaction as T
where EmployeeNumber <> any
    (select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber;

-- <> ALL: Returns only if EmployeeNumber is different from ALL subquery results
select * 
from tblTransaction as T
where EmployeeNumber <> all 
    (select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber;

-- <= ALL: Returns EmployeeNumbers less than or equal to the smallest result
select * 
from tblTransaction as T
where EmployeeNumber <= all
    (select EmployeeNumber from tblEmployee where EmployeeLastName like 'y%')
order by EmployeeNumber;

-- Notes:
-- ANY/SOME = OR logic
-- ALL = AND logic

-- 126 <> all(126,127,128,129)
--     → 126<>126 AND 126<>127 AND ... = FALSE
-- 126 <> any(126,127,128,129)
--     → 126<>126 OR 126<>127 OR ... = TRUE

-- ============================================
-- Subqueries in the FROM clause
-- ============================================

-- Use a subquery as a derived table in a JOIN
select * 
from tblTransaction as T
left join (
    select * from tblEmployee
    where EmployeeLastName like 'y%'
) as E
on E.EmployeeNumber = T.EmployeeNumber
order by T.EmployeeNumber;

-- Same logic, filtering moved to WHERE clause after join
select * 
from tblTransaction as T
left join tblEmployee as E
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeLastName like 'y%'
order by T.EmployeeNumber;

-- Filtering as part of the JOIN condition (safer for outer joins)
select * 
from tblTransaction as T
left join tblEmployee as E
on E.EmployeeNumber = T.EmployeeNumber
and E.EmployeeLastName like 'y%'
order by T.EmployeeNumber;

-- ============================================
-- Subquery – SELECT Clause
-- ============================================

-- Correlated subqueries for each employee: count and sum of their transactions
select *, 
       (select count(EmployeeNumber)
        from tblTransaction as T
        where T.EmployeeNumber = E.EmployeeNumber) as NumTransactions,
       (select sum(Amount)
        from tblTransaction as T
        where T.EmployeeNumber = E.EmployeeNumber) as TotalAmount
from tblEmployee as E
where E.EmployeeLastName like 'y%';

-- ============================================
-- Correlated Subquery
-- ============================================

-- EXISTS: Include only transactions where a matching employee with last name 'y%' exists
select * 
from tblTransaction as T
where exists 
    (select EmployeeNumber 
     from tblEmployee as E 
     where EmployeeLastName like 'y%' 
     and T.EmployeeNumber = E.EmployeeNumber) -- depends on the outer statement to work.
order by EmployeeNumber;

-- NOT EXISTS: Exclude transactions with matching employees whose last name starts with 'y'
select * 
from tblTransaction as T
where not exists 
    (select EmployeeNumber 
     from tblEmployee as E 
     where EmployeeLastName like 'y%' 
     and T.EmployeeNumber = E.EmployeeNumber)
order by EmployeeNumber;
