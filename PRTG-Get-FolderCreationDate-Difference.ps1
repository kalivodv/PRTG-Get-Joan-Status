# Script for getting difference between folder creation date and todays date in number of days, hours, ...
param (
    
    [string]$currentPath = $(throw "-currentPath is required!")
)

if ((Test-Path $currentPath -PathType Container) -eq $true) {

    $todaysDate = (Get-Date)
    $creationDate = (Get-Item -Path $currentPath).CreationTime

    $difference = New-TimeSpan -Start $creationDate -End $todaysDate

    $difDays = ($difference.Days)
    $difHours = ($difference.Hours)
    $difMinutes = ($difference.Minutes)
    $difSeconds = ($difference.Seconds)


    Write-Host "<prtg>"
    Write-Host "<result>"
    Write-Host "<channel>Days</channel>"
    Write-Host "<value>$difDays</value>"
    Write-Host "</result>"
    Write-Host "</prtg>"

} else {

    Write-Host "<prtg>"
    Write-Host "<error>1</error>"
    Write-Host "<text>Path $currentPath does not exists!</text>"
    Write-Host "</prtg>"

}