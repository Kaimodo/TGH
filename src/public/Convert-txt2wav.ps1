function Convert-txt2wav {

<#
.SYNOPSIS
	Converts text to a .WAV audio file
.DESCRIPTION
	This script converts text to a .WAV audio file.
.PARAMETER text
	Specifies the text to use
.PARAMETER WavFile
	Specifies the path to the resulting WAV file
.EXAMPLE
	PS> ./convert-txt2wav "Hello World" spoken.wav

.NOTES
	Author: Kai Krutscho

.LINK
	https://www.github.com/Kaimodo/TGH

#>

    [CmdletBinding()]
    param(

        # parameter options
        # validation
        # cast
        # name and default value

		[Parameter(Position=0, Mandatory=$true)]
		[ValidateNotNullOrEmpty()]
		[System.String]
		$Text = "",

		[Parameter(Position=1)]
		[ValidateNotNull()]
		[System.Int32]
		$WavFile = ""

	)

    begin{

        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin"
        $TempErrAct = $ErrorActionPreference
        $ErrorActionPreference = "Stop"
    }

    process{
			Write-Verbose "$($FunctionName): Process"
    	try{
				Write-Verbose "$($FunctionName): Process.try"
				if ($Text -eq "") { $Text = read-host "Enter text to speak" }
				if ($WavFile -eq "") { $WavFile = read-host "Enter .WAV file to save to" }

				Add-Type -AssemblyName System.Speech
				$SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
				$SpeechSynthesizer.SetOutputToWaveFile($tWavFile)
				$SpeechSynthesizer.Speak($Text)
				$SpeechSynthesizer.Dispose()
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
