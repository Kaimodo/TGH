function New-Speak {

<#
.SYNOPSIS
    Speak out something

.DESCRIPTION
	Speaks the Given Input in the given Language

.PARAMETER Text
	The Text to speak

.PARAMETER File
	The File which content should be Speak
.PARAMETER Language
	The Speaking Language (default is German)

.EXAMPLE
	PS C:\> New-Speak -Text "Speak This" -Language "English"

.EXAMPLE
	PS C:\> New-Speak -File "Test.txt"

.INPUTS
	System.String

.OUTPUTS
	System.String

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

		[Parameter(Position=0, Mandatory=$false)]
		[ValidateNotNullOrEmpty()]
		[System.String]
		$Text,

		[Parameter(Position=1, Mandatory=$false)]
		[ValidateNotNull()]
		[System.String]
		$File,

		[Parameter(Position=2, Mandatory=$false)]
		[ValidateNotNull()]
		[System.String]
		$Language

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
    	try{
				Write-Verbose "$($FunctionName): Process.try"
				try {
					if ("$text" -ne "") {
						$TTSVoice = New-Object -ComObject SAPI.SPVoice
						foreach ($Voice in $TTSVoice.GetVoices()) {
							if ($Voice.GetDescription() -like "*- $($Language)*") {
								$TTSVoice.Voice = $Voice
								[void]$TTSVoice.Speak($text)
								exit 0 # success
							}
						}
					 }
					 if ($File -ne "") {
						$text = Get-Content $File
						$TTSVoice = New-Object -ComObject SAPI.SPVoice
						foreach ($Voice in $TTSVoice.GetVoices()) {
							if ($Voice.GetDescription() -like "*- $($Language)*") {
								$TTSVoice.Voice = $Voice
								[void]$TTSVoice.Speak($text)
								exit 0 # success
							}
						}

					  }
				} catch {
					"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
					$ErrorMessage = $_.Exception.Message
					$FailedItem = $_.Exception.ItemName
					Write-Output "`n $ErrorMessage "
					Write-Output "`n $FailedItem "
				}

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
