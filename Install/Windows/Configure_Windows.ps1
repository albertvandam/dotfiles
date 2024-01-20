$startupScript = "$env:HOMEDRIVE$env:HOMEPATH\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\configurator.cmd"
if ([System.IO.File]::Exists($startupScript)) {
    Remove-Item $startupScript -Force
}

. $env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\Functions\functions.ps1

Write-Output "Installing WSL Kernel update"
Write-Output ""
Write-Host "This will request privilege elevation" -ForegroundColor Red
Write-Output ""

$kernUpdate = Join-Path $env:TEMP "wsl_update_x64.msi"
DownloadFile "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" $kernUpdate
Start-Process msiexec.exe -Wait -ArgumentList "/I $kernUpdate /quiet /passive /norestart" -NoNewWindow 
Remove-Item $kernUpdate

$a=wsl -l | Where-Object {$_.Replace("`0","") -match '^Ubuntu'}
if (($null -eq $a) -or ($a.Trim().Length -eq 0)) {
    Write-Output ""
    Write-Output ""
    Write-Output ""
    Write-Output "Ubuntu will now be installed on WSL"
    Write-Output ""
    Write-Output "You wil be prompted to provide a user and password. This does not need to match your Windows details, but the password should be easy to remember."
    Write-Output ""
    Write-Output ""
    Write-Output ""

    [console]::beep(500, 300)
    Write-Output "`a"

    ubuntu.exe install
    if (!$?) {
        [console]::beep(500, 300)
        Write-Output "`a"

        Write-Output ""
        Write-Output ""
        Write-Output ""
        Write-Host "Ubuntu installation failed" -ForegroundColor Red
        Write-Output ""
        Write-Output ""
        Write-Output ""
        Read-Host "Press ENTER to close"
        exit 99
    }
    wsl.exe --set-default Ubuntu
}

$d = $env:HOMEDRIVE.Replace(":", "").ToLower()
$p = $env:HOMEPATH.Replace("\", "/")
$h = "/mnt/$d$p"

wsl.exe --user root sh $h/.config/Install/Windows/Ubuntu/prep.sh
wsl.exe sh $h/.config/Install/Windows/Ubuntu/configure.sh $h

$linuxUser=wsl.exe whoami
wsl.exe --user root chsh $linuxUser --shell /usr/bin/zsh

$desktopFolder = [Environment]::GetFolderPath("Desktop")
$PUBKEY = Get-Content $HOME\.ssh\id_rsa.pub
(Get-Content $HOME\.config\Install\Windows\info_template.html).replace("{PUBKEY}", $PUBKEY) | Set-Content $desktopFolder\Environment_Info.html

node.exe "$env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\WindowsTerminal\patch.js"

Clear-Host
Write-Output "All done"
Write-Output ""

[console]::beep(500, 300)
Write-Output "`a"

Read-Host 'Press Enter to restart...'

restart-computer 
