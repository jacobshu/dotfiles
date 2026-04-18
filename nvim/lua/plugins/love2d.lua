require("love2d").setup({
  path_to_love_bin = "C:/Program Files/LOVE/love.exe",
  restart_on_save = false,
  debug_window_opts = { split = "below" },
})

vim.keymap.set('n', '<leader>v',  function() end,                   { desc = "LÖVE" })
vim.keymap.set('n', '<leader>vv', '<cmd>LoveRun<cr>',               { desc = "Run LÖVE" })
vim.keymap.set('n', '<leader>vs', '<cmd>LoveStop<cr>',              { desc = "Stop LÖVE" })
