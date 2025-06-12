local set = vim.keymap.set

set("n", "<leader>pv", vim.cmd.Ex, { desc = "browse project (netrw)" })

set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected block down" })
set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected block down" })

-- Allow pasting yanked text without yanking the replaced text
set("x", "<leader>p", [["_dP]])

-- asbjornHaland
set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank text to clipboard" })
set("n", "<leader>Y", [["+Y]], { desc = "yank line to clipboard" })

-- Delete into the blackhole register
set({ "n", "v" }, "<leader>d", [["_d]])

-- No macro replay
set("n", "Q", "<nop>")

-- Format with LSP
set("n", "<leader>f", vim.lsp.buf.format, { desc = "format current buffer" })

-- Easier quickfix list navigation
set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Easier location list navigation
set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")

set("n", "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "search and replace word under cursor" }
)

-- execute file
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "execute the current file" })

-- toggle spellcheck
set("n", "<leader>ss", "<cmd>setlocal spell!<CR>", { desc = "toggle spellcheck" })

-- CodeCompanion
set({ "n", "v" }, "<Leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
set({ "n", "v" }, "<Leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
set("v", "<Leader>ah", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
set("n", "<leader>a", mark.add_file, { desc = "add file to harpoon list" })
set("n", "<leader>\\", ui.toggle_quick_menu, { desc = "show harpoon marks" })
set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "nav to harpoon file 1" })
set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "nav to harpoon file 2" })
set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "nav to harpoon file 3" })
set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "nav to harpoon file 4" })
set("n", "<leader>5", function() ui.nav_file(5) end, { desc = "nav to harpoon file 5" })

-- telescope
local builtin = require("telescope.builtin")
set("n", "<leader>pf", builtin.find_files, { desc = "list files in cwd" })
set("n", "<leader>ps", builtin.git_files, { desc = "list git files" })
set("n", "<leader>pm", builtin.marks, { desc = "list marks" })
set("n", "<leader>pr", builtin.registers, { desc = "list registers" })
set("n", "<leader>pg", builtin.live_grep, { desc = "live grep the project" })

-- undotree
set("n", "<leader>U", vim.cmd.UndotreeToggle, { desc = "open undotree" })

-- completion scrolling
-- set("i", '"', '""<left>', { noremap = true })
