## Pre-Loaded Module code ##

<#
 Put all code that must be run prior to function dot sourcing here.

 This is a good place for module variables as well. The only rule is that no 
 variable should rely upon any of the functions in your module as they 
 will not have been loaded yet. Also, this file cannot be completely
 empty. Even leaving this comment is good enough.
#>

## PRIVATE MODULE FUNCTIONS AND DATA ##

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
            }
            catch [Exception] {
                Write-Verbose "$($FunctionName): Process.catch"
                echo $_.Exception|format-list -force
            }
        }

        # This block is used to provide optional one-time post-processing for the function.
        end{
                Write-Verbose "$($FunctionName): End."
                $ErrorActionPreference = $TempErrAct
        }
    }

function Get-CallerPreference {
    <#
    .Synopsis
       Fetches "Preference" variable values from the caller's scope.
    .DESCRIPTION
       Script module functions do not automatically inherit their caller's variables, but they can be
       obtained through the $PSCmdlet variable in Advanced Functions.  This function is a helper function
       for any script module Advanced Function; by passing in the values of $ExecutionContext.SessionState
       and $PSCmdlet, Get-CallerPreference will set the caller's preference variables locally.
    .PARAMETER Cmdlet
       The $PSCmdlet object from a script module Advanced Function.
    .PARAMETER SessionState
       The $ExecutionContext.SessionState object from a script module Advanced Function.  This is how the
       Get-CallerPreference function sets variables in its callers' scope, even if that caller is in a different
       script module.
    .PARAMETER Name
       Optional array of parameter names to retrieve from the caller's scope.  Default is to retrieve all
       Preference variables as defined in the about_Preference_Variables help file (as of PowerShell 4.0)
       This parameter may also specify names of variables that are not in the about_Preference_Variables
       help file, and the function will retrieve and set those as well.
    .EXAMPLE
       Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

       Imports the default PowerShell preference variables from the caller into the local scope.
    .EXAMPLE
       Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState -Name 'ErrorActionPreference','SomeOtherVariable'

       Imports only the ErrorActionPreference and SomeOtherVariable variables into the local scope.
    .EXAMPLE
       'ErrorActionPreference','SomeOtherVariable' | Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState

       Same as Example 2, but sends variable names to the Name parameter via pipeline input.
    .INPUTS
       String
    .OUTPUTS
       None.  This function does not produce pipeline output.
    .LINK
       about_Preference_Variables
    #>

    [CmdletBinding(DefaultParameterSetName = 'AllVariables')]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript({ $_.GetType().FullName -eq 'System.Management.Automation.PSScriptCmdlet' })]
        $Cmdlet,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.SessionState]$SessionState,

        [Parameter(ParameterSetName = 'Filtered', ValueFromPipeline = $true)]
        [string[]]$Name
    )

    begin {
        $filterHash = @{}
    }
    
    process {
        if ($null -ne $Name)
        {
            foreach ($string in $Name)
            {
                $filterHash[$string] = $true
            }
        }
    }

    end {
        # List of preference variables taken from the about_Preference_Variables help file in PowerShell version 4.0

        $vars = @{
            'ErrorView' = $null
            'FormatEnumerationLimit' = $null
            'LogCommandHealthEvent' = $null
            'LogCommandLifecycleEvent' = $null
            'LogEngineHealthEvent' = $null
            'LogEngineLifecycleEvent' = $null
            'LogProviderHealthEvent' = $null
            'LogProviderLifecycleEvent' = $null
            'MaximumAliasCount' = $null
            'MaximumDriveCount' = $null
            'MaximumErrorCount' = $null
            'MaximumFunctionCount' = $null
            'MaximumHistoryCount' = $null
            'MaximumVariableCount' = $null
            'OFS' = $null
            'OutputEncoding' = $null
            'ProgressPreference' = $null
            'PSDefaultParameterValues' = $null
            'PSEmailServer' = $null
            'PSModuleAutoLoadingPreference' = $null
            'PSSessionApplicationName' = $null
            'PSSessionConfigurationName' = $null
            'PSSessionOption' = $null

            'ErrorActionPreference' = 'ErrorAction'
            'DebugPreference' = 'Debug'
            'ConfirmPreference' = 'Confirm'
            'WhatIfPreference' = 'WhatIf'
            'VerbosePreference' = 'Verbose'
            'WarningPreference' = 'WarningAction'
        }

        foreach ($entry in $vars.GetEnumerator()) {
            if (([string]::IsNullOrEmpty($entry.Value) -or -not $Cmdlet.MyInvocation.BoundParameters.ContainsKey($entry.Value)) -and
                ($PSCmdlet.ParameterSetName -eq 'AllVariables' -or $filterHash.ContainsKey($entry.Name))) {
                
                $variable = $Cmdlet.SessionState.PSVariable.Get($entry.Key)
                
                if ($null -ne $variable) {
                    if ($SessionState -eq $ExecutionContext.SessionState) {
                        Set-Variable -Scope 1 -Name $variable.Name -Value $variable.Value -Force -Confirm:$false -WhatIf:$false
                    }
                    else {
                        $SessionState.PSVariable.Set($variable.Name, $variable.Value)
                    }
                }
            }
        }

        if ($PSCmdlet.ParameterSetName -eq 'Filtered') {
            foreach ($varName in $filterHash.Keys) {
                if (-not $vars.ContainsKey($varName)) {
                    $variable = $Cmdlet.SessionState.PSVariable.Get($varName)
                
                    if ($null -ne $variable)
                    {
                        if ($SessionState -eq $ExecutionContext.SessionState)
                        {
                            Set-Variable -Scope 1 -Name $variable.Name -Value $variable.Value -Force -Confirm:$false -WhatIf:$false
                        }
                        else
                        {
                            $SessionState.PSVariable.Set($variable.Name, $variable.Value)
                        }
                    }
                }
            }
        }
    }
}

