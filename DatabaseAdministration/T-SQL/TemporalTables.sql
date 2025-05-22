-- =====================================================
-- Creating a Temporal Table (System-Versioned Table)
-- =====================================================

-- Create a system-versioned temporal table with history tracking
CREATE TABLE [dbo].[tblEmployeeTemporal] (
	[EmployeeNumber] [int] NOT NULL PRIMARY KEY CLUSTERED,
	[EmployeeFirstName] [varchar](50) NOT NULL,
	[EmployeeMiddleName] [varchar](50) NULL,
	[EmployeeLastName] [varchar](50) NOT NULL,
	[EmployeeGovernmentID] [char](10) NOT NULL,
	[DateOfBirth] [date] NOT NULL, [Department] [varchar](19) NULL
	, ValidFrom datetime2(2) GENERATED ALWAYS AS ROW START -- HIDDEN
	, ValidTo datetime2(2) GENERATED ALWAYS AS ROW END -- HIDDEN
	, PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.tblEmployeeHistory))
GO


-- Insert sample data
INSERT INTO [dbo].[tblEmployeeTemporal] (
	[EmployeeNumber], [EmployeeFirstName], [EmployeeMiddleName], [EmployeeLastName],
	[EmployeeGovernmentID], [DateOfBirth], [Department])
VALUES 
(123, 'Jane', NULL, 'Zwilling', 'AB123456G', '1985-01-01', 'Customer Relations'),
(124, 'Carolyn', 'Andrea', 'Zimmerman', 'AB234578H', '1975-06-01', 'Commercial'),
(125, 'Jane', NULL, 'Zabokritski', 'LUT778728T', '1977-12-09', 'Commercial'),
(126, 'Ken', 'J', 'Yukish', 'PO201903O', '1969-12-27', 'HR'),
(127, 'Terri', 'Lee', 'Yu', 'ZH206496W', '1986-11-14', 'Customer Relations'),
(128, 'Roberto', NULL, 'Young', 'EH793082D', '1967-04-05', 'Customer Relations');

-- View current data
SELECT * FROM dbo.tblEmployeeTemporal;

-- Make updates that will be recorded in the history table
UPDATE dbo.tblEmployeeTemporal SET EmployeeLastName = 'Smith' WHERE EmployeeNumber = 124;
UPDATE dbo.tblEmployeeTemporal SET EmployeeLastName = 'Albert' WHERE EmployeeNumber = 124;

-- View updated data (current rows)
SELECT * FROM dbo.tblEmployeeTemporal;

-- =====================================================
-- 49. Dropping a Temporal Table and History Table
-- =====================================================

-- Disable system versioning before dropping
ALTER TABLE dbo.tblEmployeeTemporal SET (SYSTEM_VERSIONING = OFF);

-- Drop the main and history tables
DROP TABLE dbo.tblEmployeeTemporal;
DROP TABLE dbo.tblEmployeeHistory;

-- =====================================================
-- Altering an Existing Table to Become Temporal
-- =====================================================

-- Add system-versioning columns to an existing table
ALTER TABLE dbo.tblEmployee
ADD
	ValidFrom datetime2(2) GENERATED ALWAYS AS ROW START CONSTRAINT def_ValidFrom DEFAULT SYSUTCDATETIME(),
	ValidTo datetime2(2) GENERATED ALWAYS AS ROW END CONSTRAINT def_ValidTo DEFAULT CONVERT(datetime2(2), '9999-12-31 23:59:59'),
	PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo);

-- Enable system versioning on existing table
ALTER TABLE dbo.tblEmployee
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.tblEmployeeHistory2));

-- =====================================================
-- 51. Querying System-Versioned Temporal Data
-- =====================================================

-- Query historical data as it existed at a specific point in time
SELECT * 
FROM dbo.tblEmployeeTemporal
FOR SYSTEM_TIME AS OF '2021-02-01';

-- Query data between two points in time
-- FROM = exclusive start, TO = exclusive end
-- BETWEEN = inclusive of both start and end
-- CONTAINED IN = rows fully contained in the time range

-- Examples:
-- SELECT * FROM dbo.tblEmployeeTemporal FOR SYSTEM_TIME
--     FROM '2021-01-01' TO '2021-03-01';

-- SELECT * FROM dbo.tblEmployeeTemporal FOR SYSTEM_TIME
--     BETWEEN '2021-01-01' AND '2021-03-01';

-- SELECT * FROM dbo.tblEmployeeTemporal FOR SYSTEM_TIME
--     CONTAINED IN ('2021-01-01', '2021-03-01');
