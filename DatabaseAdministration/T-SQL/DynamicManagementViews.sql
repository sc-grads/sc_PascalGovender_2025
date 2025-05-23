-- ============================
-- Index Usage Statistics (sys.dm_db_index_usage_stats)
-- ============================
-- Shows how indexes are being used (seeks, scans, lookups, updates)
SELECT 
    DB_NAME(database_id) AS [Database Name],
    OBJECT_NAME(ddius.object_id) AS [Table Name],
    i.name AS [Index Name],
    ddius.*
FROM sys.dm_db_index_usage_stats AS ddius
JOIN sys.indexes AS i 
    ON ddius.object_id = i.object_id 
   AND ddius.index_id = i.index_id
WHERE ddius.database_id = DB_ID(); -- Current DB

-- ====================================
-- Simulate Missing Index Scenario
-- ====================================
-- Create a large table to simulate missing index detection
SELECT T.*
INTO dbo.tblTransactionBigger
FROM [dbo].[tblTransaction] AS T
CROSS JOIN [dbo].[tblTransaction] AS T2;

-- Query that can trigger missing index detection
SELECT * 
FROM dbo.tblTransactionBigger
WHERE [EmployeeNumber] = 127;

-- ====================================
-- View Missing Index Suggestions
-- ====================================
-- Basic missing index details
SELECT * 
FROM sys.dm_db_missing_index_details;

-- Detailed missing index info with column usage
SELECT 
    mig.*,
    mid.statement AS table_name,
    mic.column_id,
    mic.column_name,
    mic.column_usage
FROM sys.dm_db_missing_index_details AS mid
CROSS APPLY sys.dm_db_missing_index_columns(mid.index_handle) AS mic
INNER JOIN sys.dm_db_missing_index_groups AS mig 
        ON mig.index_handle = mid.index_handle
WHERE mid.database_id = DB_ID()
ORDER BY mic.column_id;

-- ============================
-- Index Health & Fragmentation
-- ============================
-- Physical stats: page count, fragmentation, etc.
SELECT * 
FROM sys.dm_db_index_physical_stats  
(
    DB_ID(N'70-461'),              -- Replace with actual DB name if needed
    OBJECT_ID(N'dbo.tblEmployee'), -- Replace with actual table name
    NULL, NULL, 'DETAILED'
);

DROP TABLE dbo.tblTransactionBigger;
