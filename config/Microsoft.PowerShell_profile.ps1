function cdzd { Join-Path -Path $HOME -ChildPath 'source/repos' | Set-Location }
function cddot { Join-Path -Path $HOME -ChildPath 'source/repos/dotfiles' | Set-Location }
function editconfig { nvim 'C:\ProgramData\zdScada\Config' }
function cdlogs { Set-Location 'C:\ProgramData\zdScada\Logs' }

Set-Alias -Name dev -Value cdzd
Set-Alias -Name dot -Value cddot
Set-Alias -Name cfg -Value editconfig
Set-Alias -Name logs -Value cdlogs
Set-Alias -Name runzd -Value Run-ZdProjects

$PSStyle.FileInfo.Directory = $PSStyle.Background.Hidden
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.BrightRed
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.BrightGreen

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json" | Invoke-Expression
