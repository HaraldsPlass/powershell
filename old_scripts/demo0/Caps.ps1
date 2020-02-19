$continue = $true
while($continue)
{

    if ([console]::KeyAvailable)
    {
        Write-Host "IF entered"
        echo "Toggle with F12";
        $x = [System.Console]::ReadKey() 
        if ($x.Character -eq 'A') {
        "Pressed A"
        #Get-Screenshot -Path C:\demo\ -Verbose
        }
        switch ( $x.key)
        {
            F12 { $continue = $false }
        }
    } 
    else
    {
        Write-Host "Else entered"
        $wsh = New-Object -ComObject WScript.Shell
        #$wsh.SendKeys('{ESC}')
        $wsh.SendKeys('{CAPSLOCK}')
        sleep 10
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($wsh)| out-null
        Remove-Variable wsh

        $x = [System.Console]::ReadKey() 
        if ($x.Character -eq 'A') {
        "Pressed A"
          Write-Host "Else Pressed A"
        #Get-Screenshot -Path C:\demo\ -Verbose
        }
    }    
}