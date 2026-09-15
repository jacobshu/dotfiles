local M = {}

local float = require("config.float")

-- Every server gets nvim-cmp's capabilities, not just lua_ls. This is what
-- turns on snippetSupport (LSP-side snippets like C# method stubs expand
-- instead of pasting literal ${1:...}) and resolveSupport (docs/detail
-- filled in lazily). '*' is merged into every vim.lsp.config() entry.
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
  capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end
vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", require("lsp.lua_ls"))

vim.diagnostic.config({
  virtual_lines = true,
  current_line = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  -- A function, not a table, so the size caps track terminal resizes.
  float = function() return float.opts({ source = true }) end,
  -- Show the diagnostic float after [d / ]d. Replaces the deprecated
  -- jump({ float = true }); border and sizing still come from `float` above.
  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

function M.toggle_pico8()
  local bufnr = vim.api.nvim_get_current_buf()
  local has_pico8 = false
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if c.name == "pico8-ls" then has_pico8 = true end
  end

  vim.treesitter.stop(bufnr)
  if has_pico8 then
    vim.lsp.enable("pico8-ls", false)
    vim.treesitter.start(bufnr, "lua")
    vim.lsp.enable("lua_ls")
    vim.notify("Switched to lua_ls", vim.log.levels.INFO)
  else
    vim.lsp.enable("lua_ls", false)
    vim.treesitter.start(bufnr, "pico8")
    vim.lsp.enable("pico8-ls")
    vim.notify("Switched to pico8-ls", vim.log.levels.INFO)
  end
end

function M.restart_lsp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  for _, c in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    c:stop()
  end
  vim.defer_fn(function() vim.cmd("edit") end, 100)
end

-- Server status/capabilities/diagnostic counts are covered by
-- `:checkhealth vim.lsp` and nvim-lspconfig's own :LspInfo / :LspLog.

return M
