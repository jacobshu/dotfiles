-- Shared appearance for LSP/diagnostic floating windows.
local M = {}

-- Active border. Alternatives left in place to swap and compare.
M.border = "rounded"
-- M.border = "single"
-- M.border = { " ", " ", " ", " ", " ", " ", " ", " " } -- padding, no drawn line;
--                                                      -- table form can't feed 'winborder'
-- M.border = "shadow"

-- 60% of the window, but never wider than 100 cols / taller than 30 rows.
-- Recomputed per call so it tracks terminal resizes.
function M.opts(extra)
  return vim.tbl_extend("force", {
    border = M.border,
    max_width = math.min(math.floor(vim.o.columns * 0.6), 100),
    max_height = math.min(math.floor(vim.o.lines * 0.4), 30),
    wrap = true,
  }, extra or {})
end

return M
