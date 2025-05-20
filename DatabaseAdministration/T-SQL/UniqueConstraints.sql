alter table tblEmployee
ADD CONSTRAINT unqGovernmentID UNIQUE (EmployeeGovernmentID);  ----Creates a unique indext that makes it unique (only one can exist of it)

select EmployeeGovernmentID, count(EmployeeGovernmentID) as MyCount from tblEmployee
group by EmployeeGovernmentID
having count(EmployeeGovernmentID)>1

select * from tblEmployee where EmployeeGovernmentID IN ('HN513777D', 'TX593671R')

begin tran
delete from tblEmployee
where EmployeeNumber < 3

delete top(2) from tblEmployee
where EmployeeNumber in (131, 132)

select * from tblEmployee where EmployeeGovernmentID IN ('HN513777D', 'TX593671R')

commit tran
-----------------------------------------------------------------
-----multi column set to unique
-----The constraint over multi means that as long as either columns have unique values, 
-----the others may have repetition

---------MEANING : as long as the combination of the columns are unique, it will pass
alter table tblTransaction
add constraint unqTransaction UNIQUE (Amount, DateOfTransaction, EmployeeNumber)

delete from tblTransaction
where EmployeeNumber = 131

insert into tblTransaction
VALUES (1,'2015-01-01', 131)
insert into tblTransaction
VALUES (1,'2015-01-01', 131)

alter table tblTransaction
Drop constraint unqTransaction ---dropping a constraint


-------------------------------------------------
-----------------------creating a table with constraints already

create table tblTransaction2
(Amount smallmoney not null,
DateOfTransaction smalldatetime not null,
EmployeeNumber int not null,
CONSTRAINT unqTransaction2 UNIQUE (Amount,DateOfTransaction,EmployeeNumber))

drop table tblTransaction2
