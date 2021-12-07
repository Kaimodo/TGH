---
external help file: TGH-help.xml
Module Name: TGH
online version: https://www.github.com/Kaimodo/TGH
schema: 2.0.0
---

# New-Speak

## SYNOPSIS
Speak out something

## SYNTAX

```
New-Speak [[-Text] <String>] [[-File] <String>] [[-Language] <String>] [<CommonParameters>]
```

## DESCRIPTION
Speaks the Given Input in the given Language

## EXAMPLES

### BEISPIEL 1
```
New-Speak -Text "Speak This" -Language "English"
```

### BEISPIEL 2
```
New-Speak -File "Test.txt"
```

## PARAMETERS

### -Text
The Text to speak

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -File
The File which content should be Speak

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

### -Language
The Speaking Language (default is German)

```yaml
Type: String
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

### System.String

## OUTPUTS

### System.String

## NOTES
Author: Kai Krutscho

## RELATED LINKS

[https://www.github.com/Kaimodo/TGH](https://www.github.com/Kaimodo/TGH)

