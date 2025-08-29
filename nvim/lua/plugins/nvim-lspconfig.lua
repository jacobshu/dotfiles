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
      "csharp_ls",
      "eslint",
      "gopls",
      "lua_ls",
      "ts_ls",
      "vue_ls",
    }
  },
}
