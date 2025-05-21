-- =-========================================
-- ROW_NUMBER, RANK and DENSE_RANK (No Partition)
-- =-========================================
-- This section demonstrates how to assign row numbers and rankings to all records in the dataset, across the entire result set.
-- Useful for pagination, finding top-N records, or general ordering logic when you need sequence or rank.

SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
-- Assigns a unique row number to each row, ordered by Employee and Month
ROW_NUMBER() OVER(ORDER BY E.EmployeeNumber, A.AttendanceMonth) AS TheRowNumber,
-- Assigns rank, with ties getting the same rank and skipping the next rank
RANK() OVER(ORDER BY E.EmployeeNumber, A.AttendanceMonth) AS TheRank,
-- Assigns rank, with ties getting the same rank, but no gaps in ranking
DENSE_RANK() OVER(ORDER BY E.EmployeeNumber, A.AttendanceMonth) AS TheDenseRank
FROM tblEmployee AS E 
JOIN (SELECT * FROM tblAttendance UNION ALL SELECT * FROM tblAttendance) AS A 
ON E.EmployeeNumber = A.EmployeeNumber

-- =-========================================
-- ROW_NUMBER, RANK and DENSE_RANK (Partitioned by Employee)
-- =-========================================
-- This section shows the same ranking functions, but with PARTITION BY to restart the numbering for each employee.
-- Useful when ranking records within groups (e.g., per employee, per department).

SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
-- Starts row number at 1 for each employee, based on month
ROW_NUMBER() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS TheRowNumber,
-- Rank resets for each employee and respects ties
RANK() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS TheRank,
-- Dense rank also resets per employee, but no gaps in ranking
DENSE_RANK() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS TheDenseRank
FROM tblEmployee AS E 
JOIN (SELECT * FROM tblAttendance UNION ALL SELECT * FROM tblAttendance) AS A 
ON E.EmployeeNumber = A.EmployeeNumber

-- =-========================================
-- ROW_NUMBER with No ORDER BY (Arbitrary Row Order)
-- =-========================================
-- Demonstrates generating arbitrary row numbers for the whole table.
-- This is generally used when you just want a unique row ID, without meaningful order.

SELECT *, 
ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS RowNum
FROM tblAttendance

-- =-========================================
-- NTILE Function (Decile Grouping)
-- =-========================================
-- NTILE splits a partition into equal-sized buckets.
-- Commonly used to assign decile/quartile groups based on order — here, by attendance month.

SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
-- Built-in function that assigns each row into 1 of 10 equal-sized groups per employee
NTILE(10) OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS TheNTile,
-- Manual calculation of NTILE using ROW_NUMBER and COUNT for comparison
CONVERT(INT, 
    (ROW_NUMBER() OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) - 1) / 
    (COUNT(*) OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) / 10.0)
) + 1 AS MyNTile
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
WHERE A.AttendanceMonth < '2015-05-01'
