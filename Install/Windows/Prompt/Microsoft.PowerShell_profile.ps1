$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

. $HOME\.config\Install\Windows\Prompt\prompt.ps1
. $HOME\.config\Install\Windows\Prompt\plugins.ps1
. $HOME\.config\Install\Windows\Prompt\aliases.ps1

# include additional customisation from $HOME\.local\pwsh_config
$localDir = "$HOME\.local\pwsh_config"
if ([System.IO.Directory]::Exists($localDir)) { 
    Get-ChildItem $localDir -Filter *.ps1 | Sort-Object FullName | 
    Foreach-Object {
        . $_.FullName
    }
}
