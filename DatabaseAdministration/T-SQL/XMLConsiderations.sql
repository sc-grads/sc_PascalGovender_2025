-- ============================================
-- 41. Importing and Exporting XML using bcp Utility
-- ============================================

-- Export data from tblDepartment to a file using native format
-- Run this from Command Prompt
-- bcp [70-461].dbo.tblDepartment out mydata.out -N -T

-- Create a second table with the same schema to import into
CREATE TABLE dbo.tblDepartment2 (
    [Department] VARCHAR(19) NULL,
    [DepartmentHead] VARCHAR(19) NULL
);

-- Import data into new table using native format
-- Run this from Command Prompt:
-- bcp [70-461].dbo.tblDepartment2 in mydata.out -N -T


-- ============================================
-- 42. Bulk Insert and OPENROWSET
-- ============================================

-- Example of BULK INSERT from text file into an XML column
DROP TABLE IF EXISTS #tblXML;
GO
CREATE TABLE #tblXML(XmlCol XML);
GO

-- Import XML as plain text (line-by-line XML fragments)
-- Adjust path as needed
BULK INSERT #tblXML FROM 'C:\scGradsGithub\DatabaseAdministration\T-SQL\SampleDataBulkInsert.txt';
SELECT * FROM #tblXML;

-- Cleanup
DROP TABLE IF EXISTS #tblXML;
GO
CREATE TABLE #tblXML(IntCol INT, XmlCol XML);
GO

-- Import entire file as SINGLE_BLOB using OPENROWSET
-- Use this for full well-formed XML documents
INSERT INTO #tblXML(XmlCol)
SELECT * FROM OPENROWSET(BULK 'C:\scGradsGithub\DatabaseAdministration\T-SQL\SampleDataOpenRowset.txt', SINGLE_BLOB) AS x;

SELECT * FROM #tblXML;


-- ============================================
-- 43. XML Schema
-- ============================================

-- Include XMLSCHEMA in output to describe the XML structure
SELECT E.EmployeeNumber, E.EmployeeFirstName, E.EmployeeLastName,
       T.Amount, T.DateOfTransaction
FROM [dbo].[tblEmployee] AS E
LEFT JOIN [dbo].[tblTransaction] AS T
    ON E.EmployeeNumber = T.EmployeeNumber
WHERE E.EmployeeNumber BETWEEN 200 AND 202
FOR XML RAW, XMLSCHEMA;

-- Note: Useful XML Schema Data Types
-- i4 or int         → Integer
-- boolean           → Logical true/false (0 or 1)
-- dateTime.iso8601 → ISO 8601 datetime format
-- double            → Floating point
-- string            → Text data
-- nil               → Null support in XML


-- ============================================
-- 46. XML Indexes
-- ============================================

-- XML indexes enhance query performance over XML columns

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
  <Item>Furniture<Color></Color></Item>
</ShoppingTrip></Shopping>';

-- Create table to store XML data
DROP TABLE IF EXISTS #tblXML;
CREATE TABLE #tblXML (
    pkXML INT PRIMARY KEY,
    xmlCol XML
);

-- Insert sample XML rows
INSERT INTO #tblXML(pkXML, xmlCol) VALUES (1, @x1), (2, @x2);

-- Create a primary XML index (required for secondary indexes)
CREATE PRIMARY XML INDEX pk_tblXML ON #tblXML(xmlCol);

-- Create additional secondary indexes for optimization
CREATE XML INDEX secpk_tblXML_Path
    ON #tblXML(xmlCol)
    USING XML INDEX pk_tblXML FOR PATH;

CREATE XML INDEX secpk_tblXML_Value
    ON #tblXML(xmlCol)
    USING XML INDEX pk_tblXML FOR VALUE;

CREATE XML INDEX secpk_tblXML_Property
    ON #tblXML(xmlCol)
    USING XML INDEX pk_tblXML FOR PROPERTY;
