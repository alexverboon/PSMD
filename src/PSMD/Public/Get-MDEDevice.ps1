<#
.SYNOPSIS
    Get-MDEDevice
.DESCRIPTION
    Retrieve Microsoft Defender for Endpoint device information
.EXAMPLE
    Get-MDEDevice
.PARAMETER DeviceValue
    Device Value
.PARAMETER HealthStatus
    Health Status
.PARAMETER Token
    Token to use for authentication
.OUTPUTS
    Microsoft Defender for Endpoint device information
.NOTES

.COMPONENT
    PSMD
#>
Function Get-MDEDevice{
    [CmdletBinding()]
    Param(
        # Device Value
        [Parameter(Mandatory=$false)]
        [ValidateSet('Low','Normal','High')]
        [string]$DeviceValue,
        # Health Status
        [Parameter(Mandatory=$false)]
        [ValidateSet('Active', 'Inactive')]
        [String]$HealthStatus,
        # API Token
        [Parameter(Mandatory=$false)]
        $token
    )

    Try{
        $token = Get-PSMDAPIToken -API "MDE"
        $url = "https://api.securitycenter.microsoft.com/api/machines"

        If($PSBoundParameters.ContainsKey("DeviceValue") -and $PSBoundParameters.ContainsKey("HealthStatus")){
            Write-Verbose 'both'
            $DeviceValueFilter = "DeviceValue eq '$DeviceValue'"
            $HealthFilter = "healthStatus eq '$Healthstatus'"
            $url = $url + "?`$filter=" + $DeviceValueFilter + " and " + $HealthFilter
        }
        ElseIf($PSBoundParameters.ContainsKey("HealthStatus")){
            $HealthFilter = "healthStatus eq '$Healthstatus'"
            $url = $url + "?`$filter=" + $HealthFilter
        }
        Elseif($PSBoundParameters.ContainsKey("DeviceValue")){
            $DeviceValueFilter = "DeviceValue eq '$DeviceValue'"
            $url = $url + "?`$filter=" + $DeviceValueFilter
        }

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
            $Devices =  ($response | ConvertFrom-Json).value
            $Devices
        }
        elseif($response.StatusCode -eq 429){
            Write-Error $Error[0]
        }
    }
    catch{
        Write-Error $_
    }
}
