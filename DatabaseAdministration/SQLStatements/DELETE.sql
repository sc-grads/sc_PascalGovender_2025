DROP TABLE salesstaff

CREATE TABLE salesstaff
(
    staffid int NOT NULL PRIMARY KEY,
    firstname nvarchar(50) NOT NULL,
    lastname nvarchar(50) NOT NULL,
    countryregion nvarchar(50) NOT NULL
)

--DELETE AND ROLLBACK---

INSERT INTO salesstaff
SELECT
    [BusinessEntityID],
    [FirstName],
    [LastName],
    [CountryRegionName]
FROM [Sales].[vSalesPerson]

-------------------------------------

DELETE salesstaff

DELETE FROM salesstaff

DELETE FROM salesstaff
WHERE countryregion = 'united states'

----------------------------------------------------------------
BEGIN TRAN
DELETE FROM salesstaff
WHERE countryregion = 'united states'

ROLLBACK TRAN

-----------------------------------------------------------------

BEGIN TRAN
DELETE FROM salesstaff
WHERE countryregion = 'united states'

COMMIT

----------------COMPLEX DELETES------------------------------------

DELETE FROM salesstaff
WHERE
    staffid IN (
        SELECT [BusinessEntityID] FROM [Sales].[vSalesPerson]
        WHERE saleslastyear = 0
    )

-------------------------------------

DELETE salesstaff
FROM [Sales].[vSalesPerson] AS sp
INNER JOIN salesstaff AS ss
    ON sp.[BusinessEntityID] = ss.staffid
WHERE sp.saleslastyear = 0
