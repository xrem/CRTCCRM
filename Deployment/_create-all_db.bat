@echo off
cls
powershell -executionpolicy bypass -File .\powershell-scripts\create-database.ps1 -databaseName instance_one_crmdb
.\Filler\FillDataGenerator.exe instance_one
powershell -executionpolicy bypass -File .\powershell-scripts\create-database.ps1 -databaseName instance_two_crmdb
.\Filler\FillDataGenerator.exe instance_two
powershell -executionpolicy bypass -File .\powershell-scripts\create-warehouse.ps1 -databaseName data_warehouse_crmdb
powershell -executionpolicy bypass -File .\powershell-scripts\create-database.ps1 -databaseName restored_instance_crmdb -dontFillData yes
powershell -executionpolicy bypass -File .\powershell-scripts\create-viewdb.ps1 -databaseName view_crmdb
echo Done.
pause