function Set-Encryption {

    <#
.SYNOPSIS
    Encrypt a given Pharse into a given File
.DESCRIPTION
	Encrypts a Pharse like a Name or Key into a File. This can be Decyrpted with Get-Encryption again
.PARAMETER FilePath
	The File in which the Pharse should be saved after encryption
.PARAMETER Pharse
	The Pharse which should be encrypted
.EXAMPLE
	PS C:\> Set-Encryption -FilePath 'C:\key.key' -Pharse 'UltraSecretPasswrd'
.INPUTS
	System.String
.OUTPUTS
	System.File
.NOTES
	Author: Kai Krutscho
.LINK
	https://www.github.com/kaimodo/TGH.git
.LINK
	about_comment_based_help
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
        catch [Exception]{
            Catch-Options -message (("(" + $MyInvocation.MyCommand.Name).ToString() + ") " + $_.Exception.Message) -outputoption $outputoption
        }
    }

    # This block is used to provide optional one-time post-processing for the function.
    end {
        Write-Verbose "$($FunctionName): End."
        $ErrorActionPreference = $TempErrAct
    }
}