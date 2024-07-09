local ff = require("jacobshu/forestfox")

require("everforest").setup({
  background = "medium",
  colours_override = function(palette)
    -- background neutrals
    palette.bg_dim      = ff.bg_dim
    palette.bg0         = ff.bg0
    palette.bg1         = ff.bg1
    palette.bg2         = ff.bg2
    palette.bg3         = ff.bg3
    palette.bg4         = ff.bg4
    palette.bg5         = ff.bg5
    -- bg colors
    palette.bg_red      = ff.bg_red
    palette.bg_visual   = ff.bg_visual
    palette.bg_blue     = ff.bg_blue
    palette.bg_green    = ff.bg_green
    palette.bg_yellow   = ff.bg_yellow
    -- foreground colors
    palette.fg          = ff.fg
    palette.red         = ff.red
    palette.orange      = ff.orange
    palette.yellow      = ff.yellow
    palette.green       = ff.green
    palette.aqua        = ff.aqua
    palette.blue        = ff.blue
    palette.purple      = ff.purple
    -- lighter neutrals
    palette.grey0       = ff.grey0
    palette.grey1       = ff.grey1
    palette.grey2       = ff.grey2
    -- accents
    palette.statusline1 = ff.statusline1
    palette.statusline2 = ff.statusline2
    palette.statusline3 = ff.statusline3
  end
})
