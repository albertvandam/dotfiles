Write-Output "Configure Git"

$h = $HOME.Replace("\", "/")

$gu = @(git config --global --get user.name)
$ge = @(git config --global --get user.email)

$gitConfig = "$HOME\.gitconfig"
if ([System.IO.File]::Exists($gitConfig)) {
    Move-Item $gitConfig "$gitConfig.bak"
}

if ($gu -ne "") {
    git config --global user.name $gu
}
if ($ge -ne "") {
    git config --global user.email $ge
}

git config --global include.path "$h/.config/Git/.gitconfig"
git config --global --add safe.directory "$h/.config"
