function Get-GitSheet {
    <#
    .SYNOPSIS
    Show basic Git Commands
    .DESCRIPTION
    Show a Cheet Sheet of the most basic Git Commands
    .LINK
    https://github.com/kaimodo/ToModule.git
    .EXAMPLE
    TBD
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
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git clone "
            Write-Host -NoNewline -ForegroundColor "Red" "https://github.com/"
            Write-Host -NoNewline -ForegroundColor "Green" "<USERNAME>/<REPO>"
            Write-Host -ForegroundColor "Red" ".git"

            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git add "
            Write-Host -ForegroundColor "Green" "."

            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git commit "
            Write-Host -NoNewline -ForegroundColor "Red" "-m "
            Write-Host -ForegroundColor "Green" "'<MESSAGE>'"

            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git push "
            Write-Host -NoNewline -ForegroundColor "Red" "origin "
            Write-Host -ForegroundColor "Green" "Main"

            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git remote set-url "
            Write-Host -NoNewline -ForegroundColor "Red" "origin "
            Write-Host -NoNewline -ForegroundColor "Red" "https://github.com/"
            Write-Host -NoNewline -ForegroundColor "Green" "<USERNAME>/<REPO>"
            Write-Host -ForegroundColor "Red" ".git"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"

            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git remote add "
            Write-Host -NoNewline -ForegroundColor "Red" "origin "
            Write-Host -NoNewline -ForegroundColor "Red" "https://github.com/"
            Write-Host -NoNewline -ForegroundColor "Green" "<USERNAME>/<REPO>"
            Write-Host -ForegroundColor "Red" ".git"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"

            Write-Host -ForegroundColor "Blue" "-------------------No History---------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git checkout "
            Write-Host -NoNewline -ForegroundColor "Red" "--orphan "
            Write-Host -ForegroundColor "Green" "latest_branch"

            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git add "
            Write-Host -ForegroundColor "Green" "-A"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git commit "
            Write-Host -NoNewline -ForegroundColor "Red" "-am "
            Write-Host -ForegroundColor "Green" "'<MESSAGE>'"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git branch "
            Write-Host -NoNewline -ForegroundColor "Red" "-D "
            Write-Host -ForegroundColor "Green" "Main"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git branch "
            Write-Host -NoNewline -ForegroundColor "Red" "-m "
            Write-Host -ForegroundColor "Green" "Main"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git push "
            Write-Host -NoNewline -ForegroundColor "Red" "origin "
            Write-Host -ForegroundColor "Green" "Main"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -ForegroundColor "Blue" "--------------------------Remove Origin-----------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git remote remove "
            Write-Host -NoNewline -ForegroundColor "Red" "origin "
            Write-Host -ForegroundColor "Green" "Main"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"
            Write-Host -ForegroundColor "Blue" "----------------------------Force Push------------------------------------"
            Write-Host -NoNewline -ForegroundColor "DarkCyan" "PS C:\> "
            Write-Host -NoNewline -ForegroundColor "White" "git push "
            Write-Host -NoNewline -ForegroundColor "Red" "-f origin "
            Write-Host -ForegroundColor "Green" "Main"
            Write-Host -ForegroundColor "Blue" "--------------------------------------------------------------------------"


        }
        catch {

            $ExceptionLevel = 0
            $BagroundColorErr = 'DarkRed'
            $e = $_.Exception
            $Msg = "[$($ExceptionLevel)] {$($e.Source)} $($e.Message)"
            $Msg.PadLeft($Msg.Length + (2 * $ExceptionLevel)) | Write-Host -ForegroundColor Yellow -BackgroundColor $BagroundColorErr
            $Msg.PadLeft($Msg.Length + (2 * $ExceptionLevel)) | Write-Output

            while ($e.InnerException) {
                $ExceptionLevel++
                if ($ExceptionLevel % 2 -eq 0) {
                    $BagroundColorErr = 'DarkRed'
                }
                else {
                    $BagroundColorErr = 'Black'
                }

                $e = $e.InnerException

                $Msg = "[$($ExceptionLevel)] {$($e.Source)} $($e.Message)"
                $Msg.PadLeft($Msg.Length + (2 * $ExceptionLevel)) | Write-Host -ForegroundColor Yellow -BackgroundColor $BagroundColorErr
                $Msg.PadLeft($Msg.Length + (2 * $ExceptionLevel)) | Write-Output
                }
            }
        }
    end {
        Write-Verbose "$($FunctionName): End."
        $ErrorActionPreference = $TempErrAct
    }
}