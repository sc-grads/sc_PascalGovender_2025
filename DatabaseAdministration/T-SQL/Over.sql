-- First Query: Calculates total attendance and each employee's percentage share

SELECT A.EmployeeNumber,A.AttendanceMonth,A.NumberAttendance,              
SUM(A.NumberAttendance) OVER() AS TotalAttendance,  
    -- Calculates total attendance across all rows (no PARTITION = entire result set)

    CONVERT(DECIMAL(18,7), A.NumberAttendance) / SUM(A.NumberAttendance) OVER() * 100.0000 AS PercentageAttendance
    -- Calculates attendance percentage per employee by dividing individual attendance by the total attendance

FROM tblEmployee AS E 
JOIN tblAttendance AS A ON E.EmployeeNumber = A.EmployeeNumber

-- Second Query: Simple aggregate total attendance for verification
SELECT SUM(NumberAttendance) FROM tblAttendance
-- Verifies the total attendance from the base table (no window function used here)
