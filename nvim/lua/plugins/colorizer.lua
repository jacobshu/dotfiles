require("colorizer").setup({
  parsers = {
    css = false,
    css_fn = true,
    rgb = { enable = true },
    hsl = { enable = true },
    oklch = { enable = true },
    hwb = { enable = true },
    lab = { enable = true },
    lch = { enable = true },
    display = {
      mode = "virtualtext",
      virtualtext = {
        character = "●",
        hl_mode = "background",
        position = "before"
      },
    }
  }
})
