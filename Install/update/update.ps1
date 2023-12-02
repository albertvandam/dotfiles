Write-Output ""
Write-Output ""
Write-Output "Updating installed Windows applications"
Write-Output ""
Write-Output ""
winget upgrade --silent --accept-package-agreements --all

Write-Output ""
Write-Output ""
Write-Output "Updating installed Ubuntu applications"
Write-Output ""
Write-Output ""
wsl --user root apt-get update
wsl --user root apt-get upgrade -y

$updateDir = "$HOME\.local\update_extra"
if ([System.IO.Directory]::Exists($updateDir)) {
    Get-ChildItem "$updateDir" -Filter *.ps1 | Sort-Object FullName | 
    Foreach-Object {
        . $_.FullName
    }
}

Write-Output ""
Write-Output ""
Write-Output "All done"
Write-Output ""
Write-Output ""

[console]::beep(500, 300)
Write-Output "`a"

Read-Host 'Press Enter to close...'
