--Table creation and select statements--

CREATE TABLE [dbo].[Employee](
	[EmpID] [int] NOT NULL,
	[EmpName] [nvarchar](50) NULL,
	[EmpTitle] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
--------------------------------------------------
CREATE TABLE [dbo].[Sales](
	[EmpID] [int] NULL,
	[EmpName] [nvarchar](50) NULL,
	[SalesNumber] [int] NOT NULL,
	[ItemSold] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------
SELECT * FROM [dbo].[Employee]
SELECT * FROM [dbo].[Sales]

--JOIN--

SELECT * FROM [dbo].[Employee] e
JOIN [dbo].[Sales] s 
ON e.EmpName = s.EmpName


SELECT * FROM [dbo].[Employee] e
JOIN [dbo].[Sales] s 
ON e.EmpID = s.[EmpID]

--With order by--

SELECT e.EmpID,e.EmpName,s.SalesNumber,s.ItemSold FROM [dbo].[Employee] e
JOIN [dbo].[Sales] s 
ON e.EmpID = s.[EmpID]
ORDER BY e.EmpID


--with group by--

SELECT count(s.SalesNumber),e.EmpID,e.EmpName FROM [dbo].[Employee] e
JOIN [dbo].[Sales] s 
ON e.EmpID = s.[EmpID]
GROUP BY e.EmpID,e.EmpName