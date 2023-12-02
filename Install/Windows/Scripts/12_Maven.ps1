Write-Output "Installing Maven"

$toolsDir = "$env:HOMEDRIVE\Projects\tools"
$mavenDir = "$toolsDir\apache-maven-3.9.5"

if (![System.IO.Directory]::Exists($mavenDir)) {
    $tmpDir = Join-Path $env:TEMP "configurator"
    if (![System.IO.Directory]::Exists($tmpDir)) { 
        [System.IO.Directory]::CreateDirectory($tmpDir) 
    }

    $mavenZip = Join-Path $tmpDir "maven.zip"
    DownloadFile "https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.zip" $mavenZip

    if (![System.IO.Directory]::Exists($toolsDir)) { 
        [System.IO.Directory]::CreateDirectory($toolsDir) 
    }
    UnzipFile $mavenZip $toolsDir

    Remove-Item $tmpDir -Force -Recurse

    SetEnvironment MAVEN_HOME $mavenDir
    AddPathVariable "$mavenDir\bin"

    $mavenM2 = "$HOME/.m2"
    if (![System.IO.Directory]::Exists($mavenM2)) {
        mkdir $mavenM2
    }
    $mavenM2Settings = "$mavenM2/settings.xml"
    if ([System.IO.File]::Exists($mavenM2Settings)) {
        Move-Item $HOME/.m2/settings.xml $HOME/.m2/settings.xml.bak
    }

    Copy-Item $HOME/.config/Install/Maven/settings.xml $HOME/.m2/settings.xml
}
