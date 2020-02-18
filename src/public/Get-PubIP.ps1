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
        Function Catch-Options {
            Param(
                [Parameter(Mandatory=$true)][string]$message
                , [Parameter(Mandatory=$true)][ValidateSet("Fail","Caution","Pass")]$outputoption
            )
            Process
            {
                switch ($outputoption)
                {
                    "Fail" { Write-Error $message }
                    "Caution" { Write-Warning $message }
                    "Pass" { Write-Output $message }
                }
            }
        }
    }
    process {

        try {
            Write-Verbose "$($FunctionName): Getting Public IP Address"
            Write-Host "$($FunctionName): Getting Public IP Address" -ForegroundColor Green
            Invoke-RestMethod -Uri ('http://ipinfo.io/'+(Invoke-WebRequest -uri "http://ifconfig.me/ip").Content)
        }
        catch [Exception]{
            Catch-Options -message (("(" + $MyInvocation.MyCommand.Name).ToString() + ") " + $_.Exception.Message) -outputoption $outputoption
        }
    }
    end {
        Write-Verbose "$($FunctionName): End."
        $ErrorActionPreference = $TempErrAct
    }
}
