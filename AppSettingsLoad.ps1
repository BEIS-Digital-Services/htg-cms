param([string]$webApp="", [string]$resourceGroup="") 

Write-Output "------------  AppSettingsLoad.ps1 ---------------"

$expression = "& az webapp config connection-string list --name ""$webApp"" --resource-group ""$resourceGroup"""
$Output = Invoke-Expression $expression
$connectionStrings = $Output | ConvertFrom-Json
Write-Output "connectionStrings: $($connectionStrings.length)"

$connectionString = $connectionStrings | Where-Object { $_.name -eq "AppConfig" } | Select-Object -First 1

$expression = "& az appconfig kv list --connection-string ""$($connectionString.value)"""
$Output = Invoke-Expression $expression
$settings = $Output | ConvertFrom-Json
Write-Output "settings: $($settings.length)"

$pathConfig = ".\config\database.js"
Write-Output "pathConfig: $pathConfig"

$content = Get-Content -Path $pathConfig
Write-Output "Config length: $($content.Length)"

for($i=0; $i -lt $settings.length; $i++)
{    
    $content = $content -replace "{{$($settings[$i].key)}}", $settings[$i].value
    Write-Output "Replacing {{$($settings[$i].key)}}"
}

$content | Set-Content -Path $pathConfig

Write-Output "---------------------------------------"