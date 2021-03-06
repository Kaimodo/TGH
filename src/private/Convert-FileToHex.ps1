function Convert-FileToHex {

    <#
    .SYNOPSIS
        Convert a given File to a Hex File
    .DESCRIPTION
        For COnverting eg. an Exe-File into an Hex-String File
    .PARAMETER FilePath
        The Input File
    .PARAMETER OutFile
        The Output File
    .EXAMPLE
        PS C:\> Convert-FileToHex -FilePath 'C:\tmp\psexec.ece' -OutFile 'C:\tmp\psexec.hex'
        Converts psexec into a hex File. this can be later reconverted
    .INPUTS
        System.File
    .OUTPUTS
        System.File
    .NOTES
        Author: Kai Krutscho
    .LINK
        https://www.github.com/kaimodo/TGH.git
    #>

        [CmdletBinding()] param (
            [Parameter(ValueFromPipeline = $true,
                    ValueFromPipelineByPropertyName = $true)]
                    [string[]]$FilePath = $env:TEMP,
            [Parameter(ValueFromPipeline = $true,
                    ValueFromPipelineByPropertyName = $true)]
                    [string[]]$OutFile = $env:TEMP
            )


        # This block is used to provide optional one-time pre-processing for the function.
        begin {

            if ($script:ThisModuleLoaded -eq $true) {
                Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
            }
            $FunctionName = $MyInvocation.MyCommand.Name
            Write-Verbose "$($FunctionName): Begin"
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

        # This block is used to provide record-by-record processing for the function.
        process {
            Write-Verbose "$($FunctionName): Process"
            try {
                Write-Verbose "$($FunctionName): Process.try"
                try {
                    [byte[]] $content = Get-Content -Path $FilePath -Encoding Byte
                }
                catch {
                    throw "Failed to read file. Ensure that you have permission to the file, and that the file path is correct.";
                }

                if ($content) {
                    [System.IO.File]::WriteAllLines($OutFile, ([string]$content))
                }
                else {
                    throw '$content is $null.';
                }
            }
            catch [Exception] {
                Write-Verbose "$($FunctionName): Process.catch"
                echo $_.Exception|format-list -force
            }
        }

        # This block is used to provide optional one-time post-processing for the function.
        end {
            Write-Verbose "$($FunctionName): End."
            $ErrorActionPreference = $TempErrAct
        }
    }