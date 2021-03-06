function Get-Decryption {

    <#
.SYNOPSIS
    Decrypt a given Pharse from a given File
.DESCRIPTION
	Decrypts a Pharse like a Name or Key from a File. This can be Encyrpted with Set-Decryption
.PARAMETER FilePath
    The File in which the Pharse is saved
.PARAMETER Silent
    Just give the Return, Don't Write the Pharse on the Screen
.EXAMPLE
	PS C:\> Get-Decryption -FilePath 'C:\key.key'
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