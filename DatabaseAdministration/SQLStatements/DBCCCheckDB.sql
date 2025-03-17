DBCC CHECKDB	('AdventureWorks2022')
DBCC CHECKDB    ('AdventureWorks2022') with no_infomsgs

ALTER DATABASE AdventureWorks2022 SET  single_user with rollback immediate
go

DBCC checkdb ('AdventureWorks2022',REPAIR_REBUILD)
GO
dbcc checkdb ('AdventureWorks2016',REPAIR_ALLOW_DATA_LOSS)
GO


ALTER DATABASE AdventureWorks2022 SET MULTI_user with rollback immediate
GO
