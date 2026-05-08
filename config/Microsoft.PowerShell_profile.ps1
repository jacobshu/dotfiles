function cdzd { Join-Path -Path $HOME -ChildPath 'source/repos' | Set-Location }
function cddot { Join-Path -Path $HOME -ChildPath 'source/repos/dotfiles' | Set-Location }
function editconfig { nvim 'C:\ProgramData\zdScada\Config' }
function cdlogs { Set-Location 'C:\ProgramData\zdScada\Logs' }

Set-Alias -Name dev -Value cdzd
Set-Alias -Name dot -Value cddot
Set-Alias -Name cfg -Value editconfig
Set-Alias -Name logs -Value cdlogs
Set-Alias -Name runzd -Value Run-ZdProjects
Set-Alias pico8 "C:\Program Files (x86)\PICO-8\pico8.exe"

function New-P8Project {
    param([Parameter(Mandatory)][string]$Name)
    New-Item -ItemType Directory -Path $Name -Force | Out-Null
    Set-Content -Path (Join-Path $Name "$Name.p8") -Value "pico-8 cartridge // http://www.pico-8.com`nversion 43`n__lua__"
    Set-Content -Path (Join-Path $Name "main.lua") -Value "-- $Name`n-- by jacobshu"
}

Set-Alias -Name new-p8 -Value New-P8Project

$PSStyle.FileInfo.Directory = $PSStyle.Background.Hidden
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.BrightRed
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.BrightGreen

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json" | Invoke-Expression
