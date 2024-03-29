function Show-Fish {

<#
.SYNOPSIS
    Shows some Fish
.DESCRIPTION
	Fish 4 free
.EXAMPLE
	PS C:\> Show-Fish
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
				# Generates 5 fish
				1..5|
				ForEach-Object{

					# Set random number of spaces
					$Spaces = " "* (Get-Random -Maximum 80)

					# Bubbles object 1
					$Bubbles1 = "
					$Spaces       o
					$Spaces      o"

					# Bubbles object 2
					$Bubbles2 = "
					$Spaces         o"

					# Fish 1 object
					$Fish1 = "
					$Spaces     <o)))><"

					# Fish 2 object
					$Fish2 = "
					$Spaces     ><(((o>"

					# Fish 3 object
					$Fish3 = "
					$Spaces       _____
					$Spaces     /       \
					$Spaces     | O .   |
					$Spaces     \ .     /
					$Spaces      |     |
					$Spaces      ( 0 0 )
					$Spaces      / / \ \__
					$Spaces    )/ /|||\ \(
					$Spaces  _(( /(( ))\ ))(("

					# Fish 4 object
					$Fish4 = "
					$Spaces      ^
					$Spaces    -----
					$Spaces  <--o-0-->
					$Spaces   -------
					$Spaces    -----"

					# Fish 5 object
					$Fish5 = "
					$Spaces      ><(((o>
					$Spaces             ><(((o>
					$Spaces  ><(((o>"

					# Choose random bubbles
					$myBubbles = New-Object System.Collections.ArrayList
					$myBubbles.Add("$Bubbles1") | Out-Null
					$myBubbles.Add("$Bubbles2") | Out-Null
					$RandomBubbles = Get-Random -Maximum 3
					$DisplayBubbles = $myBubbles[$RandomBubbles]

					# Choose random fish
					$myFish = New-Object System.Collections.ArrayList
					$myFish.Add("$Fish1") | Out-Null
					$myFish.Add("$Fish2") | Out-Null
					$myFish.Add("$Fish3") | Out-Null
					$myFish.Add("$Fish4") | Out-Null
					$myFish.Add("$Fish5") | Out-Null
					$RandomFish = Get-Random -Maximum 5
					$DisplayFish = $myFish[$RandomFish]

					Write-Output "$DisplayBubbles"
					Write-Output "$DisplayFish"

					# Delay the print
					sleep .75
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
