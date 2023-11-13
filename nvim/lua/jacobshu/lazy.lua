local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath
    }
  )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
  {
    -- themes
    "EdenEast/nightfox.nvim",
    {
      "neanias/everforest-nvim",
      version = false,
      lazy = false,
      priority = 1000 -- make sure to load this before all the other start plugins
    },

    -- tools for moving around
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" }
    },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/playground",
    "theprimeagen/harpoon",

    -- editing and version control
    "mbbill/undotree",
    "tpope/vim-fugitive",
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({})
      end
    },
    {
      'numToStr/Comment.nvim',
      opts = {
        -- add any options here
      },
      lazy = false,
    },

    -- copilot & lsp
    "https://github.com/github/copilot.vim.git",
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v3.x",
      dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" }, -- Required
        {
          -- Optional
          "williamboman/mason.nvim",
          build = function()
            pcall(vim.cmd, "MasonUpdate")
          end
        },
        { "williamboman/mason-lspconfig.nvim" }, -- Optional
        -- Autocompletion
        { "hrsh7th/nvim-cmp" },                  -- Required
        { "hrsh7th/cmp-nvim-lsp" },              -- Required
        { "L3MON4D3/LuaSnip" }                   -- Required
      }
    },
    {
      'akinsho/flutter-tools.nvim',
      lazy = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
      },
      config = true,
    },
    { 'mfussenegger/nvim-dap' },
    { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  }
)
