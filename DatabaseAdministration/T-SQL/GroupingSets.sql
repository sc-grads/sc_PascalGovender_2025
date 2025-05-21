-- =-========================================
-- Adding Totals (Manual Rollup using UNION)
-- =-========================================
-- This example uses UNIONs to manually simulate subtotals and grand totals.
-- 1st SELECT: Detailed by Department, Employee, Month
-- 2nd SELECT: Subtotals per Employee
-- 3rd SELECT: Subtotals per Department
-- 4th SELECT: Grand total (across all data)

SELECT E.Department, E.EmployeeNumber, A.AttendanceMonth AS AttendanceMonth, SUM(A.NumberAttendance) AS NumberAttendance
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
GROUP BY E.Department, E.EmployeeNumber, A.AttendanceMonth

UNION

SELECT E.Department, E.EmployeeNumber, NULL AS AttendanceMonth, SUM(A.NumberAttendance) AS TotalAttendance
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
GROUP BY E.Department, E.EmployeeNumber

UNION

SELECT E.Department, NULL, NULL AS AttendanceMonth, SUM(A.NumberAttendance) AS TotalAttendance
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
GROUP BY E.Department

UNION

SELECT NULL, NULL, NULL AS AttendanceMonth, SUM(A.NumberAttendance) AS TotalAttendance
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

ORDER BY Department, EmployeeNumber, AttendanceMonth


-- =-========================================
-- ROLLUP, GROUPING and GROUPING_ID
-- =-========================================
-- ROLLUP automatically adds subtotal and grand total rows.
-- GROUPING(): Shows if a column was aggregated (1 = is NULL due to grouping).
-- GROUPING_ID(): Encodes all GROUPING states into a bitmask integer.

SELECT E.Department, E.EmployeeNumber, A.AttendanceMonth AS AttendanceMonth, 
       SUM(A.NumberAttendance) AS NumberAttendance,
       GROUPING(E.EmployeeNumber) AS EmployeeNumberGroupedBy,       -- 1 if this row is a subtotal
       GROUPING_ID(E.Department, E.EmployeeNumber, A.AttendanceMonth) AS EmployeeNumberGroupedID
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
GROUP BY ROLLUP (E.Department, E.EmployeeNumber, A.AttendanceMonth)
ORDER BY Department, EmployeeNumber, AttendanceMonth


-- =-========================================
-- GROUPING SETS
-- =-========================================
-- GROUPING SETS allows more flexible grouping than ROLLUP or CUBE.
-- You explicitly define the combinations of groupings.
-- () = Grand total
-- (Department) = Subtotal by Department
-- (Department, EmployeeNumber, Month) = Detail level

SELECT E.Department, E.EmployeeNumber, A.AttendanceMonth AS AttendanceMonth, 
       SUM(A.NumberAttendance) AS NumberAttendance,
       GROUPING(E.EmployeeNumber) AS EmployeeNumberGroupedBy,
       GROUPING_ID(E.Department, E.EmployeeNumber, A.AttendanceMonth) AS EmployeeNumberGroupedID
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
GROUP BY GROUPING SETS (
  (E.Department, E.EmployeeNumber, A.AttendanceMonth),  -- Full detail
  (E.Department),                                       -- Department-level subtotal
  ()                                                    -- Grand total
)
ORDER BY 
  COALESCE(Department, 'zzzzzzz'), 
  COALESCE(E.EmployeeNumber, 99999), 
  COALESCE(AttendanceMonth,'2100-01-01')


-- =-========================================
-- GROUPING SETS (Alternative Sort for Clarity)
-- =-========================================
-- Adds conditional sorting logic to keep NULLs (totals) at the end of each level.

SELECT E.Department, E.EmployeeNumber, A.AttendanceMonth AS AttendanceMonth, 
       SUM(A.NumberAttendance) AS NumberAttendance,
       GROUPING(E.EmployeeNumber) AS EmployeeNumberGroupedBy,
       GROUPING_ID(E.Department, E.EmployeeNumber, A.AttendanceMonth) AS EmployeeNumberGroupedID
FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber
GROUP BY GROUPING SETS (
  (E.Department, E.EmployeeNumber, A.AttendanceMonth), 
  (E.Department), 
  ()
)
ORDER BY 
  CASE WHEN Department IS NULL THEN 1 ELSE 0 END, Department,
  CASE WHEN E.EmployeeNumber IS NULL THEN 1 ELSE 0 END, E.EmployeeNumber,
  CASE WHEN AttendanceMonth IS NULL THEN 1 ELSE 0 END, AttendanceMonth
