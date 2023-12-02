$apps = @(
    @{name = "Microsoft.PowerToys"}
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name --accept-source-agreements 
    if (![String]::Join("", $listApp).Contains($app.name)) {
        winget install --exact --silent $app.name --accept-package-agreements --disable-interactivity
    }
}

$devtoysName = "64360VelerSoftware.DevToys_j80j2txgjg9dj"
$listApp = winget list --exact -q $devtoysName --accept-source-agreements 
if (![String]::Join("", $listApp).Contains($devtoysName)) {
    $releases_url = 'https://api.github.com/repos/veler/DevToys/releases/latest'

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $releases = Invoke-RestMethod -uri $releases_url
    $latestRelease = $releases.assets | Where-Object { $_.browser_download_url.EndsWith('msixbundle') } | Select-Object -First 1

    "Installing DevToys"
    Add-AppxPackage -Path $latestRelease.browser_download_url
}
