Write-Output "Configure Windows Terminal"

oh-my-posh.exe font install FiraCode --user
oh-my-posh.exe font install BigBlueTerminal --user
node.exe "$env:HOMEDRIVE$env:HOMEPATH\.config\Install\Windows\WindowsTerminal\patch.js"
