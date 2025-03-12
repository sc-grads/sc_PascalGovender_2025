DROP TABLE salesstaff

CREATE TABLE salesstaff
(
staffid int not null primary key,
firstname nvarchar(50) not null,
lastname nvarchar(50) not null,
countryregion nvarchar(50) not null
)

--DELETE AND ROLLBACK---

INSERT INTO salesstaff
SELECT [BusinessEntityID],[FirstName],[LastName],[CountryRegionName] FROM[Sales].[vSalesPerson]

-------------------------------------

DELETE salesstaff

DELETE FROM salesstaff

DELETE FROM salesstaff WHERE countryregion =  'united states'

----------------------------------------------------------------
BEGIN TRAN
DELETE FROM salesstaff WHERE countryregion =  'united states'

ROLLBACK TRAN

-----------------------------------------------------------------

BEGIN TRAN
DELETE FROM salesstaff WHERE countryregion =  'united states'

COMMIT

----------------COMPLEX DELETES------------------------------------

DELETE FROM salesstaff WHERE staffid in (select [BusinessEntityID] FROM[Sales].[vSalesPerson] WHERE SalesLastYear = 0)

-------------------------------------

DELETE salesstaff 
FROM [Sales].[vSalesPerson] sp
INNER JOIN salesstaff ss
ON sp.[BusinessEntityID] = ss.staffid
WHERE sp.saleslastyear = 0