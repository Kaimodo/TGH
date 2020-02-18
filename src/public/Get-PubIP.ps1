function Get-PubIP {
    <#
    .SYNOPSIS
    Small little Helper for Public IP
    .DESCRIPTION
    Just use to get your current Public IP Address
    .LINK
    https://www.github.com/Kaimodo/TGH.git
    .EXAMPLE
    Get-PubIP
    .NOTES
    Author: Kai Krutscho
    #>

    [CmdletBinding()]
    param(
    )
    begin {
        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
        $TempErrAct = $ErrorActionPreference
        $ErrorActionPreference = "Stop"
    }
    process {

        try {
            Write-Verbose "$($FunctionName): Getting Public IP Address"
            Write-Host "$($FunctionName): Getting Public IP Address" -ForegroundColor Green
            Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)
        }
        catch {
            Write-Verbose "$($FunctionName): Process.catch"
            "Stuff Failed" | Write-Error

            $ExceptionLevel = 0
            $BagroundColorErr = 'DarkRed'
            $e = $_.Exception
            $Msg = "[$($ExceptionLevel)] {$($e.Source)} $($e.Message)"
            $Msg.PadLeft($Msg.Length + (2 * $ExceptionLevel)) | Write-Host -ForegroundColor Yellow -BackgroundColor $BagroundColorErr
            $Msg.PadLeft($Msg.Length + (2 * $ExceptionLevel)) | Write-Output
            }
        }
    end {
        Write-Verbose "$($FunctionName): End."
        $ErrorActionPreference = $TempErrAct
    }
}
