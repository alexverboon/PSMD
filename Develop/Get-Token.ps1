# This script gets the app context token and saves it to a file named "Latest-token.txt" under the current directory.
# Paste in your tenant ID, client ID and app secret (App key).

Function Get-Token{

$ConfigFileDir =  [IO.Directory]::GetParent($PSScriptRoot)
$PSMDConfigFile = "$ConfigFileDir\" +  "PSMDConfig.json"
Write-host "PSMD ConfigFile: $PSMDConfigFile"

$tenantId = '' # Paste your directory (tenant) ID here
$clientId = '' # Paste your application (client) ID here
$appSecret = '' # # Paste your own app secret here to test, then store it in a safe place!

If (Test-Path -Path $PSMDConfigFile -PathType Leaf){
    $ConfigSettings = @(Get-Content -Path "$PSMDConfigFile" | ConvertFrom-Json)
    $TenantId = $ConfigSettings.API_PSMD.TenantId
    $clientId = $ConfigSettings.API_PSMD.ClientId
    $appSecret = $ConfigSettings.API_PSMD.ClientSecret
}
Else{
    Write-Error "$PSMDConfigFile not found"
    Break
}


$resourceAppIdUri = 'https://api.security.microsoft.com'
$oAuthUri = "https://login.windows.net/$tenantId/oauth2/token"
$authBody = [Ordered] @{
  resource = $resourceAppIdUri
  client_id = $clientId
  client_secret = $appSecret
  grant_type = 'client_credentials'
}
$authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
$token = $authResponse.access_token
Out-File -FilePath "./Latest-token.txt" -InputObject $token
return $token
}


# This script returns incidents last updated within the past 48 hours.

$token = Get-Token

# Get incidents from the past 48 hours.
# The script may appear to fail if you don't have any incidents in that time frame.
$dateTime = (Get-Date).ToUniversalTime().AddHours(-72).ToString("o")

# This URL contains the type of query and the time filter we created above.
# Note that `$filter` does not refer to a local variable in our script --
# it's actually an OData operator and part of the API's syntax.
$url = "https://api.security.microsoft.com/api/incidents?$filter=lastUpdateTime+ge+$dateTime"

# Set the webrequest headers
$headers = @{
    'Content-Type' = 'application/json'
    'Accept' = 'application/json'
    'Authorization' = "Bearer $token"
}

# Send the request and get the results.
$response = Invoke-WebRequest -Method Get -Uri $url -Headers $headers -ErrorAction Stop

# Extract the incidents from the results.
$incidents =  ($response | ConvertFrom-Json).value | ConvertTo-Json -Depth 99

# Get a string containing the execution time. We concatenate that string to the name 
# of the output file to avoid overwriting the file on consecutive runs of the script.
$dateTimeForFileName = Get-Date -Format o | foreach {$_ -replace ":", "."}

# Save the result as json
$outputJsonPath = "./Latest Incidents $dateTimeForFileName.json"
$incidents | ConvertFrom-Json

#Out-File -FilePath $outputJsonPath -InputObject $incidents