---
external help file: TGH-help.xml
Module Name: TGH
online version: https://www.github.com/kaimodo/TGH.git
schema: 2.0.0
---

# Get-Decryption

## SYNOPSIS
Decrypt a given Pharse from a given File

## SYNTAX

```
Get-Decryption [-FilePath] <String> [-Silent] [<CommonParameters>]
```

## DESCRIPTION
Decrypts a Pharse like a Name or Key from a File.
This can be Encyrpted with Set-Decryption

## EXAMPLES

### BEISPIEL 1
```
Get-Decryption -FilePath 'C:\key.key'
```

## PARAMETERS

### -FilePath
The File in which the Pharse is saved

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Silent
Just give the Return, Don't Write the Pharse on the Screen

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

