local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.default_prog = { 'pwsh.exe', '-NoLogo' }

config.initial_cols = 100
config.initial_rows = 50

config.font_size = 10
config.color_scheme = 'Everforest'

return config


-- ("Everforest Dark Medium (Gogh)", "[colors]
-- ansi = [
--     "#343f44",
--     "#e67e80",
--     "#a7c080",
--     "#dbbc7f",
--     "#7fbbb3",
--     "#d699b6",
--     "#83c092",
--     "#d3c6aa",
-- ]
-- background = "#2d353b"
-- brights = [
--     "#5c6a72",
--     "#f85552",
--     "#8da101",
--     "#dfa000",
--     "#3a94c5",
--     "#df69ba",
--     "#35a77c",
--     "#dfddc8",
-- ]
--
-- cursor_bg = "#d3c6aa"
-- cursor_border = "#d3c6aa"
-- cursor_fg = "#2d353b"
-- foreground = "#d3c6aa"
--
-- [colors.indexed]
--
-- [metadata]
-- aliases = []
-- name = "forestfox"
-- "),
--
