---
external help file: TGH-help.xml
Module Name: TGH
online version: https://github.com/kaimodo/ToModule.git
schema: 2.0.0
---

# Get-ADComputerByUser

## SYNOPSIS
Get's the AD-Computer the specific user was Last Logged on

## SYNTAX

```
Get-ADComputerByUser [[-Name] <String>] [-Full] [<CommonParameters>]
```

## DESCRIPTION
This works ONLY if some Adaptions have been done to the AD, see here :
https://lockstepgroup.com/blog/fun-with-ad-custom-attributes/

## EXAMPLES

### BEISPIEL 1
```
Get-ADComputerByUser -Name "Admin" -Full
```

Seaches the Computer where the Admin was logged on and Displays it with all Properties

## PARAMETERS

### -Name
The Name or part of the UserName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:USERNAME
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Full
Returns the Full Computer Object

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String,
System.Switch

## OUTPUTS

### System.String

## NOTES
Author: Kai Krutscho

## RELATED LINKS

[https://github.com/kaimodo/ToModule.git](https://github.com/kaimodo/ToModule.git)

