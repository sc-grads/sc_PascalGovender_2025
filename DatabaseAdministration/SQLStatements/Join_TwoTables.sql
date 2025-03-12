--Table creation and select statements--

CREATE TABLE [dbo].[Employee] (
    [EmpID] [int] NOT NULL,
    [EmpName] [nvarchar](50) NULL,
    [EmpTitle] [nvarchar](50) NULL,
    PRIMARY KEY CLUSTERED
    (
        [EmpID] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--------------------------------------------------
CREATE TABLE [dbo].[Sales] (
    [EmpID] [int] NULL,
    [EmpName] [nvarchar](50) NULL,
    [SalesNumber] [int] NOT NULL,
    [ItemSold] [int] NULL,
    PRIMARY KEY CLUSTERED
    (
        [SalesNumber] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------
SELECT * FROM [dbo].[Employee]
SELECT * FROM [dbo].[Sales]

--JOIN--

SELECT * FROM [dbo].[Employee] AS e
INNER JOIN [dbo].[Sales] AS s
    ON e.empname = s.empname


SELECT * FROM [dbo].[Employee] AS e
INNER JOIN [dbo].[Sales] AS s
    ON e.empid = s.[EmpID]

--With order by--

SELECT
    e.empid,
    e.empname,
    s.salesnumber,
    s.itemsold
FROM [dbo].[Employee] AS e
INNER JOIN [dbo].[Sales] AS s
    ON e.empid = s.[EmpID]
ORDER BY e.empid


--with group by--

SELECT
    e.empid,
    e.empname,
    count(s.salesnumber)
FROM [dbo].[Employee] AS e
INNER JOIN [dbo].[Sales] AS s
    ON e.empid = s.[EmpID]
GROUP BY e.empid, e.empname
