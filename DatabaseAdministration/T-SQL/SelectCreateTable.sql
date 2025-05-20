select Department as NumberOfDepartments
---into tblDepartment2
from
(select Department, count(*) as NumberPerDepartment
from tblEmployee
GROUP BY Department) as newTable

---distinct does similar to the above derived
select distinct Department, convert(varchar(20), N'') as DepartmentHead
into tblDepartment
from tblEmployee

drop table tblDepartment

select * from tblDepartment

alter table tblDepartment
alter column DepartmentHead varchar(30) null

