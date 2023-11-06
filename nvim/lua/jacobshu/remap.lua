-- Set leader key
vim.g.mapleader = " "

-- Shortcut for opening netrw explore 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move visually selected blocks vertically
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Allow pasting yanked text without yanking the replaced text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete into the blackhole register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- No macro replay
vim.keymap.set("n", "Q", "<nop>")

-- Format with LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Easier quickfix list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Easier location list navigation 
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search/replace for word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
