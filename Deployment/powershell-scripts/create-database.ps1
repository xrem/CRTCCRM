param(
    [string] $databaseName,
    [string] $command,
    [string] $server = '.',
    [string] $login,
    [string] $password,
	[string] $dontfillData
)

#[VALIDATION]
if ([string]::IsNullOrEmpty($databaseName)) {
    throw "Parameter databaseName should be set"
    exit
}

#[IMPORTS]
$scriptDir = split-path -parent $MyInvocation.MyCommand.Definition
. ($scriptDir + '\sql-utils.ps1')

#[CONFIGURATION]
$createDbFileNameBase = "DDL_04042018.sql"
$fillDataDbFileNameBase = "FillDebugData.sql"

#[Resources]
$checkDBExistsQuery = @"
    DECLARE @exists BIT = 0
    IF EXISTS(SELECT * FROM master.sys.databases WHERE name='$databaseName') BEGIN
        SET @exists = 1
    END
    SELECT @exists
"@

#[INTERNAL]
function Execute {
    param([string] $path)
    ExecuteSqlFile -vars "DatabaseName=$databaseName" -path $path -server $server -login $login -password $password
}
function ExecuteScalarQuery {
    param(
        [string] $query,
        [string] $database
    )
    return Sql-Execute-Scalar -server $server -login $login -password $password -database $database -scalarQuery $query 
}

$createDbScript = Get-ChildItem -name -include ($createDbFileNameBase)
Execute -path $createDbScript

if ([string]::IsNullOrEmpty($dontfillData)) {
	$fillDataScript = Get-ChildItem -name -include ($fillDataDbFileNameBase)
	Execute -path $fillDataScript   
}
