function cdzd { Join-Path -Path $HOME -ChildPath 'source/repos' | cd }
function cddot { Join-Path -Path $HOME -ChildPath 'source/repos/dotfiles' | cd }
function cdconfig { cd 'C:\ProgramData\zdScada\Config' }
function Run-ZdProjects {
    param(
        [string[]]$ProjectPaths = @(
            "C:\Users\jacob.shulenberger\source\repos\zdWeb\zdWeb\zdWeb.csproj",
            "C:\Users\jacob.shulenberger\source\repos\zdWeb\zdApi\zdApi.csproj",
            "C:\Users\jacob.shulenberger\source\repos\zdWeb\zdAuth\zdAuth.csproj"
        ),
        [string]$Configuration = "Debug",
        [string]$Architecture = "x64",
        [string]$VSToolsPath = "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Microsoft\VisualStudio\v17.0\WebApplications\Microsoft.WebApplication.targets"
    )

    $tabCommands = @()
    foreach ($proj in $ProjectPaths) {
        $projDir = Split-Path -Parent $proj
        $tabTitle = [System.IO.Path]::GetFileNameWithoutExtension($proj)
        $runCmd = "cd `"$projDir`"; `$env:VSToolsPath=`"$VSToolsPath`"; dotnet watch run --project `"$proj`" -c $Configuration -a $Architecture"
        $tabCommands += "new-tab --title `"$tabTitle`" pwsh -NoExit -Command `$`"$runCmd`$`""
    }
    $wtCommand = "wt " + ($tabCommands -join " ; ")
    Invoke-Expression $wtCommand
}

function Dev-Tail {
  param (
      [Parameter(Mandatory, ValueFromRemainingArguments)]
      [string[]]$Files
  )

  $streams = @()
  foreach ($file in $Files) {
      if (Test-Path $file) {
          $fs = [System.IO.File]::Open($file, 'Open', 'Read', 'ReadWrite')
          $fs.Seek(0, [System.IO.SeekOrigin]::End) | Out-Null
          $streams += [PSCustomObject]@{ Name = $file; Stream = $fs }
      } else {
          Write-Host "File not found: $file" -ForegroundColor Red
      }
  }

  try {
      while ($true) {
          foreach ($s in $streams) {
              $reader = New-Object System.IO.StreamReader($s.Stream)
              while (-not $reader.EndOfStream) {
                  $line = $reader.ReadLine()
                  if ($line -ne $null) {
                      Write-Host "$($s.Name): $line"
                  }
              }
              $reader.Dispose()
          }
          Start-Sleep -Milliseconds 500
      }
  } finally {
      foreach ($s in $streams) {
          $s.Stream.Dispose()
      }
  }
}

Set-Alias -Name dev -Value cdzd
Set-Alias -Name dot -Value cddot
Set-Alias -Name cfg -Value cdconfig
Set-Alias -Name runzd -Value Run-ZdProjects

$PSStyle.FileInfo.Directory = $PSStyle.Background.Hidden
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.BrightRed
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Foreground.BrightGreen

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/tokyonight_storm.omp.json" | Invoke-Expression
