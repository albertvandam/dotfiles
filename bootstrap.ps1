$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$isWin11 = (Get-WmiObject Win32_OperatingSystem).Caption -Match "Windows 11"

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

    $actCmd = "irm https://raw.githubusercontent.com/albertvandam/dotfiles/main/bootstrap.ps1 | iex";
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

Write-Output "Create Restore Point"
$hasRestorePoint=0
try {
    Checkpoint-Computer -Description "Before Configuring Dev Environment" -RestorePointType "APPLICATION_INSTALL"
    if ($?) {
      $hasRestorePoint=1
    }
} catch {
}

if ($hasRestorePoint -eq 0) {
    [console]::beep(500, 300)
    Write-Output "`a"

    Write-Output "Unable to create Restore Point"
    Read-Host 'Press Enter to continue (CTRL+C to cancel)'    
}

Write-Output "Installing package manager"
$hasWinget = $true
try {
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Script winget-install -Force
    winget-install -Force -ForceClose
    if (!$?) {
        $hasWinget = $false
    }

} catch {
    Write-Output $_.Exception
    $hasWinget = $false
}

if (!$hasWinget) {
    Write-Output "Error installing package manager. Please try again."
    Read-Host 'Press Enter to end...'
    exit
}

#Configure WinGet
Write-Output "Configuring package manager"

#winget config path from: https://github.com/microsoft/winget-cli/blob/master/doc/Settings.md#file-location
$settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json";
$settingsJson = 
@"
    {
        "installBehavior": {
            "disableInstallNotes": true,
            "preferences": {
                "scope": "user"
            }
        },
        "telemetry": {
            "disable": true
        },
    }
"@;
$settingsJson | Out-File $settingsPath -Encoding utf8

if ($isWin11) {
    Write-Output "Updating Windows Terminal"

    # uninstall Windows Terminal if it is already installed
    # possibly outdated, and broken after winget install
    $terminalName = "Microsoft.WindowsTerminal"
    $listApp = winget list --exact -q $terminalName --accept-source-agreements 
    if ([String]::Join("", $listApp).Contains($terminalName)) {
        winget uninstall $terminalName
    }

    Write-Output "Download latest release of Windows Terminal"
    $releases_url = 'https://api.github.com/repos/microsoft/terminal/releases/latest'

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod -uri $releases_url
    $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('msixbundle') } | Select-Object -First 1

    Write-Output "Install Windows Terminal"
    Add-AppxPackage -Path $latestRelease.browser_download_url -ForceApplicationShutdown
} else {
    Write-host "Installing: Microsoft.WindowsTerminal"
    winget install --exact --silent Microsoft.WindowsTerminal --accept-package-agreements --disable-interactivity
}

# start and stop WT to make sure config files exists
Start-Process -WindowStyle Minimized $env:HOMEDRIVE$env:HOMEPATH\AppData\Local\Microsoft\WindowsApps\wt.exe 
do {
    $terminalProc = Get-Process -name WindowsTerminal -ErrorAction "Ignore"
    Start-Sleep -Seconds 1
} while ($null -eq $terminalProc)
Stop-Process -Name WindowsTerminal

#Install New apps
$apps = @(
    @{name = "Microsoft.PowerShell" }, 
    @{name = "Git.Git" }
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name --accept-source-agreements 
    if ([String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Updating: " $app.name
        winget upgrade --exact --silent $app.name --accept-package-agreements --disable-interactivity
    } else {
        Write-host "Installing: " $app.name
        winget install --exact --silent $app.name --accept-package-agreements --disable-interactivity
    }
}

# clone repo
$configDir = "$env:HOMEDRIVE$env:HOMEPATH\.config"
if ([System.IO.Directory]::Exists($configDir)) { 
    [console]::beep(500, 300)
    Write-Output "`a"

    Write-Output "$configDir already exists"
    Read-Host 'Press Enter to continue (CTRL+C to cancel)'    

    Write-Output "Deleting $HOME/.config"
    Remove-Item $configDir -Force -Recurse
}

$env:PATH = "$env:PATH;C:\Program Files\Git\bin;c:\Program Files\PowerShell\7;C:\Program Files\nodejs;$env:HOMEDRIVE$env:HOMEPATH\AppData\Local\Programs\oh-my-posh\bin;$env:HOMEDRIVE:\Users\me\AppData\Local\Microsoft\WinGet\Links\"

Write-Output "Cloning dotfiles repo"
git config --global core.autocrlf false
git clone "https://github.com/albertvandam/dotfiles.git" $configDir
Set-Location $configDir
git submodule init
git submodule update
Set-Location ~/.config/Vim/.vim/pack/themes/start/dracula
git checkout master
git pull

# prep for restart
Write-Output ". $env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\Prompt\Windows.PowerShell_profile.ps1" >>$PROFILE

# run actual installer
pwsh.exe -NoLogo -NoProfile -Command "$env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\install.ps1"
