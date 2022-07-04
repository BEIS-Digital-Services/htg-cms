
Write-Output "------------  AppSettingsLoad.ps1 ---------------"

Write-Output "AppConfig: $($Env:AppConfig)"

$expression = "& az appconfig kv list --connection-string ""$Env:AppConfig"""
$Output = Invoke-Expression $expression
$settings = $Output | ConvertFrom-Json
Write-Output "settings: $($settings.length)"

# $pathConfig = "D:\Solutions\Production\BEIS\HelpToGrow\htg-cms\config\database.js"
$pathConfig = "$(Build.SourcesDirectory)\config\database.js"
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