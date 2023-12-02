Write-Output "Disable Angular Telemetry"

$angularFile = "$env:HOMEPATH\.angular-config.json"
if ([System.IO.File]::Exists($angularFile)) {
    Remove-Item $angularFile -Force
}
