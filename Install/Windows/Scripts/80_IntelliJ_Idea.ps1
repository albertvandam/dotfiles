. $env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\Functions\functions.ps1

Write-Output "Configure IntelliJ IDEA"

AddPathVariable "$env:HOMEDRIVE$env:HOMEPATH\AppData\Local\JetBrains\IntelliJ\bin"

$ideaFile = "$env:HOMEPATH\idea.properties"
if ([System.IO.File]::Exists($ideaFile)) {
    Remove-Item $ideaFile -Force
}
New-Item -Path $env:HOMEPATH\idea.properties -ItemType SymbolicLink -Value $env:HOMEPATH\.config\IntelliJIdea\idea.properties

. $HOME\.config\IntelliJIdea\plugins.ps1
