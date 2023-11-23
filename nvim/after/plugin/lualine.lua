-- Forestfox config for lualine
local ff = require('jacobshu/forestfox')

local ff_theme = {
  normal = {
    a = { fg = ff.bg0, bg = ff.aqua },
    b = { fg = ff.grey2, bg = ff.bg2 },
    c = { fg = ff.bg0, bg = ff.bg0 },
  },

  insert = { a = { fg = ff.bg0, bg = ff.yellow } },
  visual = { a = { fg = ff.grey2, bg = ff.bg_green } },
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
    lualine_x = {},
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
