return {
  {
    "S1M0N38/love2d.nvim",
    event = "VeryLazy",
    opts = {
      path_to_love_bin = "C:/Program Files/LOVE/love.exe",
      restart_on_save = true,
      debug_window_opts = { split = "below" },
    },
    keys = {
      { "<leader>v",  desc = "LÖVE" },
      { "<leader>vv", "<cmd>LoveRun<cr>",  desc = "Run LÖVE" },
      { "<leader>vs", "<cmd>LoveStop<cr>", desc = "Stop LÖVE" },
    },
  },
}
