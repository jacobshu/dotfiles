local set = vim.keymap.set
local float = require("config.float")
vim.notify = require("notify")

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
set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "search and replace word under cursor" })

set("n", "K", function() vim.lsp.buf.hover(float.opts()) end, { desc = "LSP hover documentation" })

-- execute file
set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "execute the current file" })

-- colorschemes
set("n", "<leader><leader>e", "<cmd>colorscheme everforest<CR>", { desc = "use the everforest colorscheme" })
set("n", "<leader><leader>k", "<cmd>colorscheme kanagawa<CR>", { desc = "use the kanagawa colorscheme" })

-- toggle spellcheck
set("n", "<leader>ss", "<cmd>setlocal spell!<CR>", { desc = "toggle spellcheck" })

-- folding
local foldlevel_ns = vim.api.nvim_create_namespace("foldlevel_display")
local foldlevel_shown = {}
set("n", "<leader>z", function()
  local buf = vim.api.nvim_get_current_buf()

  if foldlevel_shown[buf] then
    vim.api.nvim_buf_clear_namespace(buf, foldlevel_ns, 0, -1)
    foldlevel_shown[buf] = false
    return
  end

  local ok, parser = pcall(vim.treesitter.get_parser, buf)
  if ok and parser then
    parser:parse() -- force a synchronous parse of the base tree and all injections
  end
  vim.cmd("normal! zx") -- force vim to recompute its own fold cache from foldexpr

  for lnum = 1, vim.api.nvim_buf_line_count(buf) do
    local level = vim.fn.foldlevel(lnum)
    vim.api.nvim_buf_set_extmark(buf, foldlevel_ns, lnum - 1, 0, {
      virt_text = { { "L_" .. level, "Comment" } },
      virt_text_pos = "inline",
    })
  end
  foldlevel_shown[buf] = true
end, { desc = "toggle fold level display" })

-- LSP Code Navigation
local builtin = require("telescope.builtin")
set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
set("n", "gr", builtin.lsp_references, { desc = "Show references" })

-- LSP Actions & diagnostics (<leader>l namespace)
local conform = require("conform")
set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code actions" })
set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename symbol" })
set("n", "<leader>lf", function() conform.format({ async = true, lsp_fallback = true }) end, { desc = "Format buffer" })
set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Document symbols" })
set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })
set("n", "<leader>lh", function() vim.lsp.buf.signature_help(float.opts()) end, { desc = "Signature help" })
set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
set("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Show diagnostic" })
set("n", "<leader>ll", vim.diagnostic.setloclist, { desc = "Diagnostic loclist" })
set("n", "<leader>lq", vim.diagnostic.setqflist, { desc = "Diagnostic quickfix" })

-- harpoon
local harpoon = require("harpoon")
-- harpoon:setup()
set("n", "<leader>a", function() harpoon:list():add() end, { desc = "add file to harpoon list" })
set("n", "<leader>\\", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "show harpoon marks" })
set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "nav to harpoon file 1" })
set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "nav to harpoon file 2" })
set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "nav to harpoon file 3" })
set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "nav to harpoon file 4" })
set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "nav to harpoon file 5" })

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

-- UndoTree
local ut = require("undotree")
set("n", "<leader>u", function() ut.toggle() end, { desc = "Toggle undotree" })

-- Treesitter
set("n", "<leader>ti", vim.cmd.InspectTree, { desc = "Inspect tree sitter AST" })

-- LSP utilities
local lsputils = require("lsp")
set("n", "<leader>lR", lsputils.restart_lsp, { desc = "Restart LSP clients" })
set("n", "<leader>lp", lsputils.toggle_pico8, { desc = "Toggle pico8-ls / lua_ls" })

-- Git operations (vim-fugitive)
set("n", "<leader>gs", vim.cmd.Git, { desc = "Git status" })
set("n", "<leader>ga", "<cmd>Git add %<cr>", { desc = "Git add current file" })
set("n", "<leader>gA", "<cmd>Git add .<cr>", { desc = "Git add all" })
set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
set("n", "<leader>gC", "<cmd>Git commit --amend<cr>", { desc = "Git commit amend" })
set("n", "<leader>gp", "<cmd>Git pull<cr>", { desc = "Git pull" })
set("n", "<leader>gP", "<cmd>Git push<cr>", { desc = "Git push" })
set("n", "<leader>gf", "<cmd>Git fetch<cr>", { desc = "Git fetch" })
set("n", "<leader>gM", "<cmd>Git merge master<cr>", { desc = "Git merge master" })

-- Branch operations
set("n", "<leader>gb", function()
  builtin.git_branches({
    attach_mappings = function(_, map)
      local actions = require("telescope.actions")
      local state = require("telescope.actions.state")

      local function switch(bufnr)
        local entry = state.get_selected_entry()
        actions.close(bufnr)
        if not entry then return end

        local is_remote = entry.refname and entry.refname:match("^refs/remotes/")
        local name = is_remote and entry.value:gsub("^[^/]+/", "") or entry.value

        local res = vim.system({ "git", "switch", name }, { text = true }):wait()
        if res.code ~= 0 then
          vim.notify(res.stderr, vim.log.levels.ERROR)
        else
          vim.notify("Switched to " .. name)
        end
      end

      map({ "i", "n" }, "<CR>", switch)
      return true
    end,
  })
end, { desc = "Git branch picker" })
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
local gs = require("gitsigns")

