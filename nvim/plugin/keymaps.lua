local set = vim.keymap.set

-- Shortcut for opening netrw explore
set("n", "<leader>pv", vim.cmd.Ex)

-- Move visually selected blocks vertically
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- splits navigation: tjdevries
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

-- split sizing (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

-- set("n", "J", "mzJ`z")
-- set("n", "<C-d>", "<C-d>zz")
-- set("n", "<C-u>", "<C-u>zz")
-- set("n", "n", "nzzzv")
-- set("n", "N", "Nzzzv")

-- Allow pasting yanked text without yanking the replaced text
set("x", "<leader>p", [["_dP]])

-- Yank selection to system clipboard : asbjornHaland
set({ "n", "v" }, "<leader>y", [["+y]])
-- Yank line to system clipboard : asbjornHaland
set("n", "<leader>Y", [["+Y]])

-- Delete into the blackhole register
set({ "n", "v" }, "<leader>d", [["_d]])

-- No macro replay
set("n", "Q", "<nop>")

-- Format with LSP
set("n", "<leader>f", vim.lsp.buf.format)

-- Easier quickfix list navigation
set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Easier location list navigation
set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- search/replace for word under cursor
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- execute file
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- toggle spellcheck
set("n", "<leader>ss", "<cmd>setlocal spell!<CR>")
