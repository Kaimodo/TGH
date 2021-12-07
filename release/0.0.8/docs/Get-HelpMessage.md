---
external help file: TGH-help.xml
Module Name: TGH
online version: https://github.com/lazywinadmin/PowerShell
schema: 2.0.0
---

# Get-HelpMessage

## SYNOPSIS
Function to explain why an error occurred and provides problem-solving information.
Equivalent of NET HELPMSG

## SYNTAX

```
Get-HelpMessage [[-Id] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Function to explain why an error occurred and provides problem-solving information.
Equivalent of NET HELPMSG.
The function also create an alias called HelpMsg, so you can call the function this way:
HelpMsg 618

## EXAMPLES

### BEISPIEL 1
```
Get-HelpMessage 618
```

The specified compression format is unsupported

### BEISPIEL 2
```
Get-HelpMessage 0x80070652
```

Another installation is already in progress.
Complete that installation before proceeding with this install

### BEISPIEL 3
```
Get-HelpMessage -2147023278
```

Another installation is already in progress.
Complete that installation before proceeding with this install

## PARAMETERS

### -Id
Specify the ID of the error you want to retrieve.
Can be decimal, hexadecimal

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
http://www.leeholmes.com/blog/2009/09/15/powershell-equivalent-of-net-helpmsg/

## RELATED LINKS

[https://github.com/lazywinadmin/PowerShell](https://github.com/lazywinadmin/PowerShell)

