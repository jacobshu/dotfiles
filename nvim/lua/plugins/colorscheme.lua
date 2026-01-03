local ff = require("config.forestfox")

return {
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    opts = {
      background = "medium",
      transparent_background_level = 0,
      italics = false,
      disable_italic_comments = false,
      sign_column_background = "grey",
      ui_contrast = "low",
      dim_inactive_windows = false,
      diagnostic_text_highlight = false,
      diagnostic_virtual_text = "coloured",
      diagnostic_line_highlight = false,
      spell_foreground = false,
      show_eob = true,
      float_style = "bright",
      inlay_hints_background = "dimmed",
      on_highlights = function() end,
      colours_override = function(palette)
        -- background neutrals
        palette.bg_dim = ff.bg_dim
        palette.bg0 = ff.bg0
        palette.bg1 = ff.bg1
        palette.bg2 = ff.bg2
        palette.bg3 = ff.bg3
        palette.bg4 = ff.bg4
        palette.bg5 = ff.bg5
        -- bg colors
        palette.bg_red = ff.bg_red
        palette.bg_visual = ff.bg_magenta
        palette.bg_blue = ff.bg_blue
        palette.bg_green = ff.bg_green
        palette.bg_yellow = ff.bg_yellow
        -- foreground colors
        palette.fg = ff.fg
        palette.red = ff.red
        palette.orange = ff.orange
        palette.yellow = ff.yellow
        palette.green = ff.green
        palette.aqua = ff.aqua
        palette.blue = ff.blue
        palette.purple = ff.purple
        -- lighter neutrals
        palette.grey0 = ff.grey0
        palette.grey1 = ff.grey1
        palette.grey2 = ff.grey2
        -- accents
        palette.statusline1 = ff.green
        palette.statusline2 = ff.fg
        palette.statusline3 = ff.red
      end,
    },
    config = function()
      -- require("custom/everforest")
      vim.cmd.colorscheme("everforest")
    end,
  },
}
