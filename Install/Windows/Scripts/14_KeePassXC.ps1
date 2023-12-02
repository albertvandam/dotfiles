Write-Output "Configure KeePassXC"

$keePassFolder = "$env:HOMDEDRIVE$env:HOMEPATH\AppData\Roaming\KeePassXC";
if (![System.IO.Directory]::Exists($keePassFolder)) {
    [System.IO.Directory]::CreateDirectory($keePassFolder) 
}

$keePassConfigFile = "$keePassFolder\keepassxc.ini"
if ([System.IO.File]::Exists($keePassConfigFile)) {
    Remove-Item $keePassConfigFile
}

Copy-Item $HOME\.config\Install\KeePassXC\keepassxc.ini $keePassFolder
