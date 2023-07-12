local Shade = require("nightfox.lib.shade")

require("nightfox").setup({
  palettes = {
    -- Custom duskfox with black background
    nightfox = {
        green = Shade.new("#A7C080", 0.15, -0.15),
    },
  },
})
