
$sshDir = "$env:HOMEDRIVE$env:HOMEPATH/.ssh";
$keyFile = "$sshDir/id_rsa"

if (![System.IO.File]::Exists($keyFile)) {
    Write-Output "Create SSH key"

    ssh-keygen -t rsa -N '' -f $sshDir/id_rsa
}
