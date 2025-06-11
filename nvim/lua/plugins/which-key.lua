return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 300,
    icons = {
      rules = false,
      breadcrumb = " ", -- active key combo
      separator = "󱦰  ", -- between a key and it's label
      group = "󰹍 ",
    },
  },
    keys = {
      {
        "<leader>?", 
        function () 
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }

