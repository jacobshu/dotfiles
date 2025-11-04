return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    pickers = {
      live_grep = {
        -- theme = "dropdown",
        results_title = false,
        layout_strategy = "vertical",
        sorting_strategy = "ascending",
        layout_config = {
          width = 100,
          preview_cutoff = 1,
          preview_height = 20,
        }
      }
    }
  }
}
