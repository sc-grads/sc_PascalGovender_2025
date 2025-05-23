-- ============================================
-- XQuery value() Method
-- ============================================
-- Extracts a single value from an XML variable using XPath
DECLARE @x XML;
SET @x =
'<Shopping ShopperName="Phillip Burton">
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

-- Get first item's @Cost attribute
SELECT @x.value('(/Shopping/ShoppingTrip/Item/@Cost)[1]', 'varchar(50)');


-- ============================================
-- XQuery modify() Method
-- ============================================
-- Used to alter XML content directly in variables or columns

-- Replace value in XML
SET @x.modify('replace value of (/Shopping/ShoppingTrip[1]/Item[3]/@Cost)[1]
               with "6.0"');
SELECT @x;

-- Insert new XML node into second ShoppingTrip
SET @x.modify('insert <Item Cost="5">New Food</Item>
               into (/Shopping/ShoppingTrip)[2]');
SELECT @x;


-- ============================================
-- XQuery query() Method – FLWOR Expression #1
-- ============================================
-- Loop over all <Item> nodes and return elements or values

-- Return each <Item> node
SELECT @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip/Item
                 return $ValueRetrieved');

-- Return string values of items
SELECT @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip/Item
                 return string($ValueRetrieved)');

-- Return first trip's items separated with semicolons
SELECT @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip[1]/Item
                 return concat(string($ValueRetrieved), ";")');


-- ============================================
-- XQuery query() Method – FLWOR Expression #2
-- ============================================
-- Uses LET, WHERE, ORDER BY to filter and order XML data

SELECT @x.query('for $ValueRetrieved in /Shopping/ShoppingTrip[1]/Item
                 let $CostVariable := $ValueRetrieved/@Cost
                 where $CostVariable >= 4
                 order by $CostVariable
                 return concat(string($ValueRetrieved), ";")');


-- ============================================
-- .nodes() Method (Shredding XML Variable)
-- ============================================
-- Extracts rows from XML as a relational result set

SELECT tbl.col.value('.', 'varchar(50)') AS Item,
       tbl.col.value('@Cost','varchar(50)') AS Cost
INTO tblTemp
FROM @x.nodes('/Shopping/ShoppingTrip/Item') AS tbl(col);

-- Review shredded data
SELECT * FROM tblTemp;

-- Cleanup
DROP TABLE tblTemp;


-- ============================================
-- .nodes() Method (Shredding XML in a Table)
-- ============================================
-- Demonstrates shredding XML data stored in a table column

DECLARE @x1 XML, @x2 XML;

SET @x1 = '<Shopping ShopperName="Phillip Burton">
<ShoppingTrip ShoppingTripID="L1">
  <Item Cost="5">Bananas</Item>
  <Item Cost="4">Apples</Item>
  <Item Cost="3">Cherries</Item>
</ShoppingTrip></Shopping>';

SET @x2 = '<Shopping ShopperName="Phillip Burton">
<ShoppingTrip ShoppingTripID="L2">
  <Item>Emeralds</Item>
  <Item>Diamonds</Item>
  <Item>Furniture</Item>
</ShoppingTrip></Shopping>';

-- Temporary table for XML data
DROP TABLE IF EXISTS #tblXML;
CREATE TABLE #tblXML (
    pkXML INT PRIMARY KEY,
    xmlCol XML
);

-- Insert XML rows
INSERT INTO #tblXML(pkXML, xmlCol) VALUES (1, @x1), (2, @x2);

-- Review table content
SELECT * FROM #tblXML;

-- Shred XML from table and extract @Cost attribute
SELECT tbl.col.value('@Cost','varchar(50)') AS Cost
FROM #tblXML
CROSS APPLY xmlCol.nodes('/Shopping/ShoppingTrip/Item') AS tbl(col);
