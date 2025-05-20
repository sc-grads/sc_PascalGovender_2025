select * from tblEmployee where EmployeeNumber = 194
select * from tblTransaction where EmployeeNumber = 3
select * from tblTransaction where EmployeeNumber = 194

begin tran
-- select * from tblTransaction where EmployeeNumber = 194

update tblTransaction
set EmployeeNumber = 194
output inserted.EmployeeNumber, deleted.EmployeeNumber  ---shows what's being changed (temp tables)
from tblTransaction
where EmployeeNumber in (3, 5, 7, 9) ---updates those specific records in the list.
---{where field between 1 and 10 conditional for where to look}

insert into tblTransaction
go

delete tblTransaction
from tblTransaction
where EmployeeNumber = 3

-- select * from tblTransaction where EmployeeNumber = 194
rollback tran
