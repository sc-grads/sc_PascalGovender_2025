--HAVING STATEMENTS--


SELECT * FROM Production.product

SELECT count(*) countofproduct,Color FROM Production.product WHERE color = 'yellow' GROUP BY Color


SELECT count(*) countofproduct,Color FROM Production.product GROUP BY Color HAVING Color = 'yellow'

SELECT count(*) countofproduct,Color,Size FROM Production.product GROUP BY Color,size HAVING Size >= '44'