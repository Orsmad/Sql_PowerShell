param (

    [datetime]$HireDate = $Null
)


$securePassword = Read-Host "Enter the password" -AsSecureString

$password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword))

$configFilePath =  "./config.ini"

$configContent = Get-Content -Path $configFilePath

$server = $null
$database = $null
$user = $null

# Process each line in the config file
foreach ($line in $configContent) {
    if (-not ($line -match "^\s*(#|;)") -and $line -match "^\s*([^=]+?)\s*=\s*(.*?)\s*$") {
        $variableName = $Matches[1].Trim()
        $variableValue = $Matches[2].Trim()

        switch ($variableName) {
            "server" {
                $server = $variableValue
            }
            "database" {
                $database = $variableValue
            }
            "user" {
                $user = $variableValue
            }
        }
    }
}


if ([string]::IsNullOrEmpty($HireDate)) {
    Write-Host "Please provide a valid value for the -HireDate parameteer."
    return
}


$dateString = $HireDate.ToString("yyyy-MM-dd HH:mm:ss")
if ($HireDate -eq $null) {
    Write-Host "Please provide a valid value for the -HireDate parameter."
    return
}
$connectionString = "Driver={MySQL ODBC 8.0 ANSI Driver};Server=$Server;Database=$Database;Uid=$User;Pwd=$password;"

$connection = New-Object System.Data.Odbc.OdbcConnection($connectionString)

try {
    $connection.Open()

    Write-Host "Connected to MySQL database."

    $command = $connection.CreateCommand()
    
    $command.CommandText = @"
        SELECT DEPT.name AS 'DEPARTMENT-NAME', EMPLOYEES.name AS 'EMPLOYEE-NAME', EMPLOYEES.hiredate AS 'EMPLOYEE-HIREDATE'
        FROM DEPT
        JOIN EMPLOYEES ON DEPT.id = EMPLOYEES.deptid
        WHERE EMPLOYEES.hiredate > '$dateString'
        ORDER BY DEPT.name , EMPLOYEES.hiredate DESC, EMPLOYEES.name ;
"@

    $dataAdapter = New-Object System.Data.Odbc.OdbcDataAdapter($command)
    $dataTable = New-Object System.Data.DataTable
    $dataAdapter.Fill($dataTable)

    $dataTable

} catch {
    Write-Host "Failed to connect to MySQL database: $($_.Exception.Message)"
} finally {
    $connection.Close()
    $connection.Dispose()
}
