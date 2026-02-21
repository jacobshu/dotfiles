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
      "clangd",
      "csharp_ls",
      "eslint",
      "gopls",
      "lua_ls",
      "powershell_es",
      "ts_ls",
      "vue_ls",
    }
  },
  config = function(_, opts)
    require("mason-lspconfig").setup(opts)

    -- Configure clangd with a compile-commands-dir fallback
    vim.lsp.config("clangd", {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--compile-commands-dir=build",
      },
    })
  end,
}
