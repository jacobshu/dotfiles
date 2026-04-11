return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      parsers = {
        css = true,
        css_fn = true,
        display = {
          mode = "virtualtext",
          virtualtext = {
            character = "●",
            hl_mode = "background",
            position = "before"
          },
        }
      }
    },
  }
}
