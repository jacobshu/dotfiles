local fb_actions = require "telescope._extensions.file_browser.actions"

require("telescope").setup {
  extensions = {
    file_browser = {
      -- path = vim.loop.cwd(),
      -- cwd = vim.loop.cwd(),
      -- cwd_to_path = false,
      -- grouped = false,
      -- files = true,
      -- add_dirs = true,
      -- depth = 1,
      -- auto_depth = false,
      -- select_buffer = false,
      -- hidden = { file_browser = false, folder_browser = false },
      -- respect_gitignore = vim.fn.executable "fd" == 1,
      -- follow_symlinks = false,
      -- browse_files = require("telescope._extensions.file_browser.finders").browse_files,
      -- browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
      hide_parent_dir = true,
      -- collapse_dirs = false,
      -- prompt_path = false,
      -- quiet = false,
      -- dir_icon = "",
      -- dir_icon_hl = "Default",
      -- display_stat = { date = true, size = true, mode = true },
      -- hijack_netrw = true,
      -- use_fd = true,
      -- git_status = true,
      -- mappings: {}
    },
  },
}

vim.api.nvim_set_keymap(
  "n",
  "<space>pb",
  ":Telescope file_browser<CR>",
  { noremap = true }
)
