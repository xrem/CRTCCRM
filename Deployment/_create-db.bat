@echo off
cls
powershell -executionpolicy bypass -File .\powershell-scripts\create-database.ps1 -databaseName crmdb
echo Done.
pause