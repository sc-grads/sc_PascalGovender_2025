--simple select queries--

SELECT * FROM Person.Address;

SELECT
    Addressid,
    City,
    Modifieddate
FROM Person.Address;

SELECT
    City,
    Addressid,
    Modifieddate
FROM Person.Address;

SELECT TOP 10 * FROM Person.Address;
