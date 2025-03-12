SELECT * FROM salesstaff

-------Truncate statment syntax (doesn't change) ---------

TRUNCATE TABLE salesstaff

------Create test table-----------

CREATE TABLE employeenew (
    id INT IDENTITY (1, 1) NOT NULL,
    employeename NVARCHAR(50) NOT NULL
)

INSERT INTO employeenew
(employeename)
VALUES ('Jack'), ('Jill'), ('John')

--------------------

DELETE FROM employeenew

--------------------

TRUNCATE TABLE employeenew
