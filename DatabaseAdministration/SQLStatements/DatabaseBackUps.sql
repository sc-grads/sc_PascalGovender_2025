--BACKUPS done using GUI then scipted--
--make sure db is in FULL under it's properties then options
--right click DB -> tasks -> backup
-->remove file, choose file name accordingly and place
-->choose recovery option
-->then scipt and run



---Test table and data input--
CREATE TABLE SQLBackupRestoreTest (
	ID INT NOT NULL PRIMARY KEY,
	loginName VARCHAR(100) NOT NULL,
	loginDate DATETIME NOT NULL DEFAULT getdate()
)
GO

SELECT * from SQLBackupRestoreTest

insert into SQLBackupRestoreTest (ID,loginname) values (1, 'test1')
insert into SQLBackupRestoreTest (ID,loginname) values (2, 'test2')
insert into SQLBackupRestoreTest (ID,loginname) values (3, 'test3')
insert into SQLBackupRestoreTest (ID,loginname) values (4, 'test4')
insert into SQLBackupRestoreTest (ID,loginname) values (5, 'test5')

BACKUP DATABASE [AdventureWorks2022] TO  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_FULL.bak' WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO ---5 rows backed up---

insert into SQLBackupRestoreTest (ID,loginname) values (6, 'test6')
insert into SQLBackupRestoreTest (ID,loginname) values (7, 'test7')
insert into SQLBackupRestoreTest (ID,loginname) values (8, 'test8')
insert into SQLBackupRestoreTest (ID,loginname) values (9, 'test9')
insert into SQLBackupRestoreTest (ID,loginname) values (10, 'test10')

BACKUP DATABASE [AdventureWorks2022] TO  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_DIFF_1.diff' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO  --10 ROWS DIFFERENTIAL BACKUP---

insert into SQLBackupRestoreTest (ID,loginname) values (11, 'test11')
insert into SQLBackupRestoreTest (ID,loginname) values (12, 'test12')
insert into SQLBackupRestoreTest (ID,loginname) values (13, 'test13')

BACKUP LOG [AdventureWorks2022] TO  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_TRN_1.trn' WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO -- 13 ROWS TRAN 1 BACKUP---

insert into SQLBackupRestoreTest (ID,loginname) values (14, 'test14')
insert into SQLBackupRestoreTest (ID,loginname) values (15, 'test15')
insert into SQLBackupRestoreTest (ID,loginname) values (16, 'test16')
insert into SQLBackupRestoreTest (ID,loginname) values (17, 'test17')

BACKUP LOG [AdventureWorks2022] TO  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_TRN_2.trn' WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO -- 17 ROWS TRAN 2 BACKUP---

---Mar 14 2025  2:25PM
insert into SQLBackupRestoreTest (ID,loginname) values (114, 'test114')


---Mar 14 2025  2:28PM
insert into SQLBackupRestoreTest (ID,loginname) values (115, 'test115')

---Mar 14 2025  2:38PM
insert into SQLBackupRestoreTest (ID,loginname) values (116, 'test116')
insert into SQLBackupRestoreTest (ID,loginname) values (117, 'test117')

BACKUP LOG [AdventureWorks2022] TO  DISK = N'C:\Databases\BACKUPS\AdventureWorks2022_TRN_3.trn' WITH NOFORMAT, NOINIT,  NAME = N'AdventureWorks2022-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO -- 21 ROWS TRAN 3 BACKUP---
--------------

print getdate()
---Mar 14 2025  2:25PM




