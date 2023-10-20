require("everforest").setup({
  background = "medium",
  colours_override = function(palette)
    -- background neutrals
    palette.bg_dim      = "#232b31"
    palette.bg0         = "#283038"
    palette.bg1         = "#2e373f"
    palette.bg2         = "#374149"
    palette.bg3         = "#404b54"
    palette.bg4         = "#47525c"
    palette.bg5         = "#526564"
    -- bg colors
    palette.bg_red      = "#513c40"
    palette.bg_visual   = "#563945"
    palette.bg_blue     = "#374b5f"
    palette.bg_green    = "#3c4c44"
    palette.bg_yellow   = "#4f4f41"
    -- foreground colors
    palette.fg          = "#d0c9a1"
    palette.red         = "#da7280"
    palette.orange      = "#eda173"
    palette.yellow      = "#dbba79"
    palette.green       = "#a8c180"
    palette.aqua        = "#7bc29a"
    palette.blue        = "#78b1bd"
    palette.purple      = "#d491b5"
    -- lighter neutrals
    palette.grey0       = "#738478"
    palette.grey1       = "#7f928d"
    palette.grey2       = "#95a8a2"
    -- accents
    palette.statusline1 = "#7eb365"
    palette.statusline2 = "#788492"
    palette.statusline3 = "#e68274"
  end
})
