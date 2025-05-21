-- =-========================================
-- Using PARTITION BY and ORDER BY
-- =-========================================

-- Calculates a rolling total that includes the previous, current, and next attendance record for each employee
SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth 
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS RollingTotal
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

-- Calculates a rolling total including 2 previous rows up to the current row per employee, ordered by month
SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RollingTotal
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

-- Cumulative total from the beginning of each employee’s data up to the current row
SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RollingTotal
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

-- Cumulative total from the current row to the end of the employee’s attendance data
SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth 
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS RollingTotal
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

-- =-========================================
-- Comparing ROWS vs RANGE
-- =-========================================

-- Demonstrates the difference between ROWS and RANGE frame types:
-- ROWS looks at physical row positions, RANGE respects logical peer groupings (based on ORDER BY)
SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance,

SUM(A.NumberAttendance) OVER(
PARTITION BY A.EmployeeNumber, YEAR(A.AttendanceMonth) 
ORDER BY A.AttendanceMonth ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS RowsTotal,

SUM(A.NumberAttendance) OVER(
PARTITION BY A.EmployeeNumber, YEAR(A.AttendanceMonth) 
ORDER BY A.AttendanceMonth RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS RangeTotal

FROM tblEmployee AS E 
JOIN (SELECT * FROM tblAttendance UNION ALL SELECT * FROM tblAttendance) AS A 
ON E.EmployeeNumber = A.EmployeeNumber
ORDER BY A.EmployeeNumber, A.AttendanceMonth

-- =-========================================
-- Omitting ROWS/RANGE: Default Framing
-- =-========================================

-- When no ROWS or RANGE is specified:
-- If ORDER BY exists, default is RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- If ORDER BY is omitted, default is RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
SUM(A.NumberAttendance) OVER() AS TotalAttendance
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

-- Simple aggregate for verification
SELECT SUM(NumberAttendance) FROM tblAttendance

-- Uses default RANGE with ORDER BY for a cumulative sum per employee per year
SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 
SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber, YEAR(A.AttendanceMonth) ORDER BY A.AttendanceMonth) AS SumAttendance
FROM tblEmployee AS E 
JOIN (SELECT * FROM tblAttendance UNION ALL SELECT * FROM tblAttendance) AS A 
ON E.EmployeeNumber = A.EmployeeNumber
ORDER BY A.EmployeeNumber, A.AttendanceMonth
