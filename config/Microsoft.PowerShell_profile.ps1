function cdzd { Join-Path -Path $HOME -ChildPath 'source/repos' | cd }
function cddot { Join-Path -Path $HOME -ChildPath 'source/repos/dotfiles' | cd }
function cdconfig { cd 'C:\ProgramData\zdScada\Config' }

Set-Alias -Name dev -Value cdzd
Set-Alias -Name dot -Value cddot
Set-Alias -Name cfg -Value cdconfig

$PSStyle.FileInfo.Directory = $PSStyle.Background.Hidden
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.BrightRed
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.BrightGreen

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json" | Invoke-Expression
