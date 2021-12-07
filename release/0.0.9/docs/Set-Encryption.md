---
external help file: TGH-help.xml
Module Name: TGH
online version: https://www.github.com/kaimodo/TGH.git
schema: 2.0.0
---

# Set-Encryption

## SYNOPSIS
Encrypt a given Pharse into a given File

## SYNTAX

```
Set-Encryption [-FilePath] <String> [[-Pharse] <String>] [<CommonParameters>]
```

## DESCRIPTION
Encrypts a Pharse like a Name or Key into a File.
This can be Decyrpted with Get-Encryption again

## EXAMPLES

### BEISPIEL 1
```
Set-Encryption -FilePath 'C:\key.key' -Pharse 'UltraSecretPasswrd'
```

## PARAMETERS

### -FilePath
The File in which the Pharse should be saved after encryption

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Pharse
The Pharse which should be encrypted

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.File

## NOTES
Author: Kai Krutscho

## RELATED LINKS

[https://www.github.com/kaimodo/TGH.git](https://www.github.com/kaimodo/TGH.git)

[about_comment_based_help]()

