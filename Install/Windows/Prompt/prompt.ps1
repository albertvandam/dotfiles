$PROMPT_THEME = "$HOME\.config\Install\Windows\Prompt\theme.omp.json"
$customTheme = "$HOME\.local\pwsh_config\theme.omp.json"
if ([System.IO.File]::Exists($customTheme)) { 
    $PROMPT_THEME=$customTheme
}

oh-my-posh init pwsh --config $PROMPT_THEME | Invoke-Expression 

# forward completions
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# reverse/history completions
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PsFzfOption -TabExpansion

