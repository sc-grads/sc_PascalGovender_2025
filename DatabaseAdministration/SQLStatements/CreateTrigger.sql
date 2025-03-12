
CREATE TABLE [dbo].[EmployeeTriggerHistory](
	[ID] [int] NULL,
	[Statement] [nchar](10) NULL
) ON [PRIMARY]

GO

--TRIGGER creation syntax--

CREATE TRIGGER [dbo].[EmployeeInsert] 
   ON  [dbo].[Employee] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.--
	SET NOCOUNT ON;

    -- Add statements for trigger here--
	INSERT INTO EmployeeTriggerHistory VALUES ((SELECT MAX(EmpID) FROM employee),'Insert')


END

GO

--------SIMPLE INSERT TO TEST TRIGGER------------

INSERT INTO [Employee] ([EmpID],[EmpName],[EmpTitle]) VALUES (20,'John','Doe Manager')

SELECT * FROM [dbo].[EmployeeTriggerHistory]



