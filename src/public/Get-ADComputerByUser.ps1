function Get-ADComputerByUser {

    <#
.SYNOPSIS
    Get's the AD-Computer the specific user was Last Logged on
.DESCRIPTION
	This works ONLY if some Adaptions have been done to the AD, see here :
	https://lockstepgroup.com/blog/fun-with-ad-custom-attributes/
.PARAMETER Name
	The Name or part of the UserName
.PARAMETER Full
	Returns the Full Computer Object
.EXAMPLE
	PS C:\> Get-ADComputerByUser -Name "Admin" -Full
	Seaches the Computer where the Admin was logged on and Displays it with all Properties
.INPUTS
	System.String,
	System.Switch
.OUTPUTS
	System.String
.NOTES
	Author: Kai Krutscho
.LINK
	https://github.com/kaimodo/ToModule.git
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