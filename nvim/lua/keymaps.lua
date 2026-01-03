local set = vim.keymap.set

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

-- Easier quickfix list navigation
set("n", "<C-k>", "<cmd>cnext<CR>zz")
set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Easier location list navigation
set("n", "<leader>k", "<cmd>lnext<CR>zz")
set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "search and replace word under cursor" })

set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover documentation" })

-- execute file
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "execute the current file" })

-- toggle spellcheck
set("n", "<leader>ss", "<cmd>setlocal spell!<CR>", { desc = "toggle spellcheck" })

-- LSP Code Navigation (keep 'g' prefix - it's standard)
local builtin = require("telescope.builtin")
set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
set("n", "gr", builtin.lsp_references, { desc = "Show references" })

-- LSP Actions (<leader>l namespace)
set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })
set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer" })
set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Document symbols" })
set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
set("n", "<leader>lh", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Diagnostics (<leader>d namespace)
set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })
set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix" })

-- CodeCompanion
set({ "n", "v" }, "<Leader>ia", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
set({ "n", "v" }, "<Leader>ic", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
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

-- Find/Search (<leader>f namespace)
set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
set("n", "<leader>fw", builtin.live_grep, { desc = "Find word/grep" })
set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
set("n", "<leader>fm", builtin.marks, { desc = "Find marks" })
set("n", "<leader>fr", builtin.registers, { desc = "Find registers" })
set("n", "<leader>fh", builtin.help_tags, { desc = "Find help" })

-- Project navigation (keep some <leader>p for project-related)
set("n", "<leader>pv", vim.cmd.Ex, { desc = "Project view (netrw)" })

-- Window navigation
set("n", "<leader>pk", "<C-w>k", { desc = "Move pane focus up" })
set("n", "<leader>pj", "<C-w>j", { desc = "Move pane focus down" })
set("n", "<leader>ph", "<C-w>h", { desc = "Move pane focus left" })
set("n", "<leader>pl", "<C-w>l", { desc = "Move pane focus right" })

-- Utilities
set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle undotree" })

-- Treesitter
set("n", "<leader>ti", vim.cmd.InspectTree, { desc = "Inspect tree sitter AST" })

-- LSP utilities
local lsputils = require("lsp")
set("n", "<leader>ll", lsputils.restart_lsp, { desc = "Restart LSP clients" })

-- Git operations (vim-fugitive)
set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
set("n", "<leader>ga", "<cmd>Git add %<cr>", { desc = "Git add current file" })
set("n", "<leader>gA", "<cmd>Git add .<cr>", { desc = "Git add all" })
set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
set("n", "<leader>gC", "<cmd>Git commit --amend<cr>", { desc = "Git commit amend" })
set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
set("n", "<leader>gP", "<cmd>Git pull<cr>", { desc = "Git pull" })
set("n", "<leader>gf", "<cmd>Git fetch<cr>", { desc = "Git fetch" })

-- Branch operations
set("n", "<leader>gb", builtin.git_branches, { desc = "Git branch picker" })
set("n", "<leader>gn", function()
  local branch_name = vim.fn.input("New branch name: ")
  if branch_name ~= "" then
    vim.cmd("Git switch -c " .. branch_name)
  end
end, { desc = "Git create new branch" })
set("n", "<leader>go", "<cmd>GitCheckout<cr>", { desc = "Git checkout branch" })

-- Viewing and navigation
set("n", "<leader>gl", "<cmd>Git log --oneline -20<cr>", { desc = "Git log (20 lines)" })
set("n", "<leader>gL", "<cmd>Git log --graph --oneline --all -20<cr>", { desc = "Git log graph" })
set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff split" })
set("n", "<leader>gD", "<cmd>Git diff<cr>", { desc = "Git diff" })
set("n", "<leader>gw", "<cmd>Git blame<cr>", { desc = "Git blame (who)" })

-- Merge and rebase
set("n", "<leader>gm", "<cmd>Git merge<cr>", { desc = "Git merge" })
set("n", "<leader>gr", "<cmd>Git rebase<cr>", { desc = "Git rebase" })
set("n", "<leader>gi", "<cmd>Git rebase --interactive<cr>", { desc = "Git interactive rebase" })

-- Stash operations
set("n", "<leader>gt", builtin.git_stash, { desc = "Git stash picker" })
set("n", "<leader>gS", "<cmd>Git stash<cr>", { desc = "Git stash current changes" })

-- Quick commit workflow
set("n", "<leader>gq", function()
  vim.cmd("Git add .")
  local commit_msg = vim.fn.input("Commit message: ")
  if commit_msg ~= "" then
    vim.cmd("Git commit -m '" .. commit_msg .. "'")
  end
end, { desc = "Quick commit (add all + commit)" })

-- Reset operations (optional - uncomment if needed)
-- set("n", "<leader>gR", function()
--   local confirm = vim.fn.input("Reset hard? This will lose changes! (y/N): ")
--   if confirm:lower() == "y" then
--     vim.cmd("Git reset --hard HEAD")
--   end
-- end, { desc = "Git reset hard (dangerous!)" })

-- Gitsigns operations
local gs = require('gitsigns')

-- Navigation
set('n', ']c', function()
  if vim.wo.diff then return ']c' end
  vim.schedule(function() gs.next_hunk() end)
  return '<Ignore>'
end, {expr=true, desc = 'Next git hunk'})

set('n', '[c', function()
  if vim.wo.diff then return '[c' end
  vim.schedule(function() gs.prev_hunk() end)
  return '<Ignore>'
end, {expr=true, desc = 'Previous git hunk'})

-- Hunk operations
set('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
set('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
set('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Stage hunk selection' })
set('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Reset hunk selection' })
set('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
set('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
set('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
set('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
set('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = 'Blame line' })
set('n', '<leader>hd', gs.diffthis, { desc = 'Diff this' })
set('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'Diff this ~' })
-- set('n', '<leader>hd', gs.toggle_deleted, { desc = 'Toggle deleted' })

-- Text object
set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
