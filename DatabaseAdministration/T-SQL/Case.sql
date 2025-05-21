-- ============================================================
-- CASE - Conditional
-- ============================================================

declare @myOption as varchar(10) = 'Option C'

select case 
           when @myOption = 'Option A' then 'First option'
           when @myOption = 'Option B' then 'Second option'
           -- else 'No Option' -- No ELSE specified, so NULL will be returned if false
       END as MyOptions
go

-- Simple CASE (single variable/value)
declare @myOption as varchar(10) = 'Option A'

select case @myOption 
           when 'Option A' then 'First option'
           when 'Option B' then 'Second option' 
           else 'No Option' 
       END as MyOptions
go

-- CASE inside SELECT
SELECT 
      case 
          when left(EmployeeGovernmentID,1) = 'A' then 'Letter A'
          when EmployeeNumber < 200 then 'Less than 200'
          else 'Neither letter' 
      END + '.' as myCol
FROM tblEmployee
