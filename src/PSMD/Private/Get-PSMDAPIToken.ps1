<#
.SYNOPSIS
    Get-PSMDAPIToken
.DESCRIPTION
    This script gets the app context token
.EXAMPLE

.OUTPUTS
    API token
.NOTES

.COMPONENT
    PSMD
#>
Function Get-PSMDAPIToken{
    [CmdletBinding()]
    param (
        # API
        [Parameter(Mandatory=$false,ParameterSetName='All')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('MD','MDE','MDO','MDI','MDCA')]
        [String]$API
    )

    Try{


        $ConfigFileDir =  [IO.Directory]::GetParent($PSScriptRoot)
        $PSMDConfigFile = "$ConfigFileDir\" +  "PSMDConfig.json"
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

        switch ($API){
            'MD'{
                $resourceAppIdUri = 'https://api.security.microsoft.com'
            }
            'MDE'{
                $resourceAppIdUri = 'https://api.securitycenter.microsoft.com'
            }
            'MDO'{
                $resourceAppIdUri = 'notdefined'
            }
            'MDI'{
                $resourceAppIdUri = 'notdefined'
            }
            "MDCA"{
                $resourceAppIdUri = 'notdefined'
            }
            Default {
                $resourceAppIdUri = 'https://api.security.microsoft.com'
            }
        }

        $oAuthUri = "https://login.windows.net/$tenantId/oauth2/token"
        $authBody = [Ordered] @{
            resource      = $resourceAppIdUri
            client_id     = $clientId
            client_secret = $appSecret
            grant_type    = 'client_credentials'
        }

        $authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
        $token = $authResponse.access_token
        return $token
    }
    Catch{
        Throw{}
    }
}