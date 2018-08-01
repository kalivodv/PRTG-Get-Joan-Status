# Script for getting values of multiple performance counters of one type and one specific instance as PRTG channels

param(

[string]$remotehost

)

$countersgroup = ".NET Data Provider for SqlServer(*)"
$counters = 'NumberOfPooledConnections','NumberOfActiveConnections','NumberOfFreeConnections'
$instancelike = "w3svc_3"

Write-Host "<prtg>"

foreach ($element in $counters){
    $Counter = "\\$remotehost\$countersgroup\$element"
    $Instance = ((Get-Counter $Counter).CounterSamples | ? {$_.InstanceName -like "*$instancelike*"}).Path
    $Value = (Get-Counter $Instance).CounterSamples.RawValue

    Write-Host "<result>"
    Write-Host "<channel>$element</channel>"
    Write-Host "<value>$Value</value>"
    Write-Host "</result>"

}

Write-Host "</prtg>"
