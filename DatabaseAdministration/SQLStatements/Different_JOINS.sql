--Table creation and select statements--
CREATE TABLE [dbo].[Course] (
    [CourseID] [int] NULL,
    [RollNO] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Student] (
    [RollNo] [int] NOT NULL,
    [StudentName] [nvarchar](50) NULL,
    [StudentCity] [nvarchar](20) NULL,
    [StudentPhoneNo] [nvarchar](50) NULL,
    [StudentAge] [int] NULL,
    CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED
    (
        [RollNo] ASC
    ) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
--------------------------------------------------------
SELECT * FROM [dbo].[Student]
SELECT * FROM [dbo].[Course]

--INNER JOIN--
SELECT * FROM [dbo].[Student] AS s
INNER JOIN [dbo].[Course] AS c
    ON s.rollno = c.rollno


SELECT
    s.rollno,
    s.studentname,
    c.courseid
FROM [dbo].[Student] AS s
INNER JOIN [dbo].[Course] AS c
    ON s.rollno = c.rollno

--JOIN--

SELECT
    s.rollno,
    s.studentname,
    c.courseid
FROM [dbo].[Student] AS s
INNER JOIN [dbo].[Course] AS c
    ON s.rollno = c.rollno

--LEFT JOIN--

SELECT
    s.rollno,
    s.studentname,
    c.courseid
FROM [dbo].[Student] AS s
LEFT JOIN [dbo].[Course] AS c
    ON s.rollno = c.rollno


--RIGHT JOIN--

SELECT
    s.rollno,
    s.studentname,
    c.courseid
FROM [dbo].[Student] AS s
RIGHT JOIN [dbo].[Course] AS c
    ON s.rollno = c.rollno

--FULL JOIN--

SELECT
    s.rollno,
    s.studentname,
    c.courseid
FROM [dbo].[Student] AS s
FULL JOIN [dbo].[Course] AS c
    ON s.rollno = c.rollno
