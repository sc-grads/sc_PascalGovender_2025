-- ============================================
-- Synonyms
-- Synonyms simplify querying by creating an alternate 
-- name for objects like tables, views, procedures—even across servers.
-- ============================================

-- Create a synonym as an alias for tblEmployee
CREATE SYNONYM EmployeeTable
FOR tblEmployee;
GO

-- Use the synonym just like the original table
SELECT * FROM EmployeeTable;

-- Create a synonym for a different table
CREATE SYNONYM DateTable
FOR tblDate;
GO

SELECT * FROM DateTable;

-- Create a synonym for a remote table located on a different server/database
CREATE SYNONYM RemoteTable
FOR OVERTHERE.70-461remote.dbo.tblRemote;
GO

-- Query the remote table using the synonym
SELECT * FROM RemoteTable;
