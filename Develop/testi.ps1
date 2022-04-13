
       $ConfigFileDir =  [IO.Directory]::GetParent($PSScriptRoot)
        $PSMDConfigFile = "$ConfigFileDir\" +  "PSMDConfig.json"
        Write-Output "PSMD ConfigFile: $PSMDConfigFile"
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
            resource      = $resourceAppIdUri
            client_id     = $clientId
            client_secret = $appSecret
            grant_type    = 'client_credentials'
        }

        $authResponse = Invoke-RestMethod -Method Post -Uri $oAuthUri -Body $authBody -ErrorAction Stop
        $token = $authResponse.access_token
        #Out-File -FilePath "./Latest-token.txt" -InputObject $token
        #return $token

             $url = "https://api.security.microsoft.com/api/incidents?$filter=lastUpdateTime+ge+$dateTime"

        # Set the webrequest headers
        $headers = @{
            'Content-Type'  = 'application/json'
            'Accept'        = 'application/json'
            'Authorization' = "Bearer $token"
        }

        # Send the request and get the results.
        $response = Invoke-WebRequest -Method Get -Uri $url -Headers $headers -ErrorAction Stop

        # Extract the incidents from the results.
        $incidents =  ($response | ConvertFrom-Json).value | ConvertTo-Json -Depth 99
        $incidents


