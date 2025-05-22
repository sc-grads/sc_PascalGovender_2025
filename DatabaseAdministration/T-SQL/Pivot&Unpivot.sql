-- ============================================
-- Pivot
-- ============================================

-- Extract Year, Month, and Amount from the transaction table
with myTable as (
    select year(DateOfTransaction) as TheYear, 
           month(DateOfTransaction) as TheMonth, 
           Amount 
    from tblTransaction
)
-- Pivot the data: one row per year, one column per month, with total amount
select * from myTable
pivot (
    sum(Amount) for TheMonth in (
        [1], [2], [3], [4], [5], [6], 
        [7], [8], [9], [10], [11], [12]
    )
) as myPvt
order by TheYear;

-- ============================================
-- Replacing Nulls with Zeros in Pivot
-- ============================================

-- Same pivot structure, but wrap each month column with ISNULL to replace nulls with 0
with myTable as (
    select year(DateOfTransaction) as TheYear, 
           month(DateOfTransaction) as TheMonth, 
           Amount 
    from tblTransaction
)
select TheYear, 
       isnull([1],0) as [1], 
       isnull([2],0) as [2], 
       isnull([3],0) as [3],
       isnull([4],0) as [4],
       isnull([5],0) as [5],
       isnull([6],0) as [6],
       isnull([7],0) as [7],
       isnull([8],0) as [8],
       isnull([9],0) as [9],
       isnull([10],0) as [10],
       isnull([11],0) as [11],
       isnull([12],0) as [12]
from myTable
pivot (
    sum(Amount) for TheMonth in (
        [1], [2], [3], [4], [5], [6], 
        [7], [8], [9], [10], [11], [12]
    )
) as myPvt
order by TheYear;

-- ============================================
-- UnPivot
-- ============================================

-- Convert monthly amount columns back into row format with UNPIVOT
select * 
from [tblPivot]
unpivot (
    Amount for Month in (
        [1], [2], [3], [4], [5], [6], 
        [7], [8], [9], [10], [11], [12]
    )
) as tblUnPivot
where Amount <> 0;  -- Filter out zero entries for cleaner result
