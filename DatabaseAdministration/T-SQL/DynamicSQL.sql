-- ============================================
-- Dynamic Queries
-- ============================================

-- Simple static query for reference
select * from tblEmployee where EmployeeNumber = 129;
go

-- Declare a variable holding a SQL command as text
declare @command as varchar(255);

-- Assign a simple SELECT statement as a string
set @command = 'select * from tblEmployee where EmployeeNumber = 129;';

-- Change the command to select from a different table
set @command = 'Select * from tblTransaction';

-- Execute the command stored in the variable
execute (@command);
go

-- Dynamic query construction by concatenation (vulnerable to SQL injection!)
declare @command as varchar(255), @param as varchar(50);

-- Base query string
set @command = 'select * from tblEmployee where EmployeeNumber = ';

-- Parameter value as string
set @param ='129';

-- Unsafe execution by concatenating parameter directly into query string
execute (@command + @param); -- WARNING: This approach is vulnerable to SQL Injection!
go

-- Safer dynamic SQL using sp_executesql with parameterization
declare @command as nvarchar(255), @param as nvarchar(50);

-- Query string with parameter placeholder
set @command = N'select * from tblEmployee where EmployeeNumber = @ProductID';

-- Parameter value as Unicode string
set @param = N'129';

-- Execute parameterized dynamic query safely
execute sys.sp_executesql 
    @statement = @command, 
    @params = N'@ProductID int', 
    @ProductID = @param;
