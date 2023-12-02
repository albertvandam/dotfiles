Write-Output "Configure lsd"

$lsdFolder = "$env:APPDATA\lsd"
if ([System.IO.Directory]::Exists($lsdFolder)) {
    Remove-Item $lsdFolder -Recurse -Force
}
New-Item -Path $env:APPDATA\lsd -ItemType SymbolicLink -Value $env:HOMEPATH\.config\lsd
