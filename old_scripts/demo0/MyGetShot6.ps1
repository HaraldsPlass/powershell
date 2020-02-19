Function Get-Screenshot {
    [CmdletBinding()] Param(
            [Parameter(Mandatory=$True)]             
            [ValidateScript({Test-Path -Path $_ })]
            [string] $Path
            )
    
        #Define function that generates and saves screenshot
        Function GenScreenshot {
           $ScreenBounds = [Windows.Forms.SystemInformation]::VirtualScreen
           $ScreenshotObject = New-Object Drawing.Bitmap $ScreenBounds.Width, $ScreenBounds.Height
           $DrawingGraphics = [Drawing.Graphics]::FromImage($ScreenshotObject)
           $DrawingGraphics.CopyFromScreen( $ScreenBounds.Location, [Drawing.Point]::Empty, $ScreenBounds.Size)
           $DrawingGraphics.Dispose()
           $ScreenshotObject.Save($FilePath)
           $ScreenshotObject.Dispose()
        }

        Try {
            
            #load required assembly
            Add-Type -Assembly System.Windows.Forms            

                $Time = (Get-Date)
                
                [string] $FileName = "$($Time.Year)"
                $FileName += '-'
                $FileName += "$($Time.Month)" 
                $FileName += '-'
                $FileName += "$($Time.Day)"
                $FileName += '-'
                $FileName += "$($Time.Hour)"
                $FileName += '-'
                $FileName += "$($Time.Minute)"
                $FileName += '-'
                $FileName += "$($Time.Second)"
                $FileName += '.png'
            
                #use join-path to add path to filename
                [string] $FilePath = (Join-Path $Path $FileName)

                #run screenshot function
                GenScreenshot
                
                Write-Verbose "Saved screenshot to $FilePath."
        }
       Catch {Write-Warning "$Error[0].ToString() + $Error[0].InvocationInfo.PositionMessage"}

}
$continue = $true
while($continue)
{
    Write-Host "Press 8 to take timestamped screenshot ..."
    $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    $key = $Host.UI.RawUI.ReadKey()
    #if ($key.Character -eq 'A') {
    if ($key.Character -eq '8') {
        Write-Host "8 pressed. Taking a screenshot..."
        Get-Screenshot -Path C:\demo\ -Verbose
    }
    Write-Host "8 is NOT pressed! Screenshot is NOT taken!"
}