<#
.SYNOPSIS
    Get-MDEDevice
.DESCRIPTION
    Retrieve Microsoft Defender for Endpoint device information
.EXAMPLE
    Get-MDEDevice -All

    List all devices in Microsoft Defender for endpoint
.EXAMPLE
    Get-MDEDevice -DeviceName testmachine38

    Retrieve details for the specified device

.EXAMPLE
    Get-MDEDevice -RiskScore High

    Retrieve all devices with a high risk score

.PARAMETER DeviceName
    Device ComputerDNSName
.PARAMETER DeviceID
    Microsoft Defender for Endpoint unique device ID
.PARAMETER All
    List all devices
.PARAMETER DeviceValue
    Device Value
.PARAMETER HealthStatus
    Health Status
.PARAMETER Explosurelevel
    Device exposurelevel
.PARAMETER RiskScore
    Device RiskScore
.PARAMETER onboardingStatus
    Device Onboarding status
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

        # ComputerDNSName
        [Parameter(Mandatory=$true,
            ParameterSetName='DeviceName')]
        [ValidateNotNullOrEmpty()]
        [String]$DeviceName,

        # Microsoft Defender for Endpoint unique device ID
        [Parameter(Mandatory=$true,
            ParameterSetName='DeviceID')]
        [ValidateNotNullOrEmpty()]
        [String]$DeviceID,

        # List all devices
        [Parameter(Mandatory=$false,
            ParameterSetName='All')]
        [switch]$All,

        # The HealthStatus of the device
        [Parameter(Mandatory=$false,
            ParameterSetName='All')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Inactive','Active')]
        [String]$HealthStatus,

        # The device Risk Score
        [Parameter(Mandatory=$false,
            ParameterSetName='All')]
        [ValidateSet('None','Low','Medium','High')]
        [String]$RiskScore,

        # The device exposure level
        [Parameter(Mandatory=$false,
            ParameterSetName='All')]
        [ValidateSet('None','Low','Medium','High')]
        [String]$ExposureLevel,

        # Device Value
        [Parameter(Mandatory=$false,
            ParameterSetName='All')]
        [ValidateSet('Low','Normal','High')]
        [string]$DeviceValue,

        # Device onboarding status
        [Parameter(Mandatory=$false,
            ParameterSetName='All')]
        [ValidateSet('Onboarded','Can be onboarded')]
        [string]$onboardingStatus,

        # API Token
        [Parameter(Mandatory=$false)]
        $token
    )

    Try{
        If($PSBoundParameters.containsKey('token')){
            $token = $token
        }
        Else{
            $token = Get-PSMDAPIToken -API "MDE"
        }

        $url = "https://api.securitycenter.microsoft.com/api/machines"

        If($PSBoundParameters.ContainsKey("DeviceName")){
            $url = "https://api.securitycenter.microsoft.com/api/machines?`$filter=startswith(computerDnsName,'$DeviceName')"
        }

        If($PSBoundParameters.ContainsKey("DeviceID")){
            $url = "https://api.securitycenter.microsoft.com/api/machines/$DeviceID"
        }

        If($PSBoundParameters.ContainsKey("All")){
            $url = "https://api.securitycenter.microsoft.com/api/machines"
        }

        $optionalfilter=0
        If($PSBoundParameters.ContainsKey("DeviceValue") -or $PSBoundParameters.ContainsKey("HealthStatus") -or $PSBoundParameters.ContainsKey("RiskScore") -or $PSBoundParameters.ContainsKey("ExposureLevel") -or $PSBoundParameters.ContainsKey("onboardingStatus")){
            Write-Verbose 'optional filters set'
            $url = $url + "?`$filter="
        }

        If($PSBoundParameters.ContainsKey("HealthStatus")){
            $optionalfilter++
            $HealthFilter = "healthStatus eq '$Healthstatus'"
            $url = $url + $HealthFilter
        }

        If($PSBoundParameters.ContainsKey("DeviceValue")){
            $DeviceValueFilter = "deviceValue eq '$DeviceValue'"
            If($optionalfilter -gt 0){
                $url = $url + " and " + $DeviceValueFilter
            }
            Else{
                $optionalfilter++
                $url = $url + $DeviceValueFilter
            }
        }

        If($PSBoundParameters.ContainsKey("RiskScore")){
            $DeviceRiskScoreFilter = "riskScore eq '$riskScore'"
            If($optionalfilter -gt 0){
                $url = $url + " and " + $DeviceRiskScoreFilter
            }
            Else{
                $optionalfilter++
                $url = $url + $DeviceRiskScoreFilter
            }
        }

        If($PSBoundParameters.ContainsKey("ExposureLevel")){
            $DeviceExposureLevelFilter = "exposureLevel eq '$ExposureLevel'"
            If($optionalfilter -gt 0){
                $url = $url + " and " + $DeviceExposureLevelFilter
            }
            Else{
                $optionalfilter++
                $url = $url + $DeviceExposureLevelFilter
            }
        }


        If($PSBoundParameters.ContainsKey("onboardingStatus")){
            $DeviceOnboardingStatusFilter = "onboardingStatus eq '$onboardingStatus'"
            If($optionalfilter -gt 0){
                $url = $url + " and " + $DeviceOnboardingStatusFilter
            }
            Else{
                $optionalfilter++
                $url = $url + $DeviceOnboardingStatusFilter
            }
        }

        Write-Verbose $url
        $headers = @{
            'Content-Type'  = 'application/json'
            'Accept'        = 'application/json'
            'Authorization' = "Bearer $token"
        }
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $response = Invoke-WebRequest -Method Get -Uri $url -Headers $headers -ErrorAction Stop

        If ($response.StatusCode -eq 200){
            $Devices =  ($response | ConvertFrom-Json)

            If ($Devices.value -ne $Null){
                $Devices.Value
            }
            Else{
                $Devices
            }
        }
        elseif($response.StatusCode -eq 429){
            Write-Error $Error[0]
        }
    }
    catch{
        Write-Error $_
    }
}
