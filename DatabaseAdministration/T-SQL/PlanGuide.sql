-- =====================================================
-- Plan Guides
-- Large tables, even if searching for single value it will scan and not seek
-- with searches. Hence the use of with Recompile to reset the plan
-- which is set up from the initial search
-- =====================================================
-- Create a larger table by duplicating and expanding tblTransaction
select *
into dbo.tblTransactionBig
from [dbo].[tblTransaction]

insert into dbo.tblTransactionBig ([Amount], [DateOfTransaction], [EmployeeNumber])
select T1.Amount, T2.DateOfTransaction, 1 as EmployeeNumber
from [dbo].[tblTransaction] as T1
cross join (select * from [dbo].[tblTransaction] where EmployeeNumber < 200) as T2
-- This creates a large number of rows where EmployeeNumber is always 1

-- Add a nonclustered index to improve query performance for filtering on EmployeeNumber
create nonclustered index idx_tbltblTransactionBig on dbo.tblTransactionBig(EmployeeNumber)

-- Create a stored procedure to query from the big transaction table
-- WITH RECOMPILE ensures a new execution plan is generated for each run
-- Useful when parameter values vary significantly (parameter sniffing issues)
create proc procTransactionBig(@EmployeeNumber as int) WITH RECOMPILE
as
select *
from tblTransactionBig as T
left join tblEmployee as E
on T.EmployeeNumber = E.EmployeeNumber
where T.EmployeeNumber = @EmployeeNumber

-- Execute the stored procedure with different parameters
-- Different parameter values may lead to different execution plans
exec procTransactionBig 1       -- likely returns many rows
exec procTransactionBig 132     -- likely returns fewer rows
