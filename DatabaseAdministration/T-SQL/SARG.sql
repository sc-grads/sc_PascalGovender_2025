-- ================================
-- Search Argumentable Queries
-- ==================================
-- SARGable query: 
-- Uses a direct comparison on a column with an index (EmployeeNumber = 134)
-- Enables index SEEK for faster performance
select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeNumber = 134

-- Same SARGable query, but on tables without indexes
-- Likely results in TABLE SCAN instead of index seek, slower performance
select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployeeNoIndex] as E
left join [dbo].[tblTransactionNoIndex] as T
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeNumber = 134

-- NOT SARGable query: 
-- Using a calculation in WHERE clause disables index usage
-- Forces SQL Server to scan all rows, degrading performance
select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeNumber / 10 = 34 -- Not SARG (expression on column)

-- SARGable query with BETWEEN: 
-- Efficient and can use index SEEK
select E.EmployeeNumber, T.Amount
from [dbo].[tblEmployee] as E
left join [dbo].[tblTransaction] as T
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeNumber between 340 and 349 -- SARGable

-- =========================================
--         HOW TO MAKE A QUERY SARGABLE
-- =========================================

-- DO: Use direct comparisons on indexed columns
-- WHERE Column = value
-- WHERE Column BETWEEN value1 AND value2
-- WHERE Column IN (value1, value2, ...)

-- AVOID: Wrapping columns in functions or expressions
-- WHERE YEAR(DateColumn) = 2022         -- Not SARGable
-- WHERE Column + 1 = 100                -- Not SARGable
-- WHERE Column / 10 = 5                 -- Not SARGable

-- INSTEAD: Rewrite to isolate the column
-- WHERE DateColumn >= '2022-01-01' AND DateColumn < '2023-01-01'
-- WHERE Column BETWEEN 99 AND 99        -- Adjust logic to avoid operations on the column

-- Use LIKE with trailing wildcard only
-- WHERE Name LIKE 'Phil%'               -- SARGable
-- ❌ WHERE Name LIKE '%lip'             -- Not SARGable

-- Avoid ISNULL(), COALESCE(), CAST(), CONVERT() on indexed columns in WHERE clause
-- These prevent index seek and cause full scans

-- Consider computed columns + persisted indexes if you must use expressions
-- e.g., add a computed column for YEAR(DateColumn) and index it
