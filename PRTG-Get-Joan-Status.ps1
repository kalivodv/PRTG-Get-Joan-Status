# Script that gets JOAN Assistant device information from JOAN (Visionect) on-premise server as PRTG custom XML/EXE sensor

param(
[string]$deviceid
)

$hostURI = 'http://my.joanserver.com:8081'
$httpsURI = 'https://my.joanserver.com'
$api_key = '123aaa456bbb'
$api_secret = 'someveryrandomstring'

$requestMethod = 'GET'
$contentSHA256 = ''
$contentType = 'application/json'
$date = (Get-Date -Format r) #Format date to RFC1123
$requestPath = '/api/device/' + $deviceid

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add('Content-Type' , $contentType)
$headers.Add('Date', $date) 

$computeThis = "$requestMethod`n$contentSHA256`n$contentType`n$date`n$requestPath"

$hmacsha = New-Object System.Security.Cryptography.HMACSHA256
$hmacsha.key = [Text.Encoding]::ASCII.GetBytes($api_secret)
$signature = [Convert]::ToBase64String($hmacsha.ComputeHash([Text.Encoding]::ASCII.GetBytes($computeThis)))
$headers.Add('Authorization',$api_key + ':' + $signature)

$urlAddress = $httpsURI + $requestPath

$jsonResult = (Invoke-WebRequest -Method $requestMethod -Headers $headers -Uri $urlAddress -UseBasicParsing).Content

$json = (ConvertFrom-Json $jsonResult)

$battery = $json.Status.Battery
$temperature = $json.Status.Temperature
$signal = $json.Status.RSSI

$state_w = $json.State

if ($state_w -eq 'online') { $state_n = 1 }
elseif ($state_w -eq 'offline') { $state_n = 2 }
elseif ($state_w -eq 'flashing') { $state_n = 3 }
elseif ($state_w -eq 'flashing complete') { $state_n = 4 }
elseif ($state_w -eq 'sleeping') { $state_n = 5 }
elseif ($state_w -eq 'charging') { $state_n = 6 }
elseif ($state_w -eq 'unavailable') { $state_n = 7 }
elseif ($state_w -eq 'sending') { $state_n = 8 }
elseif ($state_w -eq 'receiving') { $state_n = 9 }
else { $state_n = 10 }

Write-Host "<prtg>"
Write-Host "<result>"
Write-Host "<channel>State</channel>"
Write-Host "<value>$state_n</value>"
Write-Host "<valuelookup>custom.joan.device.state</valuelookup>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Battery</channel>"
Write-Host "<value>$battery</value>"
Write-Host "<unit>Percent</unit>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Temperature</channel>"
Write-Host "<value>$temperature</value>"
Write-Host "<unit>Temperature</unit>"
Write-Host "</result>"
Write-Host "<result>"
Write-Host "<channel>Signal</channel>"
Write-Host "<value>$signal</value>"
Write-Host "</result>"
Write-Host "</prtg>"