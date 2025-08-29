-- Highlight yanked text on e.g. yy,yap etc.
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("weeheavy-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 100,
    })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    local shada_path = vim.fn.stdpath("data") .. "/shada/" .. dir_name .. ".shada"
    vim.opt.shadafile = shada_path
  end,
})

vim.fn.mkdir(vim.fn.stdpath("data") .. "/shada", "p")
