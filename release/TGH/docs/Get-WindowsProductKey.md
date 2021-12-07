---
external help file: TGH-help.xml
Module Name: TGH
online version: https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Function/Get-WindowsProductKey.README.md
schema: 2.0.0
---

# Get-WindowsProductKey

## SYNOPSIS
Get the Windows product key and some usefull informations about the system

## SYNTAX

```
Get-WindowsProductKey [[-ComputerName] <String[]>] [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Get the Windows product key from a local or remote system and some informations like Serialnumber, Windows version, Bit-Version etc.
from one or more computers.
Remote computers need WinRM enabled.
To do this use "winrm quickconfig".

Basic Logic found on: http://powershell.com/cs/blogs/tips/archive/2012/04/30/getting-windows-product-key.aspx

## EXAMPLES

### BEISPIEL 1
```
Get-WindowsProductKey
```

ComputerName   : TEST-PC-01
WindowsVersion : Microsoft Windows 10 Pro
CSDVersion     :
BitVersion     : 64-bit
BuildNumber    : 10586
ProductID      : 00000-00000-00000-00000
ProductKey     : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

### BEISPIEL 2
```
Get-WindowsProductKey -ComputerName TEST-PC-01,TEST-PC-02
```

ComputerName   : TEST-PC-01
WindowsVersion : Microsoft Windows 10 Pro
CSDVersion     :
BitVersion     : 64-bit
BuildNumber    : 10586
ProductID      : 00000-00000-00000-00000
ProductKey     : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
ComputerName   : TEST-PC-02
WindowsVersion : Microsoft Windows 10 Pro
CSDVersion     :
BitVersion     : 64-bit
BuildNumber    : 10586
ProductID      : 00000-00000-00000-00000
ProductKey     : XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

## PARAMETERS

### -ComputerName
ComputerName or IPv4-Address of the remote computer

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:COMPUTERNAME
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Credentials to authenticate agains a remote computer

```yaml
Type: PSCredential
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

## RELATED LINKS

[https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Function/Get-WindowsProductKey.README.md](https://github.com/BornToBeRoot/PowerShell/blob/master/Documentation/Function/Get-WindowsProductKey.README.md)

