--GROUP BY statements--

SELECT * FROM Person.Address
WHERE Postalcode = '98011'


SELECT count(*) FROM Person.Address
WHERE Postalcode = '98011'


SELECT
    Postalcode,
    count(*)
FROM Person.Address
GROUP BY
    Postalcode

    SELECT
        Postalcode,
        count(*) AS Noofaddresses
    FROM Person.Address
    GROUP BY Postalcode --


    --group by with order by combo--

    SELECT
        Postalcode,
        count(*) AS Noofaddresses
    FROM Person.Address
    GROUP BY Postalcode
    ORDER BY Postalcode

    SELECT
        City,
        count(*)
    FROM Person.Address
    GROUP BY City


    --group by 2 columnns -- 
    SELECT
        City,
        Postalcode,
        count(*)
    FROM Person.Address
    GROUP BY City, Postalcode
