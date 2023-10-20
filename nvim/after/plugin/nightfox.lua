local Shade = require("nightfox.lib.shade")

require("nightfox").setup({
  palettes = {
    -- Forestfox overrides
    nightfox = {
      black   = Shade.new("#373c44", "#555960", "#2f333a"),
      red     = Shade.new("#d86575", "#de7c8a", "#b85663"),
      green   = Shade.new("#86b981", "#92c08e", "#729d6e"),
      yellow  = Shade.new("#dbbe7a", "#e0c88e", "#baa268"),
      blue    = Shade.new("#79b7c9", "#8dc2d1", "#679cab"),
      magenta = Shade.new("#b189d6", "#c8ace2", "#9674b6"),
      cyan    = Shade.new("#74c8a9", "#89d0b6", "#63aa90"),
      white   = Shade.new("#d9d5c4", "#dfdbcd", "#b8b5a7"),
      orange  = Shade.new("#ed9c6b", "#f0ab81", "#c9855b"),
      pink    = Shade.new("#d68ac0", "#dc9cc9", "#b675a3"),

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
