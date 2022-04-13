<#
.Synopsis
   Test-MapsConnection
.DESCRIPTION
   Use Test-MapsConnection to verify that your client can
   communicate with the Windows Defender Antivirus cloud service

.EXAMPLE
   Test-MapsConnection

   The above command verifies connectivity with the Windows Defender Antivirus cloud service (MAPS)

.NOTES
    Author: Alex Verboon
    Date: 01.08.2020
    Version 1.2
    Comment: Updated code formatting and added an additional check to find mpcmdrun.exe
 #>
Function Test-MDMapsConnection{
    [CmdletBinding()]
    Param()
    Begin{
        If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")){
            Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
            Break
        }
    }
    Process{
        # Find the current most recent path of the Defender mpcmdrun.exe
        $DefenderPlatformPath = "C:\ProgramData\Microsoft\Windows Defender\Platform"
        If (Test-Path -Path $DefenderPlatformPath -PathType Container){
            $mpcmdrunpath = (Get-ChildItem  -Path "$DefenderPlatformPath\*\mpcmdrun.exe" | Select-Object * -Last 1).FullName
            If ([string]::IsNullOrEmpty($mpcmdrunpath)){
                Write-Warning "Unable to locate mpcmdrun.exe in path $DefenderPlatformPath\..."
                break
            }
            Else{
                Write-Verbose "Defender mpcmdrun path: $mpcmdrunpath"
                $cmdArg =  "-validatemapsconnection"
                $CheckResult = Start-Process -FilePath "$mpcmdrunpath" -ArgumentList "$cmdArg" -WindowStyle Hidden -PassThru -Wait
                $MAPSConnectivity = switch ($CheckResult.ExitCode){
                    0{$true}
                    default {$false}
                }
            }
        }
        Else{
            Write-Warning "$DefenderPlatformPath not found"
            break
        }

        If ($MAPSConnectivity -eq "True"){
            Write-Verbose "ValidateMapsConnection successfully established a connection to MAPS"
        }
        Else{
            $MapsErrorDetail = ($CheckResult.ExitCode).ToString()
            Write-Verbose "ValidateMapsConnection failed: $MapsErrorDetail"

            If ($MapsErrorDetail -ccontains "-2147012889"){
                Write-Verbose "The server name or address could not be resolved"
            }
            Write-Verbose "Find more troubleshooting guidance here: https://yongrhee.wordpress.com/2020/04/11/microsoft-defender-antivirus-mdav-cloud-protection-cloud-delivered-protection-aka-maps/"
        }
        $MAPSConnectivity
    }
    End{}
}
