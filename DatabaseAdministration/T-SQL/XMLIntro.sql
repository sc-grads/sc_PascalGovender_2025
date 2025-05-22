-- ============================================
-- Introducing XML in SQL Server
-- ============================================
-- Declare and set a variable of XML type
-- Useful for working with semi-structured data directly in SQL
DECLARE @x XML;
SET @x = 
'<Shopping ShopperName="Phillip Burton" Weather="Nice">
    <ShoppingTrip ShoppingTripID="L1">
        <Item Cost="5">Bananas</Item>
        <Item Cost="4">Apples</Item>
        <Item Cost="3">Cherries</Item>
    </ShoppingTrip>
    <ShoppingTrip ShoppingTripID="L2">
        <Item>Emeralds</Item>
        <Item>Diamonds</Item>
        <Item>Furniture</Item>
    </ShoppingTrip>
</Shopping>';

-- Output the XML
SELECT @x;

-- table altered to include an xml type column
-- Store the XML in a table column (assumes a column of type XML exists)
UPDATE dbo.tblEmployee
SET XMLOutput = @x
WHERE EmployeeNumber = 200;

-- View updated rows
SELECT * FROM dbo.tblEmployee;


-- ============================================
-- FOR XML RAW
-- ============================================
-- Each row is returned as an XML element, using the alias as the tag name
-- Simple but flat format, useful for quickly turning rows into XML
SELECT 
    E.EmployeeNumber,
    E.EmployeeFirstName,
    E.EmployeeLastName,
    E.DateOfBirth,
    T.Amount,
    T.DateOfTransaction
FROM dbo.tblEmployee AS E
LEFT JOIN dbo.tblTransaction AS T ON E.EmployeeNumber = T.EmployeeNumber
WHERE E.EmployeeNumber BETWEEN 200 AND 202
FOR XML RAW('MyRow'), ELEMENTS;


-- ============================================
-- FOR XML AUTO
-- ============================================
-- Produces nested XML based on the table structure
-- Table aliases become element names
SELECT 
    E.EmployeeNumber,
    E.EmployeeFirstName,
    E.EmployeeLastName,
    E.DateOfBirth,
    T.Amount,
    T.DateOfTransaction
FROM dbo.tblEmployee AS E
LEFT JOIN dbo.tblTransaction AS T ON E.EmployeeNumber = T.EmployeeNumber
WHERE E.EmployeeNumber BETWEEN 200 AND 202
FOR XML AUTO, ELEMENTS;


-- ============================================
-- FOR XML PATH
-- ============================================
-- Allows full customization of XML structure
-- Use @ for attributes, nested queries for child elements
SELECT 
    E.EmployeeFirstName AS '@EmployeeFirstName',
    E.EmployeeLastName AS '@EmployeeLastName',
    E.EmployeeNumber,
    E.DateOfBirth,
    (
        SELECT T.Amount AS 'Amount'
        FROM dbo.tblTransaction AS T
        WHERE T.EmployeeNumber = E.EmployeeNumber
        FOR XML PATH(''), TYPE
    ) AS TransactionElement
FROM dbo.tblEmployee AS E
LEFT JOIN dbo.tblTransaction AS T ON E.EmployeeNumber = T.EmployeeNumber
WHERE E.EmployeeNumber BETWEEN 200 AND 202
FOR XML PATH('Employees'), ROOT('MyXML');


-- ============================================
-- FOR XML EXPLICIT
-- ============================================
-- Most complex XML mode
-- Allows exact control over tag hierarchy and nesting using Tag and Parent values
-- Must manually UNION anchor and child rows
SELECT 
    1 AS Tag,
    NULL AS Parent,
    E.EmployeeFirstName AS [Elements!1!EmployeeFirstName],
    E.EmployeeLastName AS [Elements!1!EmployeeLastName],
    E.EmployeeNumber AS [Elements!1!EmployeeNumber],
    E.DateOfBirth AS [Elements!1!DateOfBirth],
    NULL AS [Elements!2!Amount],
    NULL AS [Elements!2!DateOfTransaction]
FROM dbo.tblEmployee AS E
WHERE E.EmployeeNumber BETWEEN 200 AND 202

UNION ALL

SELECT 
    2 AS Tag,
    1 AS Parent,
    NULL,
    NULL,
    T.EmployeeNumber,
    NULL,
    T.Amount,
    T.DateOfTransaction
FROM dbo.tblTransaction AS T
INNER JOIN dbo.tblEmployee AS E ON T.EmployeeNumber = E.EmployeeNumber
WHERE T.EmployeeNumber BETWEEN 200 AND 202
ORDER BY EmployeeNumber, [Elements!2!Amount]
FOR XML EXPLICIT;
