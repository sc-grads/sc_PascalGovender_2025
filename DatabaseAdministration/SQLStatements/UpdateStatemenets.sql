--UPDATE statements--

 SELECT * FROM sales.vSalesPerson

 ----------------------------

DROP TABLE salesstaff

 -------------------------------------------------------
SELECT firstname + ' ' + Lastname AS Fullname,
[TerritoryName],
[TerritoryGroup],
[SalesQuota],
[SalesYTD],[SalesLastYear]
 into salesstaff
 FROM sales.vSalesPerson

---------------------------------------------------------------

SELECT * FROM salesstaff

--------------------------------------------

UPDATE salesstaff SET [SalesQuota] = 50000 

----------------------------------------------

UPDATE salesstaff SET [SalesQuota] = SalesQuota + 1550000 

------------------------------

UPDATE salesstaff SET [SalesQuota] = SalesQuota + 1550000 , SalesYTD =  SalesYTD - 500,SalesLastYear = SalesLastYear * 1.5

--------------------------

UPDATE salesstaff SET [TerritoryName] = 'UK' WHERE [TerritoryName] = 'United Kingdom'


--------------------------------------------------------

UPDATE salesstaff SET [TerritoryName] = 'UK' WHERE [TerritoryGroup] IS NULL AND fullname = 'syed Abbas'

--------------------------------------------------

UPDATE salesstaff SET [TerritoryName] = 'UK', TerritoryGroup = 'Europe' WHERE [TerritoryGroup] IS NULL AND fullname = 'syed Abbas'

----------------------------------

UPDATE salesstaff SET SalesQuota = sp.salesquota
FROM salesstaff ss
INNER JOIN sales.vSalesPerson sp
ON ss.Fullname = (sp.firstname + ' ' + sp.lastname)
