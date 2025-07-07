return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  opts = {
    ensure_installed = {
      "astro",
      "bashls",
      "biome",
      "csharp_ls",
      "gopls",
      "lua_ls",
    }
  },
}
-- "neovim/nvim-lspconfig",
-- event = "VeryLazy",
-- dependencies = {
--   "mason-org/mason.nvim",
--   { "mason-org/mason-lspconfig.nvim", config = function() end },
-- },

--     {
--     "neovim/nvim-lspconfig"
--   },
--   {
--     "mason-org/mason.nvim",
--     opts = {}
--   },
--   {
--     "mason-org/mason-lspconfig.nvim",
--     dependencies = {
--       "neovim/nvim-lspconfig",
--       "mason-org/mason.nvim"
--     },
--     opts = {
--       ensure_installed = {
--         "astro",
--         "bashls",
--         "biome",
--         "csharp_ls",
--         "lua_ls",
--       }
--     }
--   }
-- }
