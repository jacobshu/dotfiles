# dotfiles

My personal configuration files for frequently used tools.

## Setup

Everything is symlinked out of this repo rather than copied, so edits here
take effect immediately. `config/symlinks.toml` is the manifest; the two
scripts read it:

```sh
scripts/create-symlinks.sh --dry-run    # macOS / Linux
```

```powershell
.\scripts\create-symlinks.ps1 -DryRun   # Windows (needs an elevated shell
                                        # or Developer Mode)
```

Drop `--dry-run` / `-DryRun` to actually link. Existing files are backed up to
`<target>.bak-<timestamp>` unless you pass `--force` / `-Force`.

Manifest notes:

- `source` paths are written relative to `$HOME`. The Windows script strips the
  `dev/dotfiles/` prefix and resolves against the repo root, so the repo can
  live anywhere on Windows.
- `target` is the Unix destination; `win_target` is the Windows one. **Windows
  linking is opt-in per entry** — an entry with no `win_target` is skipped.
- `win_target` expands environment variables (`%LOCALAPPDATA%`) plus a
  `%DOCUMENTS%` pseudo-variable that honors OneDrive folder redirection.

## Tour

### `forestfox.md`

Overview of my forestfox palette.

### `config`

Configuration files, most of them symlinked to wherever their tool expects.

Symlinked:

- `.zshrc`, `.zprofile` — shell
- `Microsoft.PowerShell_profile.ps1` — PowerShell profile
- `starship.toml` — prompt
- `tmux.conf` — tmux, in forestfox
- `wezterm.lua` — WezTerm
- `config` — ghostty config
- `forestfox` — ghostty forestfox theme
- `forestfox.yaml` — Warp forestfox theme
- `clangd/config.yaml` — see below

Not symlinked, kept as palette sources to generate the others from:

- `forestfox.json`, `forestfox.toml`, `forestfox.windows.json`

`symlinks.toml` is the manifest itself. `.vimrc` is not in the manifest.

#### `config/clangd/config.yaml`

User-level clangd config, and the reason C++ navigation works at all.

The C++ projects I work in build from `.vcxproj` via MSBuild, which emits no
`compile_commands.json`. With no compilation database clangd guesses its
flags, which on Windows means it cannot find `<windows.h>`, does not know the
project defines, and resolves nothing outside the open file. This file
supplies the MSVC and Windows SDK include paths, the MSVC compatibility
flags, and the common Win32/MFC defines.

Per-project include paths live in a `.clangd` file in each project's own repo,
not here — clangd merges the two, so this file stays generic and reusable.

Two paths in it are version-pinned and need updating when Visual Studio or the
Windows SDK is upgraded. The file says which and why.

### `macos`

Scripts for setting macOS defaults and installing MAS apps.

### `nvim`

Full Neovim config. Requires **Neovim 0.12+** — it uses `vim.pack`, the built-in
plugin manager, so there is no lazy.nvim or packer here.

- `init.lua` — entry point; requires the rest in order
- `nvim-pack-lock.json` — `vim.pack` lockfile
- `lua/options.lua` — vim options, leader, mapping timeouts
- `lua/keymaps.lua` — all global keymaps
- `lua/autocmds.lua` — autocommands, per-directory shada, PICO-8 filetype
- `lua/lsp.lua` — shared LSP capabilities and diagnostic config
- `lua/lsp/lua_ls.lua` — per-server settings
- `lua/config/lazy.lua` — the plugin list and the `require` for each plugin's
  config. Named for the plugin manager this config used to use; it drives
  `vim.pack` now.
- `lua/config/float.lua` — shared border/sizing for LSP floats
- `lua/config/forestfox.lua` — forestfox palette as a Lua table
- `lua/plugins/*.lua` — one file per plugin, each `require`d from
  `config/lazy.lua`
- `lua/pprint.lua` — colorized pretty-printer for debugging. Currently
  unreferenced.
- `after/queries/` — treesitter injection queries

#### Language support

Language servers and debug adapters are installed through Mason.

| language | server | debug adapter |
|---|---|---|
| C# | `roslyn` (via roslyn.nvim) | `netcoredbg` |
| C / C++ | `clangd` | `codelldb` |
| Lua | `lua_ls` | — |
| TS / JS | `ts_ls`, `eslint` | — |
| Vue / Astro | `vue_ls`, `astro` | — |
| Go | `gopls` | — |
| Bash | `bashls` | — |
| PowerShell | `powershell_es` | — |
| PICO-8 | `pico8-ls` (toggle with `<leader>lp`) | — |

Notes on the awkward ones:

- **C#** uses Microsoft's Roslyn server rather than `csharp_ls`, because
  `csharp_ls` only loads SDK-style projects and the solutions I work in mix
  SDK-style projects with old-style .NET Framework web projects. Roslyn loads
  the whole solution, so navigation crosses that boundary. `:Roslyn target`
  switches between solutions.
  The Roslyn build comes from the `Crashdummyy` Mason registry (configured in
  `plugins/nvim-lspconfig.lua`); mason-org's own `roslyn-language-server`
  package lags behind the version roslyn.nvim requires.
- **C++** debugging uses `codelldb`, not `cpptools` — cpptools' Windows
  debugger wraps Microsoft's `vsdbg`, which is licensed for Visual Studio and
  VS Code only. codelldb reads MSVC PDBs directly.
  Targets that build as DLLs cannot be launched; attach to the host process
  instead.
- **.NET Framework** targets cannot be debugged from Neovim at all.
  `netcoredbg` is CoreCLR-only.

#### Formatting

`conform.nvim` handles formatting, bound to `<leader>lf`. `oxfmt` covers
HTML/JS/TS/JSX/TSX/JSON; everything else falls back to whatever the attached
language server offers. There is no format-on-save.

`oxfmt` is a formatter, not a language server, so it is not in
mason-lspconfig's `ensure_installed` — install it with
`:MasonInstall oxfmt` on a new machine.

### `scripts`

- `create-symlinks.sh` / `create-symlinks.ps1`: link dotfiles per
  `config/symlinks.toml`
- `asn.sh`: the better half
- `favicon.sh`: generate favicon files and HTML
- `imagemagick.sh`: useful image manipulation scripts
- `jacobshu.sh`: personal site
- `node-launch.sh`: launch a JS project with optional update
- `swm.sh`: swm server, database, proxy, and Vue launch
