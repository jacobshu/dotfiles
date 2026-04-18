require("conform").setup({
  formatters_by_ft = {
    html = { "oxfmt" },
    javascript = { "oxfmt" },
    typescript = { "oxfmt" },
    javascriptreact = { "oxfmt" },
    typescriptreact = { "oxfmt" },
    json = { "oxfmt" },
    jsonc = { "oxfmt" },
  },
  default_format_opts = {
    lsp_format = "fallback",
  },
})
