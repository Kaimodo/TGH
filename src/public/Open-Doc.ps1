function Open-Doc {


<#
.SYNOPSIS
	Sets the working directory to the user's documents folder
.DESCRIPTION
	This scripts changes the working directory to the user's documents folder.
.EXAMPLE
	PS> ./cd-docs
	📂/home/markus/Documents

.NOTES
	Author: Kai Krutscho

.LINK
	https://www.github.com/Kaimodo/TGH

#>


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
				$TargetDir = resolve-path "$HOME/Documents"
				if (-not(test-path "$TargetDir" -pathType container)) {
					throw "Documents folder at 📂$TargetDir doesn't exist (yet)"
				}
				set-location "$TargetDir"
				"📂$TargetDir"
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
