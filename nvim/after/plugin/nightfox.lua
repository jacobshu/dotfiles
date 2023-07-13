local Shade = require("nightfox.lib.shade")

require("nightfox").setup({
  palettes = {
    -- Forestfox overrides
    nightfox = {
      black   = Shade.new("#373c44", 0.15, -0.15),
      red     = Shade.new("#d86575", 0.15, -0.15),
      green   = Shade.new("#86b981", 0.10, -0.15),
      yellow  = Shade.new("#dbbe7a", 0.15, -0.15),
      blue    = Shade.new("#79b7c9", 0.15, -0.15),
      magenta = Shade.new("#b189d6", 0.30, -0.15),
      cyan    = Shade.new("#74c8a9", 0.15, -0.15),
      white   = Shade.new("#d9d5c4", 0.15, -0.15),
      orange  = Shade.new("#ed9c6b", 0.15, -0.15),
      pink    = Shade.new("#d68ac0", 0.15, -0.15),
     
      comment = "#7c9290",

      bg0     = "#1a2229", -- Dark bg (status line and float)
      bg1     = "#222c35", -- Default bg
      bg2     = "#2a3642", -- Lighter bg (colorcolm folds)
      bg3     = "#33424e", -- Lighter bg (cursor line)
      bg4     = "#415363", -- Conceal, border fg

      fg0     = "#ced5c4", -- Lighter fg
      fg1     = "#d1cabc", -- Default fg
      fg2     = "#929a97", -- Darker fg (status line)
      fg3     = "#809794", -- Darker fg (line numbers, fold colums)

      sel0    = "#2d3a46", -- Popup bg, visual selection bg
      sel1    = "#3a515d", -- Popup sel bg, search bg
    },
  },
})

