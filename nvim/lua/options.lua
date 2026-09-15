local opt = vim.opt

vim.g.mapleader = " "

-- Border for floats we don't open ourselves (rename prompt, vim.ui inputs).
-- 'winborder' is a string option, so a table-style border in config.float
-- applies only where we pass opts explicitly.
local float_border = require("config.float").border
if type(float_border) == "string" then
  vim.o.winborder = float_border
end

opt.guicursor = "a:block,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

-- You have to turn this one on :)
opt.inccommand = "split"

-- Best search settings :)
opt.smartcase = true
opt.ignorecase = true

opt.number = true
opt.relativenumber = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = false

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

opt.smartindent = true

opt.wrap = true

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.showmode = false
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "80"

-- Mapping timeouts.
-- 'timeoutlen' is how long Neovim waits for the rest of a mapped sequence.
-- The default 1000 makes any bare map that is also the prefix of a longer one
-- (<leader>d, <leader>s, gr) feel like a hang. 400 is short enough that a
-- collision reads as a beat instead of a freeze, and long enough to still
-- type <leader>fw comfortably. which-key's own popup delay is 300.
opt.timeoutlen = 400
-- 'ttimeoutlen' is a different clock: it times terminal escape sequences.
-- Keep it tiny so <Esc> out of insert mode is instant.
opt.ttimeoutlen = 10
