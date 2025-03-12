--HAVING STATEMENTS--


SELECT * FROM Production.Product

SELECT
    Color,
    count(*) AS Countofproduct
FROM Production.Product
WHERE Color = 'yellow'
GROUP BY
    Color


    SELECT
        Color,
        count(*) AS Countofproduct
    FROM Production.Product
    GROUP BY Color
    HAVING Color = 'yellow'

    SELECT
        Color,
        Size,
        count(*) AS Countofproduct
    FROM Production.Product
    GROUP BY Color, Size
    HAVING Size >= '44'
