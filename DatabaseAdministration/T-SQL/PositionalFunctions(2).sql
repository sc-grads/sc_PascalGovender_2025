-- =========================================
-- CUME_DIST and PERCENT_RANK
-- =-========================================
-- These functions return the relative standing of a row within a partition.
-- CUME_DIST: Cumulative distribution — shows how far a row is within the group.
-- PERCENT_RANK: Rank-based percentile — compares the rank of the row relative to others.

SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 

-- Returns cumulative distribution (row position / total rows), includes current row
CUME_DIST() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS MyCume_Dist,

-- Returns the percentile rank (starts at 0), excludes current row from calculation
PERCENT_RANK() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS MyPercent_Rank,

-- Manual calculation of CUME_DIST for comparison (row_number / total)
CAST(ROW_NUMBER() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS DECIMAL(9,5))
/ COUNT(*) OVER(PARTITION BY E.EmployeeNumber) AS CalcCume_Dist,

-- Manual calculation of PERCENT_RANK (row_number - 1) / (total - 1)
CAST(ROW_NUMBER() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) - 1 AS DECIMAL(9,5))
/ (COUNT(*) OVER(PARTITION BY E.EmployeeNumber) - 1) AS CalcPercent_Rank

FROM tblEmployee AS E 
JOIN tblAttendance AS A 
ON E.EmployeeNumber = A.EmployeeNumber

-- =========================================
-- PERCENTILE_CONT and PERCENTILE_DISC
-- =-========================================
-- These functions compute percentiles within a group.
-- PERCENTILE_CONT: Continuous percentile — interpolates between values if necessary.
-- PERCENTILE_DISC: Discrete percentile — returns the actual value at the threshold.

SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 

-- CUME_DIST and PERCENT_RANK calculated by NumberAttendance (instead of date)
CUME_DIST() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.NumberAttendance) AS MyCume_Dist,
PERCENT_RANK() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.NumberAttendance) * 100 AS MyPercent_Rank

FROM tblEmployee AS E 
JOIN tblAttendance AS A 
ON E.EmployeeNumber = A.EmployeeNumber

-- =========================================
-- PERCENTILE_CONT and PERCENTILE_DISC (Example with 40th Percentile)
-- =-========================================
-- This example shows how to get the 40th percentile attendance for each employee.
-- PERCENTILE_CONT: May return interpolated values.
-- PERCENTILE_DISC: Will return a value that actually exists in the dataset.

SELECT DISTINCT EmployeeNumber,

-- Returns the 40th percentile using interpolation (can return non-existent values)
PERCENTILE_CONT(0.4) WITHIN GROUP (ORDER BY NumberAttendance) 
OVER (PARTITION BY EmployeeNumber) AS AverageCont,

-- Returns the 40th percentile using discrete values from dataset
PERCENTILE_DISC(0.4) WITHIN GROUP (ORDER BY NumberAttendance) 
OVER (PARTITION BY EmployeeNumber) AS AverageDisc

FROM tblAttendance
