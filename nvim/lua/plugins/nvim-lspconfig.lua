require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    -- Crashdummyy's registry carries the Roslyn build that ships with the
    -- VS Code C# extension. mason-org's own `roslyn-language-server` comes
    -- from nuget.org and lags behind what roslyn.nvim requires.
    "github:Crashdummyy/mason-registry",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "astro",
    "bashls",
    "clangd",
    "eslint",
    "gopls",
    "lua_ls",
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

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--compile-commands-dir=.",
  },
  capabilities = {
    general = {
      positionEncodings = { "utf-16" },
    },
  },
  before_init = function(params, config)
    if params and params.capabilities then
      params.capabilities.offsetEncoding = nil
    end
  end,
})
