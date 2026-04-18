vim.pack.add({
  -- Dependencies (listed before plugins that need them)
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-neotest/nvim-nio',

  -- Plugins
  'https://github.com/neanias/everforest-nvim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/goolord/alpha-nvim',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/jiaoshijie/undotree',
  'https://github.com/catgoose/nvim-colorizer.lua',
  'https://github.com/hat0uma/csvview.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/romus204/tree-sitter-manager.nvim',
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/S1M0N38/love2d.nvim',
  'https://github.com/ThePrimeagen/99',
})

-- Load plugin configurations
require("plugins.colorscheme")
require("plugins.kanagawa")
require("plugins.lualine")
require("plugins.alpha")
require("plugins.which-key")
require("plugins.cmp")
require("plugins.conform")
require("plugins.gitsigns")
require("plugins.vimfugitive")
require("plugins.mini")
require("plugins.undotree")
require("plugins.colorizer")
require("plugins.csvview")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.nvim-lspconfig")
require("plugins.treesitter")
require("plugins.nvim-dap")
require("plugins.love2d")
require("plugins.99")
