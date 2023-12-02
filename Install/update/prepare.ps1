$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$isWin11 = (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"
if (!$isWin11) {
    [console]::beep(500, 300)
    Write-Output "`a"

    Write-Host "This script requires Windows 11" -ForegroundColor Red
    exit
}

$restartNeeded = $false

$oldTitle = $host.ui.RawUI.WindowTitle
$tempTitle = ([Guid]::NewGuid())
$host.ui.RawUI.WindowTitle = $tempTitle
Start-Sleep 1
$currentProcess = Get-Process | Where-Object { $_.MainWindowTitle -eq $tempTitle }
$currentProcess = [PSCustomObject]@{
    Name = $currentProcess.Name
    Id   = $currentProcess.Id
}
$host.ui.RawUI.WindowTitle = $oldTitle
if ($null -eq $currentProcess.Name) {
    Write-Output "Running in unknown terminal"
    $restartNeeded = $true;
}
if ($currentProcess.Name -eq "WindowsTerminal") {
    $restartNeeded = $true;
    Write-Output "Running in Windows Terminal"
}

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$isAdmin) {
    Write-Output "Does not have elevated privileges"
    $restartNeeded = $true;
}

if ($restartNeeded) {
    Write-Output "Restarting in elevated shell"

    $actCmd = "$HOME\.config\Install\update\update.ps1";
    $cmd = "PowerShell -NoProfile -ExecutionPolicy Bypass -Command `"$actCmd`""

    try {
        Start-Process -FilePath "conhost.exe" -ArgumentList $cmd -Verb RunAs
    } catch {
        Write-Output ""
        Write-Output ""
        Write-Host "Error elevating privileges" -ForegroundColor Red
        Write-Output ""
        Write-Output ""

        exit
    }

    if ($null -eq $currentProcess.Id) {
        $terminalProc = Get-Process -name WindowsTerminal -ErrorAction "Ignore"
        if ($null -ne $terminalProc) {
            Stop-Process -Name WindowsTerminal
        }

    } else {
        Stop-Process -id $currentProcess.Id
    }

    exit
}

Write-Output ""
Write-Output ""
Write-Output "Pulling updated configuration"
Write-Output ""
Write-Output ""

Set-Location $HOME\.config
git pull

pwsh.exe -NoLogo -NoProfile -Command  $HOME/.config/Install/update/update.ps1
