--Go to indexes at table in a DB-
--Right click folder, new index and use editor--
--then click scipt once done--

USE [AdventureWorks2022]

GO

SET ANSI_PADDING ON


GO

CREATE NONCLUSTERED INDEX [idx_FirstName_LastName]
    ON [Person].[Person]
    (
        [FirstName] ASC
    )
    INCLUDE ([LastName], [ModifiedDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)

GO