## PUBLIC MODULE FUNCTIONS AND DATA ##

function Convert-PS2Bat {


<#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Convert-PS2Bat.md
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



function Convert-txt2wav {

<#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Convert-txt2wav.md
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



function Get-ADComputerByUser {

    <#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Get-ADComputerByUser.md
    #>

    [CmdletBinding()]
    param(

        [Parameter(	Position = 0,
            Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [System.String]
        $Name = $env:USERNAME,

        [Parameter(Position = 1)]
        [Switch]
        $Full = $false
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
    }

    # This block is used to provide record-by-record processing for the function.
    process {
        Write-Verbose "$($FunctionName): Process"
        try {
            Write-Verbose "$($FunctionName): Process.try"
            Write-Verbose "$($FunctionName): Building SearchName"
            $searchName = "*"
            $searchName += $Name
            $searchName += "*"
            Write-Verbose "$($FunctionName): SearchName: $Name"
            Write-Verbose "$($FunctionName): Setting List of Hosts"
            $Computers = Get-ADComputer -Filter ('tocLastLoggedOnuser -Like "{0}"' -f $searchName) -Properties * | Select-Object *
            Write-Verbose "$($FunctionName): Itterating Hosts"
            ForEach ($Computer in $Computers) {
                Write-Verbose "$($FunctionName): AD-Computer.Name: $($Computer.Name)"

                if ($Full) {
                    Write-Host $Computer | fl
                }
                else {
                    Write-Host $Computer.Name | fl
                }
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


function Get-Decryption {

    <#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Get-Encryption.md
    #>

    [CmdletBinding()]
    param(

        # parameter options
        # validation
        # cast
        # name and default value

        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $FilePath,

        [switch]$Silent = $false

    )

    # This block is used to provide optional one-time pre-processing for the function.
    begin {

        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
        $TempErrAct = $ErrorActionPreference
        $ErrorActionPreference = "Stop"
    }

    # This block is used to provide record-by-record processing for the function.
    process {

        try {
            if (!(Test-Path -Path $FilePath)) {
                $file = Split-Path -Path $FilePath -Leaf
                $folder = Split-Path -Path $FilePath
                Write-Host "$($FunctionName): File [$($file)] does not Exist in Folder [$($folder)]" -ForegroundColor Red
                continue
            }
            [Byte[]] $key = (1..16)
            $test = Get-Content $FilePath | ConvertTo-SecureString -Key $key
            $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($test)
            $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
            if (!($Silent.IsPresent)) {
                Write-Host "$($FunctionName): The Pharse is: $($password)" -ForegroundColor Green
            }
            return $password
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


function Get-GitSheet {
    <#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Get-GitSheet.md
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


function Get-HelpMessage {
    <#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Get-HelpMessage.md
    #>
    [CmdletBinding()]
    [Alias('HelpMsg')]
    PARAM($Id)
    try {
        [ComponentModel.Win32Exception] $id
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}


function Get-PubIP {
    <#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Get-PubIP.md
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
        catch [Exception] {
            Write-Verbose "$($FunctionName): Process.catch"
            echo $_.Exception|format-list -force
        }
    }
    end {
        Write-Verbose "$($FunctionName): End."
        $ErrorActionPreference = $TempErrAct
    }
}



function New-SS {

    <#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/New-SS.md
    #>

    [OutputType([System.IO.FileInfo])]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( { -not (Test-Path -Path $_ -PathType Leaf) })]
        [ValidatePattern('\.jpg|\.jpeg|\.bmp')]
        [string]$FilePath

    )

    # This block is used to provide optional one-time pre-processing for the function.
    begin {

        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
        $TempErrAct = $ErrorActionPreference
        $ErrorActionPreference = "Stop"
        Add-Type -AssemblyName System.Windows.Forms
        Add-type -AssemblyName System.Drawing
    }

    # This block is used to provide record-by-record processing for the function.
    process {

        try {
            # Gather Screen resolution information
            $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen

            # Create bitmap using the top-left and bottom-right bounds
            $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height

            # Create Graphics object
            $graphic = [System.Drawing.Graphics]::FromImage($bitmap)

            # Capture screen
            $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size)
            Write-Verbose "$($FunctionName): Getting Screen"

            # Save to file
            $bitmap.Save($FilePath)
            Write-Verbose "$($FunctionName): Saving File $($FilePath)"

            Get-Item -Path $FilePath

        }
        catch {

            "Stuff Failed" | Write-Error

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

    # This block is used to provide optional one-time post-processing for the function.
    end {
        Write-Verbose "$($FunctionName): End."
        $ErrorActionPreference = $TempErrAct
    }
}


function Search-Google {

	<#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Search-Google.md
    #>


		# This block is used to provide optional one-time pre-processing for the function.
		Begin {
			$query = 'https://www.google.com/search?q='
		}
		Process {
			Write-Host $args.Count, "Arguments detected"
			"Parsing out Arguments: $args"
			for ($i = 0; $i -le $args.Count; $i++) {
				$args | % {"Arg $i `t $_ `t Length `t" + $_.Length, " characters"; $i++}
			}


			$args | % {$query = $query + "$_+"}
			$url = "$query"
		}
		End {
			$url.Substring(0, $url.Length - 1)
			"Final Search will be $url"
			"Invoking..."
			start "$url"
		}
	}


function Set-Encryption {

    <#
    .EXTERNALHELP TGH-help.xml
    .LINK
        https://www.github.com/Kaimodo/TGH/tree/master/release/0.0.8/docs/Functions/Set-Encryption.md
    #>

    [CmdletBinding()]
    param(

        # parameter options
        # validation
        # cast
        # name and default value

        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [System.String]
        $FilePath,

        [Parameter(Position = 1)]
        [ValidateNotNull()]
        [System.String]
        $Pharse

    )

    # This block is used to provide optional one-time pre-processing for the function.
    begin {

        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
        $TempErrAct = $ErrorActionPreference
        $ErrorActionPreference = "Stop"
    }

    # This block is used to provide record-by-record processing for the function.
    process {
        if (!(Test-Path $FilePath)) {
            New-Item -Path $FilePath -ItemType File
            Write-Verbose "$($FunctionName):File $($FilePath) created"
        }
        try {
            [Byte[]] $key = (1..16)
            $Password = $Pharse | ConvertTo-SecureString -AsPlainText -Force
            $Password | ConvertFrom-SecureString -Key $key | Out-File $FilePath
            Write-Verbose "$($FunctionName): Pharse secured"

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


## Post-Load Module code ##

# Use this variable for any path-sepecific actions (like loading dlls and such) to ensure it will work in testing and after being built
$MyModulePath = $(
    Function Get-ScriptPath {
        $Invocation = (Get-Variable MyInvocation -Scope 1).Value
        if($Invocation.PSScriptRoot) {
            $Invocation.PSScriptRoot
        }
        Elseif($Invocation.MyCommand.Path) {
            Split-Path $Invocation.MyCommand.Path
        }
        elseif ($Invocation.InvocationName.Length -eq 0) {
            (Get-Location).Path
        }
        else {
            $Invocation.InvocationName.Substring(0,$Invocation.InvocationName.LastIndexOf("\"));
        }
    }

    Get-ScriptPath
)

# Load any plugins found in the plugins directory
if (Test-Path (Join-Path $MyModulePath 'plugins')) {
    Get-ChildItem (Join-Path $MyModulePath 'plugins') -Directory | ForEach-Object {
        if (Test-Path (Join-Path $_.FullName "Load.ps1")) {
            Invoke-Command -NoNewScope -ScriptBlock ([Scriptblock]::create(".{$(Get-Content -Path (Join-Path $_.FullName "Load.ps1") -Raw)}")) -ErrorVariable errmsg 2>$null
        }
    }
}

$ExecutionContext.SessionState.Module.OnRemove = {
    # Action to take if the module is removed
    # Unload any plugins found in the plugins directory
    if (Test-Path (Join-Path $MyModulePath 'plugins')) {
        Get-ChildItem (Join-Path $MyModulePath 'plugins') -Directory | ForEach-Object {
            if (Test-Path (Join-Path $_.FullName "UnLoad.ps1")) {
                Invoke-Command -NoNewScope -ScriptBlock ([Scriptblock]::create(".{$(Get-Content -Path (Join-Path $_.FullName "UnLoad.ps1") -Raw)}")) -ErrorVariable errmsg 2>$null
            }
        }
    }
}

$null = Register-EngineEvent -SourceIdentifier ( [System.Management.Automation.PsEngineEvent]::Exiting ) -Action {
    # Action to take if the whole pssession is killed
    # Unload any plugins found in the plugins directory
    if (Test-Path (Join-Path $MyModulePath 'plugins')) {
        Get-ChildItem (Join-Path $MyModulePath 'plugins') -Directory | ForEach-Object {
            if (Test-Path (Join-Path $_.FullName "UnLoad.ps1")) {
                Invoke-Command -NoNewScope -ScriptBlock [Scriptblock]::create(".{$(Get-Content -Path (Join-Path $_.FullName "UnLoad.ps1") -Raw)}") -ErrorVariable errmsg 2>$null
            }
        }
    }
}

# Use this in your scripts to check if the function is being called from your module or independantly.
$ThisModuleLoaded = $true

# Non-function exported public module members might go here.
#Export-ModuleMember -Variable SomeVariable -Function  *


