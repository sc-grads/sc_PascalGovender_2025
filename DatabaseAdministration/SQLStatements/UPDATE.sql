--UPDATE statements--

SELECT * FROM sales.vsalesperson

----------------------------

DROP TABLE salesstaff

-------------------------------------------------------
SELECT
    [TerritoryName],
    [TerritoryGroup],
    [SalesQuota],
    [SalesYTD],
    [SalesLastYear],
    firstname + ' ' + lastname AS fullname
INTO salesstaff
FROM sales.vsalesperson

---------------------------------------------------------------

SELECT * FROM salesstaff

--------------------------------------------

UPDATE salesstaff SET [SalesQuota] = 50000

----------------------------------------------

UPDATE salesstaff SET [SalesQuota] = salesquota + 1550000

------------------------------

UPDATE salesstaff SET [SalesQuota] = salesquota + 1550000, salesytd = salesytd - 500, saleslastyear = saleslastyear * 1.5

--------------------------

UPDATE salesstaff SET [TerritoryName] = 'UK'
WHERE [TerritoryName] = 'United Kingdom'


--------------------------------------------------------

UPDATE salesstaff SET [TerritoryName] = 'UK'
WHERE [TerritoryGroup] IS NULL AND fullname = 'syed Abbas'

--------------------------------------------------

UPDATE salesstaff SET [TerritoryName] = 'UK', territorygroup = 'Europe'
WHERE [TerritoryGroup] IS NULL AND fullname = 'syed Abbas'

----------------------------------

UPDATE salesstaff SET salesquota = sp.salesquota
FROM salesstaff AS ss
INNER JOIN sales.vsalesperson AS sp
    ON ss.fullname = (sp.firstname + ' ' + sp.lastname)
