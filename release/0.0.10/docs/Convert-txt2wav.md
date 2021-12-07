---
external help file: TGH-help.xml
Module Name: TGH
online version: https://www.github.com/Kaimodo/TGH
schema: 2.0.0
---

# Convert-txt2wav

## SYNOPSIS
Converts text to a .WAV audio file

## SYNTAX

```
Convert-txt2wav [-Text] <String> [[-WavFile] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
This script converts text to a .WAV audio file.

## EXAMPLES

### BEISPIEL 1
```
./convert-txt2wav "Hello World" spoken.wav
```

## PARAMETERS

### -Text
Specifies the text to use

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

### -WavFile
Specifies the path to the resulting WAV file

```yaml
Type: Int32
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

## OUTPUTS

## NOTES
Author: Kai Krutscho

## RELATED LINKS

[https://www.github.com/Kaimodo/TGH](https://www.github.com/Kaimodo/TGH)

