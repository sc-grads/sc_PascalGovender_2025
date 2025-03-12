SELECT * FROM salesstaff

-------Truncate statment syntax (doesn't change) ---------

TRUNCATE  TABLE salesstaff

------Create test table-----------

CREATE TABLE EmployeeNew (
id INT IDENTITY (1,1) NOT NULL ,
employeeName NVARCHAR(50) NOT NULL 
)

INSERT INTO EmployeeNew
(employeeName)
VALUES ('Jack'),('Jill'),('John')

--------------------

DELETE FROM EmployeeNew

--------------------

TRUNCATE TABLE  EmployeeNew