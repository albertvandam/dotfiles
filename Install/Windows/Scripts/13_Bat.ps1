Write-Output "Configure bat"

$batFolder = "$env:HOMDEDRIVE$env:HOMEPATH\AppData\Roaming\bat";
if ([System.IO.Directory]::Exists($batFolder)) {
    Remove-Item $batFolder -Recurse -Force
}
New-Item -Path $env:HOMDEDRIVE$env:HOMEPATH\AppData\Roaming\bat -ItemType SymbolicLink -Value $env:HOMEPATH\.config\bat
