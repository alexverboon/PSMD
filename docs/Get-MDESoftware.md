---
external help file: PSMD-help.xml
Module Name: PSMD
online version:
schema: 2.0.0
---

# Get-MDESoftware

## SYNOPSIS
Get-MDESoftware

## SYNTAX

### SoftwareName
```
Get-MDESoftware -SoftwareName <String> [-token <Object>] [<CommonParameters>]
```

### SoftwareVendor
```
Get-MDESoftware -SoftwareVendor <String> [-token <Object>] [<CommonParameters>]
```

### SoftwareId
```
Get-MDESoftware -SoftwareId <String> [-token <Object>] [<CommonParameters>]
```

### All
```
Get-MDESoftware [-All] [-token <Object>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve Microsoft Defender for Endpoint Software Inventory information

## EXAMPLES

### EXAMPLE 1
```
Get-MDESoftware -All
```

List all software with a product code (CPE)

### EXAMPLE 2
```
Get-MDESoftware -SoftwareId microsoft-_-defender_for_mac
```

List all software that has the specified software id

### EXAMPLE 3
```
Get-MDESoftware -SoftwareVendor microsoft
```

List all software from the specified vendor

### EXAMPLE 4
```
Get-MDESoftware -SoftwareName edge_chromium-based
```

List the specified software

## PARAMETERS

### -SoftwareName
Software product name

```yaml
Type: String
Parameter Sets: SoftwareName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SoftwareVendor
Software Vendor Name

```yaml
Type: String
Parameter Sets: SoftwareVendor
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SoftwareId
Software id

```yaml
Type: String
Parameter Sets: SoftwareId
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
List all software

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: True
Position: Named
Default value: False
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

### Microsoft Defender for Endpoint Software Inventory information
## NOTES

## RELATED LINKS
