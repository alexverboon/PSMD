<#
.SYNOPSIS
    Get-MDESoftware
.DESCRIPTION
    Retrieve Microsoft Defender for Endpoint Software Inventory information
.EXAMPLE
    Get-MDESoftware -All

    List all software with a product code (CPE)

.EXAMPLE
    Get-MDESoftware -SoftwareId microsoft-_-defender_for_mac

    List all software that has the specified software id

.EXAMPLE
    Get-MDESoftware -SoftwareVendor microsoft

    List all software from the specified vendor

.EXAMPLE
    Get-MDESoftware -SoftwareName edge_chromium-based

    List the specified software

.PARAMETER SoftwareName
    Software product name
.PARAMETER SoftwareVendor
    Software Vendor Name
.PARAMETER SoftwareId
    Software id
.PARAMETER All
    List all software
.PARAMETER Token
    Token to use for authentication
.OUTPUTS
    Microsoft Defender for Endpoint Software Inventory information
.NOTES

.COMPONENT
    PSMD
#>
Function Get-MDESoftware{
    [CmdletBinding()]
    Param(

        # SoftwareName
        [Parameter(Mandatory=$true,
            ParameterSetName='SoftwareName')]
        [ValidateNotNullOrEmpty()]
        [String]$SoftwareName,

        # Software Vendor
        [Parameter(Mandatory=$true,
            ParameterSetName='SoftwareVendor')]
        [ValidateNotNullOrEmpty()]
        [String]$SoftwareVendor,

        # Software id
        [Parameter(Mandatory=$true,
            ParameterSetName='SoftwareId')]
        [ValidateNotNullOrEmpty()]
        [String]$SoftwareId,

        # List all software
        [Parameter(Mandatory=$true,
            ParameterSetName='All')]
        [switch]$All,

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

        If($PSBoundParameters.ContainsKey("SoftwareName")){
            $url = "https://api.securitycenter.microsoft.com/api/Software?`$filter=name eq '$SoftwareName'"
        }

        If($PSBoundParameters.ContainsKey("SoftwareVendor")){
            $url = "https://api.securitycenter.microsoft.com/api/Software?`$filter=vendor eq '$SoftwareVendor'"
        }

        If($PSBoundParameters.ContainsKey("SoftwareId")){
            $url = "https://api.securitycenter.microsoft.com/api/Software?`$filter=id eq '$SoftwareId'"
        }

        If($PSBoundParameters.ContainsKey("All")){
            $url = "https://api.securitycenter.microsoft.com/api/Software"
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
            $Software =  ($response | ConvertFrom-Json)
            $Software.Value
        }
        elseif($response.StatusCode -eq 429){
            Write-Error $Error[0]
        }
    }
    catch{
        Write-Error $_
    }
}
