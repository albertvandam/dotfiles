function la() {
    lsd --long -A --blocks "size,date,git,name"
}

function ll() {
    lsd --long --blocks "size,date,git,name"
}

function lt() {
    lsd --tree -I node_modules -I dist -I target -I .git -I .angular -I .vscode -I .idea
}

Set-Alias -Name l -Value lsd

Set-Alias -Name tree -Value lt

Set-Alias -Name p -Value Get-Location

Set-Alias -Name c -Value Clear-Host

function cls() {
    Clear-Host
    lsd --long --blocks "size,date,git,name"
}

function which($name) { 
    Get-Command $name -ErrorAction SilentlyContinue | Select-Object Definition 
}

Set-Alias -Name e -Value code

function df {
    get-volume
}

Set-Alias -Name top -Value btop4win
Set-Alias -Name btop -Value btop4win

function gs {
    git status
}

function gb {
    git b
}

function gg {
    Write-Output "Check if we have changes"
    $status=git status | Select-String "nothing to commit"
    if ($status.Length -ne 0) {
        Write-Output "Nothing to commit"
        return 99
    }
    Write-Output "Yes, we do"
    Write-Output ""

    Write-Output "Determining main branch"
    $main=git config --local --get dev.main
    if (!$?) {
        $main="main"
    }
    Write-Output "Main branch: $main"
    Write-Output ""

    $onMain=$false
    Write-Output "Determining current branch"
    $current=git rev-parse --abbrev-ref HEAD
    if ($current -eq $main) {
        $onMain=$true
        Write-Output "On main branch"
    } else {
        Write-Output "Current branch: $current"        
    }
    Write-Output ""

    Write-Output "Stage changes for commit"
    git add .
    Write-Output ""

    Write-Output "Checking if we have a remote"
    git remote get-url origin
    $hasRemote=$?
    if ($hasRemote) {
        Write-Output "Yes, we do"
    } else {
        Write-Output "No, we don't"
        $hasRemote=$false
    }
    Write-Output ""

    if ($hasRemote) {
        Write-Output "Updating remote changes from $main"
        Write-Output "> Stashing your changes"
        git stash

        if (!$onMain) {
            Write-Output "> Switch to $main"
            git checkout $main
        }

        Write-Output "> Pull updates"
        git pull
        if (!$?) {
            Write-Output "Failed updating $main"
            git checkout $current
            git stash apply
            return 99
        }

        if (!$onMain) {
            Write-Output "> Switch to $current"
            git checkout $current

            Write-Output "> Merge changes from $main into $current"
            git merge $main
            if (!$?) {
                Write-Output "Please resolve merge conflicts first. Afterwards use 'git stash apply' to return your changes."
                return 99
            }
        }

        Write-Output "> Restore stashed changes"
        git stash apply
        if (!$?) {
            Write-Output "Please resolve merge conflicts first. Then retry."
            return 99
        }
        git add .
        Write-Output ""
    }

    if ($args.Length -eq 0) {
        Write-Host "Enter a commit message"
        $commit_msg = Read-Host
    } else {
        $commit_msg = $args[0]
        Write-Host "Using commit message: $commit_msg"
    }
    git commit -m "$commit_msg" --no-verify
    Write-Output ""

    if ($hasRemote) {
        Write-Output "Pusing to remote"
        git push
        Write-Output ""
    }  

    Write-Output "Done"
}

function nn {
    Remove-Item node_modules -Force -Recurse
    Remove-Item package-lock.json -Force
    npm cache clear --force
    npm install --force
}

function ni {
    npm cache clear --force
    npm install --force
}

Set-Alias -Name cat -Value bat

Set-Alias -Name o -Value start

function explore {
    Start-Process .
}

function cpwd {
    Get-Location | Set-Clipboard
}


function vi([String] $file) {
    $f = $file.Replace("\", "/");
    if ($f.StartsWith($env:HOMEDRIVE)) {
        $f = $f.Replace(":", "").ToLower()
        $f = "/mnt/" + $f
    }
    wsl vi $f
}

function upOne() {
    cdX ..
}
Set-Alias -Name .. -Value upOne

function upTwo() {
    cdX ../..
}
Set-Alias -Name ... -Value upTwo

function upThree() {
    cdX ../../..
}
Set-Alias -Name .... -Value upThree

function grep($regex, $dir) {
    if ( $dir ) {
        Get-ChildItem $dir | Select-String $regex
        return
    }
    $input | Select-String $regex
}


function sed($file, $find, $replace) {
    (Get-Content $file).replace("$find", $replace) | Set-Content $file
}

function touch($file) { "" | Out-File $file -Encoding ASCII }

function docker {
    $allArgs = $PsBoundParameters.Values + $args
    wsl --user root /usr/bin/docker $allArgs
}

function upd {
    . $HOME\.config\Install\update\prepare.ps1
}
