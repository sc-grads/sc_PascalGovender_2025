-- ============================================================
-- ISNULL and COALESCE
-- ============================================================

select * from tblEmployee where EmployeeMiddleName is null
GO

-- ISNULL: Returns the first non-null value
declare @myOption as varchar(10) = 'Option B'
select isnull(@myOption, 'No Option') as MyOptions
GO

-- COALESCE: Returns the first non-null value from a list
declare @myFirstOption as varchar(10) --= 'Option A'
declare @mySecondOption as varchar(10) --= 'Option B'
select coalesce(@myFirstOption, @mySecondOption, 'No option') as MyOptions
GO

--
select isnull('ABC',1) as MyAnswer         -- Returns 'ABC'
select coalesce('ABC',1) as MyOtherAnswer  -- Returns 'ABC'
GO

-- Returns null if all null
select isnull(null,null) as MyAnswer
select coalesce(null,null) as MyOtherAnswer
GO

--
create table tblExample
(myOption nvarchar(10) null)
GO

insert into tblExample (myOption)
values ('Option A')

-- COALESCE in SELECT and create a new table
select coalesce(myOption, 'No option') as MyOptions
into tblIsCoalesce
from tblExample 

-- NULL handling
select case when myOption is not null then myOption else 'No option' end as myOptions 
from tblExample
GO

-- ISNULL in SELECT and create a new table
select isnull(myOption, 'No option') as MyOptions
into tblIsNull
from tblExample 
GO

-- Clean up: Drop sample tables
drop table tblExample
drop table tblIsCoalesce
drop table tblIsNull
