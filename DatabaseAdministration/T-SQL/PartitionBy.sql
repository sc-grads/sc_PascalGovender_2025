-- =-========================================
-- Using PARTITION BY and ORDER BY
-- =-========================================
SELECT A.EmployeeNumber,A.AttendanceMonth,A.NumberAttendance, 
    SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber) AS SumAttendance,
    -- Calculates total attendance per employee (partitioned by EmployeeNumber, no date sorting)

    CONVERT(MONEY, A.NumberAttendance) / SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber) * 100 AS PercentageAttendance
    -- Calculates percentage of this row's attendance over the employee's total attendance

FROM tblEmployee AS E JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

-- =-===========================================================================
-- Second Query: Cumulative attendance per employee per year, ordered by month
-- =-========================================

SELECT A.EmployeeNumber,A.AttendanceMonth,A.NumberAttendance, 
    SUM(A.NumberAttendance) 
     OVER(PARTITION BY E.EmployeeNumber, YEAR(A.AttendanceMonth) 
          ORDER BY A.AttendanceMonth) AS SumAttendance,
    -- Cumulative sum of attendance per employee per year, ordered chronologically by month

    CONVERT(MONEY, A.NumberAttendance) / SUM(A.NumberAttendance) OVER(PARTITION BY E.EmployeeNumber) * 100 AS PercentageAttendance
    -- Attendance percentage per employee across *all* months (not year-specific here)

FROM tblEmployee AS E JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
ORDER BY A.EmployeeNumber, A.AttendanceMonth
-- Final output sorted by employee and month for readability
