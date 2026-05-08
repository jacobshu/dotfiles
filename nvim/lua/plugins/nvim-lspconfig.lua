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

-- Configure pico8-ls for PICO-8 Lua files (not auto-enabled; use <leader>lp to toggle)
vim.lsp.config("pico8-ls", {
  cmd = { "node", vim.fn.stdpath("data") .. "/mason/packages/pico8-ls/server/out-min/main.js", "--stdio" },
  filetypes = { "lua" },
  root_markers = { ".p8", ".git" },
})

-- Configure clangd with a compile-commands-dir fallback
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--compile-commands-dir=.",
  },
  capabilities = {
    general = {
      -- Standard LSP 3.17 positionEncodings replaces deprecated clangd offsetEncoding extension
      positionEncodings = { "utf-16" },
    },
  },
  before_init = function(params, config)
    -- Strip the deprecated clangd-specific offsetEncoding extension from the
    -- InitializeParams Neovim sends. Neovim adds it via make_client_capabilities()
    -- regardless of user config; clangd 23 will drop support for it.
    if params and params.capabilities then
      params.capabilities.offsetEncoding = nil
    end
  end,
})
