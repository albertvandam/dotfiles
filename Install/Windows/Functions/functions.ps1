function DownloadFile {
    param (
        [string]$url,
        [string]$file
    )
    Write-Host "Downloading $url to $file"
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    Invoke-WebRequest -Uri $url -OutFile $file
}

function UnzipFile {
    param (
        [string]$File,
        [string]$Destination = (Get-Location).Path
    )

    $filePath = Resolve-Path $File
    $destinationPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)

    If (($PSVersionTable.PSVersion.Major -ge 3) -and
        (
            [version](Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction SilentlyContinue).Version -ge [version]"4.5" -or
            [version](Get-ItemProperty -Path "HKLM:\Software\Microsoft\NET Framework Setup\NDP\v4\Client" -ErrorAction SilentlyContinue).Version -ge [version]"4.5"
        )) {
        try {
            [System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem") | Out-Null
            [System.IO.Compression.ZipFile]::ExtractToDirectory("$filePath", "$destinationPath")
        }
        catch {
            Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
        }
    }
    else {
        try {
            $shell = New-Object -ComObject Shell.Application
            $shell.Namespace($destinationPath).copyhere(($shell.NameSpace($filePath)).items())
        }
        catch {
            Write-Warning -Message "Unexpected Error. Error details: $_.Exception.Message"
        }
    }
}

# Set a permanent Environment variable, and reload it into $env
function SetEnvironment([String] $variable, [String] $value) {
    Set-ItemProperty "HKCU:\Environment" $variable $value
    # Manually setting Registry entry. SetEnvironmentVariable is too slow because of blocking HWND_BROADCAST
    #[System.Environment]::SetEnvironmentVariable("$variable", "$value","User")
    if ($variable.ToLower() -ne "path") {
        Invoke-Expression "`$env:${variable} = `"$value`""
    }
}

function AddPathVariable([string]$addPath) {
    if (Test-Path $addPath) {
        $regexAddPath = [regex]::Escape($addPath)

        $currentPath = Get-ItemProperty "HKCU:\Environment" Path
        $currentPath = $currentPath.Path

        $arrPath = $currentPath -split ';' | Where-Object { $_ -notMatch 
            "^$regexAddPath\\?" }
        $updatedPath = ($arrPath + $addPath) -join ';'

        SetEnvironment PATH $updatedPath

        $currentPath = $env:PATH

        $arrPath = $currentPath -split ';' | Where-Object { $_ -notMatch 
            "^$regexAddPath\\?" }
        $updatedPath = ($arrPath + $addPath) -join ';'

        $env:PATH = $updatedPath

    }
    else {
        Throw "'$addPath' is not a valid path."
    }
}

