-- ============================================================
-- UNION and UNION ALL
-- UNION removes duplicates; UNION ALL keeps them
-- ============================================================

select * from inserted
union  -- Combines results and removes duplicates
select * from deleted
--^ can be used to get the duplicates out


select convert(char(5),'hi') as Greeting
union all
select convert(char(11),'hello there') as GreetingNow
union all
select convert(char(11),'bonjour')
union --all
select convert(char(11),'hi')  -- Duplicate of first row, but kept due to UNION ALL

-- UNION with implicit type promotion (tinyint → bigint)
with cte as(
select convert(tinyint, 45) as Mycolumn
union
select convert(bigint, 456)
)
select MyColumn into tblTemp from cte
-- UNION across incompatible types will fail unless conversion is possible
select 4
union
select 'hi there'  -- fail conversion error

-- ============================================================
-- EXCEPT and INTERSECT
-- EXCEPT returns rows in first query but not second
-- INTERSECT returns only common rows between both
-- ============================================================

select *, Row_Number() over(order by (select null)) % 3 as ShouldIDelete
--into tblTransactionNew
from tblTransaction

delete from tblTransactionNew
where ShouldIDelete = 1  -- Deletes 1/3rd of rows

update tblTransactionNew
set DateOfTransaction = dateadd(day,1,DateOfTransaction)
Where ShouldIDelete = 2  

alter table tblTransactionNew
drop column ShouldIDelete

-- INTERSECT returns rows that exist in both tables (identical in all columns)
-- Try EXCEPT to see what rows differ between the sets
select * from tblTransaction -- 2486 rows
intersect--except--union--union all
select * from tblTransactionNew -- 1657 rows, 829 changed rows, 828 unchanged
order by EmployeeNumber
