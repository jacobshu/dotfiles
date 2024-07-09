# dotfiles

My personal configuration files for frequently used tools. 

## Tour

### `forestfox.md`

Overview of my forestfox palette. 

### `config`

Configuration files that are symlinked to the appropiate destination.

- forestfox.yaml: Warp theme config
- starship.toml: Prompt config file
- symlinks.toml: `hew load` uses this file to perform the symlinking
- tmux.conf: tmux in forestfox

### `macos`

Scripts for setting macOS defaults and installing MAS apps.

### `nvim`

Full config for neovim, including:
- `lua/jacobshu/lazy.lua`: dependency loading
- `lua/jacobshu/remap.lua`: key remapping
- `lua/jacobshu/set.lua`: setting vim options
- `lua/jacobshu/forestfox.lua`: forestfox theme palette 
- `after/plugin/`: files for configuring nvim deps

### `scripts`

Scripts for easier development
`asn.sh`: the better half
`favicon.sh`: generate favicon files and HTML 
`imagemagick.sh`: useful image manipulation scripts
`jacobshu.sh`: personal site
`node-launch.sh`: launch a JS project with optional update
`swm.sh`: swm server, database, proxy, and Vue launch
