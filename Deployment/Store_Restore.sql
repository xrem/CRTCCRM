USE [data_warehouse_crmdb]
GO

EXEC	[dbo].[StoreDataFromAntoherInstance] @currentInstanceName = N'instance_one_crmdb'
GO

EXEC	[dbo].[StoreDataFromAntoherInstance] @currentInstanceName = N'instance_two_crmdb'
GO

EXEC	[dbo].[InitHardcodedLanguages] @currentInstanceName = N'restored_instance_crmdb'
GO

EXEC	[dbo].[RestoreInstanceData]
		@restoreTarget = N'restored_instance_crmdb',
		@instaceImportedFrom = N'instance_one_crmdb'
GO

INSERT INTO view_crmdb.dbo.Leads
(
    ClientTitle,
    Category,
    Source,
    Status,
    Language,
    Type
)
SELECT ClientTitle,
    Category,
    Source,
    Status,
    Language,
    Type
FROM dbo.LeadsView lv