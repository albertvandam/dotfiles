# show file and folder icons in the terminal
Import-Module -Name Terminal-Icons

# load zoxide
# replaces cd, and allows shortening of the path for regularly used paths
Invoke-Expression (& { (zoxide init powershell --hook pwd --cmd cd | Out-String) })
