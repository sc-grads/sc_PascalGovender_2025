---ALL DONE USING MSSQL GUI THEN SCIPTED----
--right click databases -> restore database -> 
--select files (full &/ diff) 
-->[can make a new DB or keep the name if dropped] 
--> make non recovery in options (keep offline until done) ->  script then run
--> right click the database --> tasks --> transaction logs then follow from line 3 with trn files

---Brings database ONLINE(active for querying) --
RESTORE DATABASE [AdventureWorks2022] WITH RECOVERY
GO

---Full backup restore not online--
USE [master]
RESTORE DATABASE [AdventureWorks2022] FROM  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_FULL.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

---Diff backup restore not online--
USE [master]
RESTORE DATABASE [AdventureWorks2022] FROM  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_DIFF_1.diff' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

--TRANS LOG backup restoration not online---
RESTORE LOG [AdventureWorks2022] FROM  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_TRN_1.trn' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO
RESTORE LOG [AdventureWorks2022] FROM  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_TRN_2.trn' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO
RESTORE LOG [AdventureWorks2022] FROM  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_TRN_3.trn' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  STATS = 10
GO


---RESTORING DATABASE FROM ANOTHER DATABASE BACKUPS---

USE [master]
RESTORE DATABASE [AdventureWorks2016_RestoreTest] FROM  DISK = N'C:\SQL_BACKUPS\AdventureWorks2022_FULL.BAK' WITH  FILE = 3,  
MOVE N'AdventureWorks2022_Data' TO N'C:\SQL_DATA_FILES\AdventureWorks2022_RestoreTest_Data.mdf',  MOVE N'AdventureWorks2022_Log' 
TO N'C:\SQL_LOG_FILES\AdventureWorks2016_RestoreTest_Log.ldf',  NORECOVERY,  NOUNLOAD,  STATS = 5
RESTORE DATABASE [AdventureWorks2022_RestoreTest] FROM  DISK = N'C:\SQL_BACKUPS\AdventureWorks2022_DIFF_1.diff' WITH  FILE = 3,  NORECOVERY,  NOUNLOAD,  STATS = 5

GO

RESTORE LOG [AdventureWorks2016_RestoreTest] FROM  DISK = N'C:\SQL_BACKUPS\AdventureWorks2022_TRN_1.trn' WITH  FILE = 1,  NOUNLOAD,  STATS = 10, 
 STOPAT = N'2025-03-14T14:25:28'
GO
