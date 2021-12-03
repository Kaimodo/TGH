---
external help file: TGH-help.xml
Module Name: TGH
online version: https://www.github.com/kaimodo/TGH
schema: 2.0.0
---

# New-Screenshot

## SYNOPSIS
Take a Screenshot and save it to BMP

## SYNTAX

```
New-Screenshot [-FilePath] <String> [<CommonParameters>]
```

## DESCRIPTION
This function take a screenshot of your computer and saves it to a file of your choosing.
It will only capture a single screen on a multi-monitor setup.

## EXAMPLES

### BEISPIEL 1
```
New-ScreenShot -FilePath C:\Screenshot.bmp
```

This example will capture a screenshot of your current screen and save it to a BITMAP file at C:\ScreenShot.bmp.

## PARAMETERS

### -FilePath
A mandatory parameter that specifies where you'd like the screenshot image to be saved.
If a file is detected in this
path, the function will not allow the capture to happen.
There must be no file at this location.
You may choose file extensions of JPG, JPEG and BMP.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.IO.FileInfo

## NOTES
Author: Kai Krutscho

## RELATED LINKS

[https://www.github.com/kaimodo/TGH](https://www.github.com/kaimodo/TGH)

[about_comment_based_help]()

