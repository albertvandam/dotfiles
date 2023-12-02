Write-Output "Configure Projects folder"

$projectsDir = "$env:HOMEDRIVE\Projects"
if (![System.IO.Directory]::Exists($projectsDir)) { 
    [System.IO.Directory]::CreateDirectory($projectsDir) 
}

SetEnvironment PROJECTS $projectsDir

Copy-Item $HOME\.config\Install\Windows\Projects.lnk $HOME
