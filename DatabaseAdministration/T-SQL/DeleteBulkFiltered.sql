---- Quick option to remove values with null from a table

begin transaction

-- Initial row count in tblTransaction
select count(*) from tblTransaction

-- Delete null transactions with no matching employee
delete tblTransaction
from tblEmployee as E
right join tblTransaction as T
on E.EmployeeNumber = T.EmployeeNumber
where E.EmployeeNumber is null  -- This identifies transactions with no employee

-- Count after delete (before rollback)
select count(*) from tblTransaction

-- Roll back to undo the deletion (used for testing/previewing the effect)
rollback transaction

-- Verify that rollback restored the original row count
select count(*) from tblTransaction


---------------------------------------------------------------------------------
---- Using the filtered data used to identify the values then filter out

-- Begin another transaction
begin transaction

-- Count before deletion
select count(*) from tblTransaction

-- Delete using a derived table that filters for null transactions
delete tblTransaction
from tblTransaction
where EmployeeNumber IN
(
    select TNumber
    from (
        -- Build a derived table identifying transactions with no linked employee
        select E.EmployeeNumber as ENumber, E.EmployeeFirstName,
               E.EmployeeLastName, T.EmployeeNumber as TNumber, 
               sum(T.Amount) as TotalAmount
        from tblEmployee as E
        right join tblTransaction as T
        on E.EmployeeNumber = T.EmployeeNumber
        group by E.EmployeeNumber, T.EmployeeNumber, E.EmployeeFirstName,
                 E.EmployeeLastName
    ) as newTable
    where ENumber is null  -- Only keep transaction IDs where no matching employee exists
)

-- Check result after delete
select count(*) from tblTransaction

-- Rollback again (to preserve data)
rollback transaction

-- Final check to confirm rollback succeeded
select count(*) from tblTransaction
