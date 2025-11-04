return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local ff = require('config.forestfox')

      local function wordcount()
        return tostring(vim.fn.wordcount().words) .. ' words'
      end

      local function is_markdown()
        return vim.bo.filetype == "markdown" or vim.bo.filetype == "asciidoc"
      end

      local ff_theme = {
        normal = {
          a = { fg = ff.bg0, bg = ff.green },
          b = { fg = ff.green, bg = ff.bg2 },
          c = { fg = ff.green, bg = ff.bg_green },
        },

        insert = {
          a = { fg = ff.bg0, bg = ff.yellow },
          b = { fg = ff.yellow, bg = ff.bg2 },
          c = { fg = ff.yellow, bg = ff.bg_yellow },
        },
        visual = {
          a = { fg = ff.bg0, bg = ff.blue },
          b = { fg = ff.blue, bg = ff.bg2 },
          c = { fg = ff.blue, bg = ff.bg_blue },
        },
        replace = { a = { fg = ff.bg0, bg = ff.bg_red } },

        inactive = {
          a = { fg = ff.grey2, bg = ff.bg0 },
          b = { fg = ff.grey2, bg = ff.bg0 },
          c = { fg = ff.bg0, bg = ff.bg0 },
        },
      }

      require('lualine').setup {
        options = {
          theme = ff_theme,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'fileformat' },
          lualine_x = {
            { wordcount, cond = is_markdown },
          },
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    end
  }
}
