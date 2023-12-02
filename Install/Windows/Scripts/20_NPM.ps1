Write-Output "Configure NPM"

$npmRcfile = "$env:HOMEPATH\.npmrc"
if ([System.IO.File]::Exists($npmRcfile)) {
    mv $npmRcfile $env:HOMEPATH\.npmrc.bak
}
copy $env:HOMEPATH\.config\NPM\.npmrc $env:HOMEPATH\.npmrc

