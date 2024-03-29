function New-SS {

    <#
.SYNOPSIS
    Take a Screenshot and save it to BMP
.DESCRIPTION
	This function take a screenshot of your computer and saves it to a file of your choosing.
	It will only capture a single screen on a multi-monitor setup.
.PARAMETER FilePath
	A mandatory parameter that specifies where you'd like the screenshot image to be saved. If a file is detected in this
	path, the function will not allow the capture to happen. There must be no file at this location.
	You may choose file extensions of JPG, JPEG and BMP.
.EXAMPLE
	PS> New-ScreenShot -FilePath C:\Screenshot.bmp
	This example will capture a screenshot of your current screen and save it to a BITMAP file at C:\ScreenShot.bmp.
.INPUTS
	System.String
.OUTPUTS
	System.IO.FileInfo
.NOTES
	Author: Kai Krutscho
.LINK
	https://www.github.com/kaimodo/TGH
.LINK
	about_comment_based_help
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