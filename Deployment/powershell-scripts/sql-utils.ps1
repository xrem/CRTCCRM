function Sql-Execute-Scalar {
    param(
        [string]$server = '.',
        [string]$database,
        [string] $login,
        [string] $password,
        [string]$scalarQuery
    )
    
    $connStr = 'Server='+ $server + ';Database=' + $database
    
    if ($login) {
        $connStr += ';User Id=' + $login + ';Password=' + $password  + ';'
    } else {
        $connStr += ';Integrated Security=True'
    }
    
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $connStr
    $SqlConnection.Open()
    $SqlCmd = New-Object System.Data.SqlClient.SqlCommand
    $SqlCmd.CommandText = $scalarQuery
    $SqlCmd.Connection = $SqlConnection
    $result = $SqlCmd.ExecuteScalar()
    $SqlConnection.Close()
    
    return $result
}

function ExecuteSqlFile {
	param(
        [string] $database,
        [string] $path,
        [string] $server,
        [string] $login,
        [string] $password,
        [string] $vars
    )
    
    $command = '& sqlcmd -b -f 65001 -I' +
        ' -i ' + $path

    if ($vars) {
        $command += ' -v ' + $vars
    }
    if ($database) {
        $command += ' -d ' + $database
    }
    if ($server) {
        $command += ' -S tcp:' + $server
    }
    if ($login) {
        $command += ' -U ' + $login + ' -P ' + $password
    }
    
    Invoke-Expression $command
}