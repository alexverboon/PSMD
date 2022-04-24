---
external help file: PSMD-help.xml
Module Name: PSMD
online version:
schema: 2.0.0
---

# Get-MDIncident

## SYNOPSIS
Get-MDIncidents

## SYNTAX

```
Get-MDIncident [[-Hours] <Int32>] [[-Severity] <String>] [[-token] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve Microsoft 365 Defender Incidents

## EXAMPLES

### EXAMPLE 1
```
Get-MDIncidents
```

## PARAMETERS

### -Hours
Number of hours

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Severity
Severity of the Incident

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Microsoft 365 Defender Incidents
## NOTES

## RELATED LINKS
