# specify the minumum required major PowerShell version that the build script should validate
[version]$script:requiredPSVersion = '5.1.0'

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$CodeCoverageStop = $false

[System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseDeclaredVarsMoreThanAssigments', '')]
$CodeCoveragePercentage = 0