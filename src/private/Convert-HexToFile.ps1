function Convert-HexToFile {

    <#
    .SYNOPSIS
        Convert a given Hex File to a File
    .DESCRIPTION
        For Converting eg. an Exe-File into an Hex-String File
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
        begin{

            if ($script:ThisModuleLoaded -eq $true) {
                Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
            }
            $FunctionName = $MyInvocation.MyCommand.Name
            Write-Verbose "$($FunctionName): Begin"
            $TempErrAct = $ErrorActionPreference
            $ErrorActionPreference = "Stop"
        }

        # This block is used to provide record-by-record processing for the function.
        process{
                Write-Verbose "$($FunctionName): Process"
            try{
                    Write-Verbose "$($FunctionName): Process.try"
                    try {

                        [string]$content = Get-Content -Path $FilePath
                    }
                    catch {
                        throw "Failed to read file. Ensure that you have permission to the file, and that the file path is correct.";
                    }
                    if ($content) {
                        [Byte[]] $temp = $content -split ' '
                        [System.IO.File]::WriteAllBytes($OutFile, $temp)
                    }
                    else {
                        throw '$ByteArray is $null.';
                    }
            }catch{
                Write-Verbose "$($FunctionName): Process.catch"
                    "Stuff Failed" | Write-Error

                $ExceptionLevel   = 0
                $BagroundColorErr = 'DarkRed'
                $e                = $_.Exception
                $Msg              = "[$($ExceptionLevel)] {$($e.Source)} $($e.Message)"
                $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Host -ForegroundColor Yellow -BackgroundColor $BagroundColorErr
                $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Output

                while($e.InnerException)
                {
                    $ExceptionLevel++
                    if($ExceptionLevel % 2 -eq 0)
                    {
                        $BagroundColorErr = 'DarkRed'
                    }
                    else
                    {
                        $BagroundColorErr='Black'
                    }

                    $e = $e.InnerException

                    $Msg = "[$($ExceptionLevel)] {$($e.Source)} $($e.Message)"
                    $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Host -ForegroundColor Yellow -BackgroundColor $BagroundColorErr
                    $Msg.PadLeft($Msg.Length + (2*$ExceptionLevel)) | Write-Output
            }
          }
        }

        # This block is used to provide optional one-time post-processing for the function.
        end{
                Write-Verbose "$($FunctionName): End."
                $ErrorActionPreference = $TempErrAct
        }
    }