-- Navigation
set("n", "]c", function()
  if vim.wo.diff then return "]c" end
  vim.schedule(function() gs.next_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Next git hunk" })

set("n", "[c", function()
  if vim.wo.diff then return "[c" end
  vim.schedule(function() gs.prev_hunk() end)
  return "<Ignore>"
end, { expr = true, desc = "Previous git hunk" })

-- Hunk operations
set("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
set("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
set("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end,
  { desc = "Stage hunk selection" })
set("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end,
  { desc = "Reset hunk selection" })
set("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
set("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
set("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
set("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
set("n", "<leader>hb", function() gs.blame_line { full = true } end, { desc = "Blame line" })
set("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
set("n", "<leader>hD", function() gs.diffthis("~") end, { desc = "Diff this ~" })
-- set("n", "<leader>hd", gs.toggle_deleted, { desc = "Toggle deleted" })

-- Text object
set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })

-- GitHub PRs (octo.nvim, <leader>o namespace)
-- Nothing binds bare <leader>o, so none of these stall on `timeoutlen`.
local function octo(lhs, cmd, desc)
  set("n", "<leader>o" .. lhs, "<cmd>Octo " .. cmd .. "<cr>", { desc = "Octo: " .. desc })
end

octo("o", "", "Actions menu")
octo("l", "pr list", "List PRs")
octo("k", "pr checkout", "Checkout PR branch")
octo("d", "pr diff", "PR diff")
octo("b", "pr browser", "Open PR in browser")

-- Review flow. Two ways in, and the difference matters:
--
--   <leader>ov  `review browse` runs a read-only GraphQL *query*. Same split
--               layout, existing comment threads visible, nothing written to
--               GitHub. This is the one for just reading a PR.
--   <leader>or  `review start` runs the addPullRequestReview *mutation*, which
--               creates a pending review on GitHub the moment you press it.
--               Pending is visible only to you and lasts until you submit or
--               discard, and there is one per user per PR -- which is why
--               `resume` exists. Use this when you actually mean to comment.
--
-- Browse refuses to run while a review is pending; resume it instead.
-- `Octo review discard` throws a pending review away.
--
-- Inside either, octo's own buffer-local maps do the work, all on
-- <localleader> (unset here, so `\`). Those live in octo's config, not here:
--   \ca  comment on the line, or on a visual selection for a range
--   \sa  suggest a change
--   ]q / [q  next / previous file in the panel
-- Comments queue as a pending review and go up together on submit.
octo("v", "review browse", "Browse review (read-only)")
octo("r", "review start", "Start review (creates a pending review)")
octo("R", "review resume", "Resume pending review")
octo("p", "review comments", "Pending review comments")
octo("s", "review submit", "Submit review (approve / request changes)")
octo("x", "review discard", "Discard pending review")

-- LÖVE (love2d.nvim, <leader>v namespace)
-- <leader>v is only named, not mapped. A real no-op map on the bare prefix made
-- every <leader>v press wait out `timeoutlen` to see if vv or vs was coming.
-- A which-key group gives the popup its label without binding anything.
require("which-key").add({ { "<leader>v", group = "LÖVE" } })
set("n", "<leader>vv", "<cmd>LoveRun<cr>", { desc = "Run LÖVE" })
set("n", "<leader>vs", "<cmd>LoveStop<cr>", { desc = "Stop LÖVE" })

-- which-key
set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

-- Debugging (nvim-dap, <leader>D namespace)
--
-- Everything debug lives under <leader>D. It moved here from <leader>b,
-- <leader>B, <leader>lp, <leader>dr and <leader>dl, all of which collided:
-- <leader>lp lost to the pico8-ls toggle and <leader>dl lost to the
-- diagnostic loclist, so log-point and run-last were silently dead, and
-- <leader>dr sat behind the bare <leader>d blackhole-delete operator, which
-- stalls every <leader>d press for `timeoutlen`.
--
-- <leader>D was unmapped and reads as Debug. Nothing else in the config
-- uses it, and there is no bare <leader>D mapping, so no press stalls.
local dap = require("dap")
local dapui = require("dapui")

local function dbg(lhs, fn, desc, mode)
  set(mode or "n", "<leader>D" .. lhs, fn, { desc = "Debug: " .. desc })
end

dbg("c", function() dap.continue() end, "Start / continue")
dbg("i", function() dap.step_into() end, "Step into")
dbg("o", function() dap.step_over() end, "Step over")
dbg("O", function() dap.step_out() end, "Step out")
dbg("t", function() dap.terminate() end, "Terminate session")
dbg("R", function() dap.restart() end, "Restart session")

dbg("b", function() dap.toggle_breakpoint() end, "Toggle breakpoint")
dbg("B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Conditional breakpoint")
dbg("p", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Log point")

dbg("r", function() dap.repl.open() end, "Open REPL")
dbg("l", function() dap.run_last() end, "Run last")
dbg("u", function() dapui.toggle() end, "Toggle UI")
-- Inspect the value under the cursor, or the visual selection.
dbg("e", function() dapui.eval() end, "Eval", { "n", "v" })

-- The F-keys stay as the fast path for repeated stepping mid-session; typing
-- <leader>Do over and over is no way to walk a loop. Note <F1> shadows :help.
set("n", "<F12>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
set("n", "<F1>", function() dap.step_into() end, { desc = "Debug: Step Into" })
set("n", "<F2>", function() dap.step_over() end, { desc = "Debug: Step Over" })
set("n", "<F3>", function() dap.step_out() end, { desc = "Debug: Step Out" })
