Write-Output "Configure PowerShell Profile"

Install-Module -Name Posh-Git -Force -Scope CurrentUser
Install-Module -Name Terminal-Icons -Repository PSGallery -Force -Scope CurrentUser
Install-Module -Name PSReadLine -AllowPrerelease -Force -Scope CurrentUser
Install-Module -Name PSFzf -Force -Scope CurrentUser

if ([System.IO.File]::Exists($PROFILE)) {
    Move-Item $PROFILE "$PROFILE.bak"
}

Write-Output ". $env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\Prompt\Microsoft.PowerShell_profile.ps1" >$PROFILE
