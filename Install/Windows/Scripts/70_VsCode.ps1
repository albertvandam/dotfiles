Write-Output "Configure VS Code"

AddPathVariable "$env:HOMEDRIVE$env:HOMEPATH\AppData\Local\Programs\Microsoft VS Code\bin"
code -s

$codeDir = "$env:APPDATA\Code";
if (![System.IO.Directory]::Exists($codeDir)) { 
    [System.IO.Directory]::CreateDirectory($codeDir) 
}

$codeUserDir = "$codeDir\User";
if (![System.IO.Directory]::Exists($codeUserDir)) { 
    [System.IO.Directory]::CreateDirectory($codeUserDir) 
}

$settingsFile = "$codeUserDir\settings.json"
if ([System.IO.File]::Exists($settingsFile)) {
    mv $settingsFile $codeUserDir\settings.json.old
}

New-Item -Path $codeUserDir\settings.json -ItemType SymbolicLink -Value $env:HOMEPATH\.config\Install\VsCode\settings.json

. $HOME\.config\Install\VsCode\plugins.ps1

code --locate-shell-integration-path pwsh 

code --install-extension "ms-vscode-remote.remote-wsl" --force
code --install-extension "ms-vscode.powershell" --force

