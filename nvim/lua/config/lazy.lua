vim.pack.add({
  -- Dependencies (listed before plugins that need them)
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/rcarriga/nvim-notify",
  "https://github.com/saadparwaiz1/cmp_luasnip",

  -- Plugins
  "https://github.com/S1M0N38/love2d.nvim",
  "https://github.com/ThePrimeagen/99",
  "https://github.com/catgoose/nvim-colorizer.lua",
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/goolord/alpha-nvim",
  "https://github.com/hat0uma/csvview.nvim",
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/jiaoshijie/undotree",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/neanias/everforest-nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/rcarriga/nvim-dap-ui",
  "https://github.com/rebelot/kanagawa.nvim",
  "https://github.com/romus204/tree-sitter-manager.nvim",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/tpope/vim-fugitive",
  { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

-- Load plugin configurations
require("plugins.99")
require("plugins.alpha")
require("plugins.cmp")
require("plugins.colorizer")
require("plugins.colorscheme")
require("plugins.conform")
require("plugins.csvview")
require("plugins.gitsigns")
require("plugins.harpoon")
require("plugins.kanagawa")
require("plugins.love2d")
require("plugins.lualine")
require("plugins.mini")
require("plugins.nvim-dap")
require("plugins.nvim-lspconfig")
require("plugins.nvim-notify")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.undotree")
require("plugins.vimfugitive")
require("plugins.which-key")
