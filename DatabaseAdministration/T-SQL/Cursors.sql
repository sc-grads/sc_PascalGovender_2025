-- When to use cursors

declare @EmployeeID int 
declare csr CURSOR FOR  -- step 1
select EmployeeNumber
from [dbo].[tblEmployee]
where EmployeeNumber between 120 and 299

open csr -- step 2
fetch next from csr into @EmployeeID -- step 3
while @@FETCH_STATUS = 0
begin
	select * from [dbo].[tblTransaction] where EmployeeNumber = @EmployeeID
	fetch next from csr into @EmployeeID
end
close csr -- step 4
deallocate csr
