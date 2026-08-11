<#
.SYNOPSIS
    Creates symlinks for the dotfiles listed in config/symlinks.toml.

.DESCRIPTION
    Windows counterpart of scripts/create-symlinks.sh. Only entries that
    declare a non-empty `win_target` field are linked, making Windows
    symlink creation opt-in per entry.

    - `source` paths in symlinks.toml are written relative to $HOME on
      Unix (e.g. dev/dotfiles/config/wezterm.lua). On Windows the
      "dev/dotfiles/" prefix is stripped and the remainder is resolved
      against this repository's root, so the repo can live anywhere.
    - `win_target` paths are relative to $HOME unless they are absolute
      (e.g. C:\... ) or contain environment variables (e.g. %LOCALAPPDATA%\nvim),
      which are expanded. The pseudo-variable %DOCUMENTS% resolves to the
      user's Documents folder (honoring OneDrive/folder redirection).
    - Existing targets that are not already the correct symlink are backed
      up to <target>.bak-<timestamp> unless -Force is passed, in which case
      they are removed.

    Creating symlinks on Windows requires either an elevated (Administrator)
    shell or Developer Mode enabled.

.PARAMETER DryRun
    Show what would happen without making any changes.

.PARAMETER Force
    Overwrite existing files instead of backing them up.

.EXAMPLE
    .\scripts\create-symlinks.ps1
    .\scripts\create-symlinks.ps1 -DryRun
    .\scripts\create-symlinks.ps1 -Force
#>
[CmdletBinding()]
param(
    [switch]$DryRun,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot
$TomlFile = Join-Path $RepoRoot 'config\symlinks.toml'

if (-not (Test-Path -LiteralPath $TomlFile)) {
    Write-Error "Could not find $TomlFile"
    exit 1
}

function Resolve-SourcePath {
    param([string]$Path)
    # Strip the Unix-side "dev/dotfiles/" repo prefix and resolve against
    # this repository's root.
    $rel = $Path -replace '^dev/dotfiles/?', ''
    return (Join-Path $RepoRoot ($rel -replace '/', '\'))
}

function Resolve-TargetPath {
    param([string]$Path)
    # %DOCUMENTS% resolves to the real Documents folder, which may be
    # redirected (e.g. to OneDrive) and thus has no environment variable.
    $documents = [Environment]::GetFolderPath('MyDocuments')
    $expanded = $Path.Replace('%DOCUMENTS%', $documents)
    $expanded = [Environment]::ExpandEnvironmentVariables($expanded) -replace '/', '\'
    if ([System.IO.Path]::IsPathRooted($expanded)) {
        return $expanded
    }
    return (Join-Path $HOME $expanded)
}

function New-DotfileLink {
    param(
        [string]$SourcePath,
        [string]$TargetPath
    )

    if (-not (Test-Path -LiteralPath $SourcePath)) {
        Write-Warning "SKIP  (missing source) $SourcePath"
        return
    }

    # Already linked correctly.
    $existing = Get-Item -LiteralPath $TargetPath -ErrorAction SilentlyContinue
    if ($existing -and $existing.LinkType -eq 'SymbolicLink' -and $existing.Target -eq $SourcePath) {
        Write-Host "OK    $TargetPath -> $SourcePath"
        return
    }

    if ($existing) {
        if ($Force) {
            Write-Host "RM    $TargetPath"
            if (-not $DryRun) {
                if ($existing.LinkType -eq 'SymbolicLink') {
                    $existing.Delete()
                } else {
                    Remove-Item -LiteralPath $TargetPath -Recurse -Force
                }
            }
        } else {
            $backup = "$TargetPath.bak-$(Get-Date -Format 'yyyyMMddHHmmss')"
            Write-Host "BACKUP $TargetPath -> $backup"
            if (-not $DryRun) {
                Move-Item -LiteralPath $TargetPath -Destination $backup
            }
        }
    }

    $targetDir = Split-Path -Parent $TargetPath
    if ($targetDir -and -not (Test-Path -LiteralPath $targetDir)) {
        Write-Host "MKDIR $targetDir"
        if (-not $DryRun) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
    }

    Write-Host "LINK  $TargetPath -> $SourcePath"
    if (-not $DryRun) {
        try {
            New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath | Out-Null
        } catch {
            Write-Error ("Failed to create symlink: $($_.Exception.Message)`n" +
                'Creating symlinks on Windows requires an elevated shell or Developer Mode.')
        }
    }
}

# Parse the [[dotfiles]] entries out of symlinks.toml. The format is a
# small, predictable subset of TOML (one key per line), so a simple line
# scan is enough and avoids requiring a TOML parser as a dependency.
$entry = $null

function Complete-Entry {
    param($Entry)
    if (-not $Entry) { return }
    if (-not $Entry.source) { return }
    if (-not $Entry.win_target) {
        # No win_target (or empty) means the entry is not opted in on Windows.
        Write-Host "SKIP  (no win_target) $($Entry.source)"
        return
    }
    New-DotfileLink -SourcePath (Resolve-SourcePath $Entry.source) `
                    -TargetPath (Resolve-TargetPath $Entry.win_target)
}

foreach ($rawLine in Get-Content -LiteralPath $TomlFile) {
    $line = $rawLine.Trim()

    if ($line -eq '[[dotfiles]]') {
        Complete-Entry $entry
        $entry = @{ source = ''; win_target = '' }
        continue
    }

    if (-not $entry) { continue }

    if ($line -match '^source\s*=\s*"(.*)"$') {
        $entry.source = $Matches[1]
    } elseif ($line -match '^win_target\s*=\s*"(.*)"$') {
        $entry.win_target = $Matches[1]
    }
}

Complete-Entry $entry
