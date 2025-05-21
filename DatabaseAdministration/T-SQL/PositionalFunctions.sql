-- =================================
-- FIRST_VALUE and LAST_VALUE
-- =-========================================
-- These functions return the first and last values within a window frame.
-- Commonly used for identifying start/end values in a time series (first and last attendance in a year/month).

SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 

-- Returns the first value of NumberAttendance for each employee, based on earliest month
FIRST_VALUE(NumberAttendance)
OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS FirstMonth,

-- Returns the last value of NumberAttendance for each employee, based on latest month
-- Note: Needs an explicit frame (UNBOUNDED PRECEDING TO UNBOUNDED FOLLOWING) 
-- to ensure it truly gets the last row after sorting
LAST_VALUE(NumberAttendance)
OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth 
     ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastMonth

FROM tblEmployee AS E 
JOIN tblAttendance AS A 
ON E.EmployeeNumber = A.EmployeeNumber

-- =========================================
-- LAG and LEAD
-- =-========================================
-- These functions look backward (LAG) and forward (LEAD) in the dataset.
-- Useful for comparing current row values with previous or next rows (trend or change over time).

SELECT A.EmployeeNumber, A.AttendanceMonth, A.NumberAttendance, 

-- Gets the previous row’s NumberAttendance (1 row before), partitioned by employee
LAG(NumberAttendance, 1)  
OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS MyLag,

-- Gets the next row’s NumberAttendance (1 row after), partitioned by employee
LEAD(NumberAttendance, 1) 
OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS MyLead,

-- Calculates the difference between the current and previous month's attendance
NumberAttendance - LAG(NumberAttendance, 1)  
OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth) AS MyDiff

-- FIRST_VALUE(NumberAttendance)  
-- OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth 
--      ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS MyFirstValue,

-- LAST_VALUE(NumberAttendance) 
-- OVER(PARTITION BY E.EmployeeNumber ORDER BY A.AttendanceMonth 
--      ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS MyLastValue

FROM tblEmployee AS E 
JOIN tblAttendance AS A 
ON E.EmployeeNumber = A.EmployeeNumber
