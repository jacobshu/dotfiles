vim.g._start_hrtime = vim.uv.hrtime()

require("options")

require("config.lazy")
require("autocmds")
require("lsp")
require("keymaps")

vim.cmd.colorscheme("everforest")