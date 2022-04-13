<#
.SYNOPSIS
    Get-MDIncidents
.DESCRIPTION
    Retrieve Microsoft 365 Defender Incidents
.EXAMPLE
    Get-MDIncidents
.PARAMETER Days
    Number of Days
.PARAMETER Severity
    Severity of the Incident
.PARAMETER Token
    Token to use for authentication
.OUTPUTS
    Microsoft 365 Defender Incidents
.NOTES

.COMPONENT
    PSMD
#>
Function Get-MDIncident{
    [CmdletBinding()]
    Param(
        # Days
        [Parameter(Mandatory=$false)]
        [ValidateSet('4','12', '24', '48','72','168','720')]
        [int]$Hours,
        # Alert Severity level
        [Parameter(Mandatory=$false)]
        [ValidateSet('High', 'Medium', 'Low','Informational')]
        [String]$Severity,
        # API Token
        [Parameter(Mandatory=$false)]
        $token
    )

    Try{
        If ($null -eq $Hours) {
            $Hours = 4
        }
        $Severity = "Low"
        $token = Get-PSMDAPIToken -API "MD"

        $dateTime = (Get-Date).ToUniversalTime().AddHours(-72).ToString("o")
        $url = "https://api.security.microsoft.com/api/incidents?$filter=lastUpdateTime+ge+$dateTime"

        # Set the webrequest headers
        $headers = @{
            'Content-Type'  = 'application/json'
            'Accept'        = 'application/json'
            'Authorization' = "Bearer $token"
        }
        # Send the request and get the results.
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $response = Invoke-WebRequest -Method Get -Uri $url -Headers $headers -ErrorAction Stop
        If ($response.StatusCode -eq 200){
            $incidents =  ($response | ConvertFrom-Json).value | ConvertTo-Json -Depth 99
            $incidents
        }
        elseif($response.StatusCode -eq 429){
            Write-Error $Error[0]
        }
    }
    Catch{Write-Error $Error[0]}
}