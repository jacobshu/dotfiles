local ff = require("jacobshu/forestfox")

require("everforest").setup({
  background = "medium",
  colours_override = function(palette)
    -- background neutrals
    palette.bg_dim      = ff.bg_dim      --"#232b31"
    palette.bg0         = ff.bg0         --"#283038"
    palette.bg1         = ff.bg1         --"#2e373f"
    palette.bg2         = ff.bg2         --"#374149"
    palette.bg3         = ff.bg3         --"#404b54"
    palette.bg4         = ff.bg4         --"#47525c"
    palette.bg5         = ff.bg5         --"#526564"
    -- bg colors
    palette.bg_red      = ff.bg_red      --"#513c40"
    palette.bg_visual   = ff.bg_visual   --"#563945"
    palette.bg_blue     = ff.bg_blue     --"#374b5f"
    palette.bg_green    = ff.bg_green    --"#3c4c44"
    palette.bg_yellow   = ff.bg_yellow   --"#4f4f41"
    -- foreground colors
    palette.fg          = ff.fg          --"#d0c9a1"
    palette.red         = ff.red         --"#da7280"
    palette.orange      = ff.orange      --"#eda173"
    palette.yellow      = ff.yellow      --"#dbba79"
    palette.green       = ff.green       --"#a8c180"
    palette.aqua        = ff.aqua        --"#7bc29a"
    palette.blue        = ff.blue        --"#78b1bd"
    palette.purple      = ff.purple      --"#d491b5"
    -- lighter neutrals
    palette.grey0       = ff.grey0       --"#738478"
    palette.grey1       = ff.grey1       --"#7f928d"
    palette.grey2       = ff.grey2       --"#95a8a2"
    -- accents
    palette.statusline1 = ff.statusline1 --"#7eb365"
    palette.statusline2 = ff.statusline2 --"#788492"
    palette.statusline3 = ff.statusline3 --"#e68274"
  end
})
