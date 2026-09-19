-- Animated cursor trail.
local ff = require("config.forestfox")

require("smear_cursor").setup({
  -- everforest defines `Cursor` as `reverse = true` with no actual gui
  -- colour, so smear-cursor's default (read the Cursor highlight) has
  -- nothing to read. A reverse-video cursor renders as Normal's foreground,
  -- which under everforest is #cfc2a4 -- exactly ff.fg. Setting it from the
  -- palette makes the smear match the real cursor, and matches how lualine
  -- and the colorscheme overrides already source their colours.
  -- kanagawa does set a real Cursor colour, but the forestfox tone is close
  -- and the rest of the UI stays forestfox under kanagawa anyway.
  cursor_color = ff.fg,

  -- vertical_bar_cursor_insert_mode = false,
  -- horizontal_bar_cursor_replace_mode = false,

  -- Leave `legacy_computing_symbols_support` at its default of false. Turning
  -- it on makes the smear blend better, but only if the terminal font carries
  -- the Symbols for Legacy Computing block (U+1FB00-U+1FBFF). Worth trying;
  -- if the smear renders as tofu or boxes, it is not supported and this is why.
})
