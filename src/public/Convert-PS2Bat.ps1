function Convert-PS2Bat {


<#
.SYNOPSIS
	Converts PowerShell scripts to batch files
.DESCRIPTION
	This script converts one or more PowerShell scripts to .bat batch files.
.PARAMETER Filepattern
	Specifies the file pattern
.EXAMPLE
	PS> ./convert-ps2bat *.ps1

.NOTES
	Author: Kai Krutscho

.LINK
	https://www.github.com/Kaimodo/TGH

#>

    [CmdletBinding()]
    param(

		[Parameter(Position=0, Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[System.String]
		$Filepattern = ""
	)

	#return "$Param01 $Param02"

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
			$encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $Path -Raw -Encoding UTF8)))
			$newPath = [Io.Path]::ChangeExtension($Path, ".bat")
			"@echo off`npowershell.exe -NoExit -encodedCommand $encoded" | Set-Content -Path $newPath -Encoding Ascii
    	try{
				Write-Verbose "$($FunctionName): Process.try"
				if ($Filepattern -eq "") { $Filepattern = read-host "Enter path to the PowerShell script(s)" }

				$Files = get-childItem -path "$Filepattern"
				foreach ($File in $Files) {
					Convert-PowerShellToBatch "$File"
				}
				exit 0 # success

    	}catch{
			Write-Verbose "$($FunctionName): Process.catch"


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
