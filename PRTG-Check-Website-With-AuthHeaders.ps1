param(
    [string]$url = "http://some.website.com"
)

$exectime = [System.Diagnostics.Stopwatch]::StartNew()

try {
$a = Invoke-WebRequest -Uri $url -UseBasicParsing -Method GET -Headers @{"sendToken" = "s3cr3tT0k3n"}

}catch{
    Write-Output "<prtg>"
    Write-Output "<error>1</error>"
    Write-Output "<text>Query Failed: $($_.Exception.Message)</text>"
    Write-Output "</prtg>"
    Exit
}

$exectime.Stop()

#$a.RawContentStream
#$a.RawContentLength

write-host "<prtg>"

Write-Host "<result>"
Write-Host "<channel>Status Code</channel>"
Write-Host "<value>$($a.StatusCode)</value>"
Write-Host "<valuelookup>prtg.standardlookups.http.statuscode</valuelookup>"
Write-Host "</result>"

Write-Host "<result>"
Write-Host "<channel>Length</channel>"
Write-Host "<value>$($a.RawContentLength)</value>"
Write-Host "</result>"

Write-Host "<result>"
Write-Host "<channel>ExecTime</channel>"
Write-Host "<value>$($exectime.ElapsedMilliseconds)</value>"
Write-Host "<CustomUnit>msecs</CustomUnit>"
Write-Host "</result>"

write-host "<text>$($url)</text>"

write-host "</prtg>"