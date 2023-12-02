Write-Output "Updating already installed Apps"

winget upgrade --silent --accept-package-agreements --all

$apps = @(
    @{name = "ajeetdsouza.zoxide" },
    @{name = "aristocratos.btop4win"},
    @{name = "Azul.Zulu.17.JDK" },
    @{name = "Canonical.Ubuntu.2204" },
    @{name = "dandavison.delta" },
    @{name = "Google.Chrome" },
    @{name = "Insomnia.Insomnia" },
    @{name = "JanDeDobbeleer.OhMyPosh"; location = "$env:HOMEDRIVE$env:HOMEPATH\AppData\Local\Programs\oh-my-posh" },
    @{name = "JetBrains.IntelliJIDEA.Ultimate"; location = "$env:HOMEDRIVE$env:HOMEPATH\AppData\Local\JetBrains\IntelliJ" },
    @{name = "jftuga.less" },
    @{name = "junegunn.fzf" },
    @{name = "KeePassXCTeam.KeePassXC" },
    @{name = "lsd-rs.lsd" },
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "Mozilla.Firefox" },
    @{name = "OpenJS.NodeJS.LTS" },
    @{name = "sharkdp.bat" }
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name --accept-source-agreements 
    if (![String]::Join("", $listApp).Contains($app.name)) {
        if ($null -ne $app.location) {
            winget install --exact --silent $app.name --accept-package-agreements --disable-interactivity -l $app.location
        }
        else {
            winget install --exact --silent $app.name --accept-package-agreements --disable-interactivity
        }
    }
}

