@echo off
cls
powershell -executionpolicy bypass -File .\powershell-scripts\create-warehouse.ps1 -databaseName data_warehouse_crmdb
echo Done.
pause