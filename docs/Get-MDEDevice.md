---
external help file: PSMD-help.xml
Module Name: PSMD
online version:
schema: 2.0.0
---

# Get-MDEDevice

## SYNOPSIS
Get-MDEDevice

## SYNTAX

### DeviceName
```
Get-MDEDevice -DeviceName <String> [-token <Object>] [<CommonParameters>]
```

### DeviceID
```
Get-MDEDevice -DeviceID <String> [-token <Object>] [<CommonParameters>]
```

### All
```
Get-MDEDevice [-All] [-HealthStatus <String>] [-RiskScore <String>] [-ExposureLevel <String>]
 [-DeviceValue <String>] [-onboardingStatus <String>] [-token <Object>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve Microsoft Defender for Endpoint device information

## EXAMPLES

### EXAMPLE 1
```
Get-MDEDevice -All
```

List all devices in Microsoft Defender for endpoint

### EXAMPLE 2
```
Get-MDEDevice -DeviceName testmachine38
```

Retrieve details for the specified device

### EXAMPLE 3
```
Get-MDEDevice -RiskScore High
```

Retrieve all devices with a high risk score

## PARAMETERS

### -DeviceName
Device ComputerDNSName

```yaml
Type: String
Parameter Sets: DeviceName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceID
Microsoft Defender for Endpoint unique device ID

```yaml
Type: String
Parameter Sets: DeviceID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
List all devices

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -HealthStatus
Health Status

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RiskScore
Device RiskScore

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExposureLevel
The device exposure level

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeviceValue
Device Value

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -onboardingStatus
Device Onboarding status

```yaml
Type: String
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -token
Token to use for authentication

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft Defender for Endpoint device information
## NOTES

## RELATED LINKS
