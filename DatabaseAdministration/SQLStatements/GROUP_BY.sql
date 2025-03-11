--GROUP BY statements--

SELECT * FROM Person.address WHERE postalcode = '98011'


SELECT count(*) FROM Person.address WHERE postalcode = '98011'


SELECT count(*),postalcode FROM Person.address GROUP BY PostalCode

SELECT count(*) as NoOfAddresses,postalcode FROM Person.address GROUP BY PostalCode --


--group by with order by combo--

SELECT count(*) as NoOfAddresses,postalcode FROM Person.address GROUP BY PostalCode ORDER BY PostalCode

SELECT count(*),City FROM Person.address GROUP BY City


--group by 2 columnns -- 
SELECT count(*),City,PostalCode FROM Person.address GROUP BY City,PostalCode