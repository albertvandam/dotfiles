$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

Clear-Host

$baseDir = "$env:HOMEDRIVE$env:HOMEPATH\.config"
Set-Location $baseDir

. $env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\Functions\functions.ps1

Get-ChildItem "$env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\Scripts" -Filter *.ps1 | Sort-Object FullName | 
Foreach-Object {
    . $_.FullName
}

dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

$wslConfig = 
@"
[wsl2]
localhostforwarding=true

[experimental]
networkingMode=mirrored
"@;
$wslConfig | Out-File $HOME\.wslconfig -Encoding utf8


$afterFile = "$env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\Configure_Windows.ps1"
$startupScript = "$env:HOMEDRIVE$env:HOMEPATH\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\configurator.cmd"
Write-Output "pwsh.exe -NoLogo -NoProfile -Command `"$afterFile`"" | Out-File -encoding ascii $startupScript

[console]::beep(500, 300)
Write-Output "`a"

Read-Host 'Press Enter to restart...'

restart-computer 
