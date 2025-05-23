-- ============================================
-- Working with JSON in SQL Server
-- ============================================

-- Declare a JSON string (note: NVARCHAR is used to support Unicode)
DECLARE @json NVARCHAR(4000);
SET @json = '
{
  "name": "Phillip",
  "ShoppingTrip": {
    "ShoppingTripItem": "L1",
    "Items": [
      { "Item": "Bananas", "Cost": 5 },
      { "Item": "Apples", "Cost": 4 },
      { "Item": "Cherries", "Cost": 3 }
    ]
  }
}';

-- ============================================
-- Basic JSON Validation and Extraction
-- ============================================

-- Check if the string is a valid JSON
SELECT ISJSON(@json) AS IsValidJSON;

-- Extract a scalar value from JSON using json_value (case-sensitive by default)
SELECT JSON_VALUE(@json, '$.name') AS ExtractedName;

-- Try to extract full JSON structure using json_query
SELECT JSON_QUERY(@json, '$') AS FullJSON;

-- Extract a nested value: second item (index starts from 0)
SELECT JSON_VALUE(@json, 'strict $.ShoppingTrip.Items[1].Item') AS SecondItem;

-- ============================================
-- JSON Modification (json_modify)
-- ============================================

-- Modify a nested value: rename "Apples" to "Big Bananas"
SELECT JSON_MODIFY(@json, 'strict $.ShoppingTrip.Items[1].Item', 'Big Bananas') AS ModifiedItem;

-- Replace full second item object
SELECT JSON_MODIFY(@json, 'strict $.ShoppingTrip.Items[1]', '{"Item":"Big Apples", "Cost":1}') AS ModifiedObject;

-- Alternative way using json_query
SELECT JSON_MODIFY(@json, 'strict $.ShoppingTrip.Items[1]', JSON_QUERY('{"Item":"Big Apples", "Cost":1}')) AS ModifiedWithQuery;

-- Add a new property (Date)
SELECT JSON_MODIFY(@json, '$.Date', '2022-01-01') AS WithDateAdded;

-- ============================================
-- Parsing JSON using OPENJSON
-- ============================================

-- Parse top-level keys and values
SELECT * FROM OPENJSON(@json);

-- Parse nested array (Items list)
SELECT * FROM OPENJSON(@json, '$.ShoppingTrip.Items');

-- Parse nested array with schema (explicit columns)
SELECT * 
FROM OPENJSON(@json, '$.ShoppingTrip.Items')
WITH (
    Item VARCHAR(10),
    Cost INT
);

-- ============================================
-- Formatting SQL Query Result as JSON
-- ============================================

-- Return query results as JSON using FOR JSON PATH
SELECT 'Bananas' AS Item, 5 AS Cost
UNION
SELECT 'Apples', 4
UNION
SELECT 'Cherries', 3
FOR JSON PATH, ROOT('MyShoppingTrip');
