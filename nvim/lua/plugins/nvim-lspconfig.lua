require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "astro",
    "bashls",
    "clangd",
    "csharp_ls",
    "eslint",
    "gopls",
    "lua_ls",
    "oxfmt",
    "powershell_es",
    "ts_ls",
    "vue_ls",
  },
})

-- Configure clangd with a compile-commands-dir fallback
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--compile-commands-dir=build",
  },
})
