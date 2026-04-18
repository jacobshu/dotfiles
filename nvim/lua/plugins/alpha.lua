local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'

    _Gopts = {
      position = 'center',
      hl = 'Type',
      wrap = 'overflow',
    }

    -- DASHBOARD HEADER

    local function getGreeting(name)
      local tableTime = os.date '*t'
      local datetime = os.date ' %Y-%m-%d-%A   %H:%M:%S '
      local hour = tableTime.hour
      local greetingsTable = {
        [1] = '  Sleep well',
        [2] = '  Good morning',
        [3] = '  Good afternoon',
        [4] = '  Good evening',
        [5] = '󰖔  Good night',
      }
      local greetingIndex = 0
      if hour == 23 or hour < 7 then
        greetingIndex = 1
      elseif hour < 12 then
        greetingIndex = 2
      elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
      elseif hour >= 18 and hour < 21 then
        greetingIndex = 4
      elseif hour >= 21 then
        greetingIndex = 5
      end
      return datetime .. '  ' .. greetingsTable[greetingIndex] .. ', ' .. name
    end

    local fill = vim.fn.winheight(0) - 43
    local logo = (fill >= 0 and [[










    ]] or '') ..
        [[
                                          
       ███████████           █████      ██
      ███████████             █████ 
      ████████████████ ███████████ ███   ███████
     ████████████████ ████████████ █████ ██████████████
    █████████████████████████████ █████ █████ ████ █████
  ██████████████████████████████████ █████ █████ ████ █████
 ██████  ███ █████████████████ ████ █████ █████ ████ ██████
 ██████   ██  ███████████████   ██ █████████████████

      ]]

    local userName = 'Lazy'
    local greeting = getGreeting(userName)
    local marginBottom = 0


    -- Highlight groups configuration for each segment
    local header_hl = {}

    if fill >= 0 then
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
      table.insert(header_hl, { { "Red", 1, 1 } })
    end
    table.insert(header_hl, { { "AlphaHeader0_0", 46, 48 } }) -- Line 10
    table.insert(header_hl, {                                 -- Line 11
      { "AlphaHeader1_0", 7,  22 },
      { "AlphaHeader1_1", 33, 40 },
      { "AlphaHeader1_2", 40, 48 },
      { "AlphaHeader1_3", 48, 50 },
    })
    table.insert(header_hl, { -- Line 12
      { "AlphaHeader2_0", 6,  21 },
      { "AlphaHeader2_1", 33, 45 },
    })
    table.insert(header_hl, { -- Line 13
      { "AlphaHeader3_0", 6,  19 },
      { "AlphaHeader3_1", 19, 20 },
      { "AlphaHeader3_2", 20, 35 },
      { "AlphaHeader3_3", 35, 45 },
      { "AlphaHeader3_4", 45, 90 },
    })
    table.insert(header_hl, { -- Line 14
      { "AlphaHeader4_0", 5,  18 },
      { "AlphaHeader4_1", 18, 36 },
      { "AlphaHeader4_2", 36, 45 },
      { "AlphaHeader4_3", 45, 90 }
    })
    table.insert(header_hl, { -- Line 15
      { "AlphaHeader5_0", 4,  17 },
      { "AlphaHeader5_1", 17, 24 },
      { "AlphaHeader5_2", 24, 28 },
      { "AlphaHeader5_3", 28, 37 },
      { "AlphaHeader5_4", 37, 46 },
      { "AlphaHeader5_5", 46, 90 },
    })
    table.insert(header_hl, { -- Line 16
      { "AlphaHeader6_0", 2,  17 },
      { "AlphaHeader6_1", 17, 38 },
      { "AlphaHeader6_2", 38, 45 },
      { "AlphaHeader6_3", 46, 90 },
    })
    table.insert(header_hl, { -- Line 17
      { "AlphaHeader7_0", 1,  17 },
      { "AlphaHeader7_1", 17, 38 },
      { "AlphaHeader7_2", 38, 45 },
      { "AlphaHeader7_3", 46, 90 },
    })
    table.insert(header_hl, { -- Line 18
      { "AlphaHeader8_0", 1,  18 },
      { "AlphaHeader8_1", 18, 37 },
      { "AlphaHeader8_2", 37, 91 },
    })

    local ff = require("config.forestfox")

    vim.api.nvim_set_hl(0, "AlphaHeader0_0", { fg = ff.bright_magenta })
    vim.api.nvim_set_hl(0, "AlphaHeader1_0", { fg = ff.bg2 })
    vim.api.nvim_set_hl(0, "AlphaHeader1_1", { fg = ff.bg2 })
    vim.api.nvim_set_hl(0, "AlphaHeader1_2", { fg = ff.magenta })
    vim.api.nvim_set_hl(0, "AlphaHeader1_3", { fg = ff.dim_magenta })
    vim.api.nvim_set_hl(0, "AlphaHeader2_0", { fg = ff.bg3 })
    vim.api.nvim_set_hl(0, "AlphaHeader2_1", { fg = ff.bg3 })
    vim.api.nvim_set_hl(0, "AlphaHeader3_0", { fg = ff.bg4 })
    vim.api.nvim_set_hl(0, "AlphaHeader3_1", { fg = ff.bg4 })
    vim.api.nvim_set_hl(0, "AlphaHeader3_2", { fg = ff.bg4 })
    vim.api.nvim_set_hl(0, "AlphaHeader3_3", { fg = ff.bg4 })
    vim.api.nvim_set_hl(0, "AlphaHeader3_4", { fg = ff.bg4 })
    vim.api.nvim_set_hl(0, "AlphaHeader4_0", { fg = ff.bg5 })
    vim.api.nvim_set_hl(0, "AlphaHeader4_1", { fg = ff.bg5 })
    vim.api.nvim_set_hl(0, "AlphaHeader4_2", { fg = ff.bg5 })
    vim.api.nvim_set_hl(0, "AlphaHeader4_3", { fg = ff.bg5 })
    vim.api.nvim_set_hl(0, "AlphaHeader5_0", { fg = ff.dim_blue })
    vim.api.nvim_set_hl(0, "AlphaHeader5_1", { fg = ff.dim_yellow })
    vim.api.nvim_set_hl(0, "AlphaHeader5_2", { fg = ff.bg_orange })
    vim.api.nvim_set_hl(0, "AlphaHeader5_3", { fg = ff.dim_yellow })
    vim.api.nvim_set_hl(0, "AlphaHeader5_4", { fg = ff.dim_aqua })
    vim.api.nvim_set_hl(0, "AlphaHeader5_5", { fg = ff.dim_green })
    vim.api.nvim_set_hl(0, "AlphaHeader6_0", { fg = ff.blue })
    vim.api.nvim_set_hl(0, "AlphaHeader6_1", { fg = ff.yellow })
    vim.api.nvim_set_hl(0, "AlphaHeader6_2", { fg = ff.aqua })
    vim.api.nvim_set_hl(0, "AlphaHeader6_3", { fg = ff.green })
    vim.api.nvim_set_hl(0, "AlphaHeader7_0", { fg = ff.bright_blue })
    vim.api.nvim_set_hl(0, "AlphaHeader7_1", { fg = ff.bright_yellow })
    vim.api.nvim_set_hl(0, "AlphaHeader7_2", { fg = ff.bright_aqua })
    vim.api.nvim_set_hl(0, "AlphaHeader7_3", { fg = ff.bright_green })
    vim.api.nvim_set_hl(0, "AlphaHeader8_0", { fg = ff.bg_blue })
    vim.api.nvim_set_hl(0, "AlphaHeader8_1", { fg = ff.bg_orange })
    vim.api.nvim_set_hl(0, "AlphaHeader8_2", { fg = ff.bg_green })

    local utils = require('alpha.utils')

    local header_val = vim.split(logo, '\n')
    header_hl = utils.charhl_to_bytehl(header_hl, header_val, false)

    dashboard.section.header.opts.hl = header_hl
    dashboard.section.header.val = header_val
    -- Split logo into lines
    local logoLines = {}
    for line in logo:gmatch '[^\r\n]+' do
      table.insert(logoLines, line)
    end

    -- Calculate padding for centering the greeting
    local logoWidth                   = logo:find '\n' - 1 -- Assuming the logo width is the width of the first line
    local greetingWidth               = #greeting
    local padding                     = math.floor((logoWidth - greetingWidth) / 2)

    -- Generate spaces for padding
    local paddedGreeting              = string.rep(' ', padding) .. greeting

    -- Add margin lines below the padded greeting
    local margin                      = string.rep('\n', marginBottom)

    -- Concatenate logo, padded greeting, and margin
    local adjustedLogo                = logo .. '\n' .. paddedGreeting .. margin

    dashboard.section.buttons.val     = {
      dashboard.button('n', '  New file', ':ene <BAR> startinsert<CR>'),
      dashboard.button('r', '󰄉  Recent files', ':Telescope fd<CR>'),
      dashboard.button('u', '󱐥  Update plugins', '<cmd>lua vim.pack.update()<CR>'),
      dashboard.button('q', '󰿅  Quit', '<cmd>q<CR>'),
      -- dashboard.button('', ''),
    }

    dashboard.section.buttons.opts.hl = 'AlphaHeader1_0'
    -- local function footer()
    -- 	return "Footer Text"
    -- end

    -- dashboard.section.footer.val = vim.split('\n\n' .. getGreeting 'Lazy', '\n')

    -- Set a placeholder footer; update it with startup time after VimEnter
    dashboard.section.footer.val = {}

    vim.api.nvim_create_autocmd('VimEnter', {
      once = true,
      callback = function()
        local ms = (vim.uv.hrtime() - vim.g._start_hrtime) / 1e6 + 0.5
        local footer = {}
        if fill >= 0 then
          table.insert(footer, '')
          table.insert(footer, '')
          table.insert(footer, '')
        end
        table.insert(footer, ' Loaded in ' .. string.format("%.2f", ms) .. ' ms ')
        for _ = 1, fill do
          table.insert(footer, '')
        end
        dashboard.section.footer.val = footer
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
    -- Hide all the unnecessary visual elements while on the dashboard, and add
    -- them back when leaving the dashboard.
    local group = vim.api.nvim_create_augroup('CleanDashboard', {})

    vim.api.nvim_create_autocmd('User', {
      group = group,
      pattern = 'AlphaReady',
      callback = function()
        -- vim.opt.showtabline = 0
        -- vim.opt.showmode = true
        -- vim.opt.laststatus = 3
        vim.opt.showcmd = false
        vim.opt.ruler = false
      end,
    })

    vim.api.nvim_create_autocmd('BufUnload', {
      group = group,
      pattern = '<buffer>',
      callback = function()
        -- vim.opt.showtabline = 0
        -- vim.opt.showmode = true
        -- vim.opt.laststatus = 3
        vim.opt.showcmd = true
        vim.opt.ruler = true
      end,
    })
    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
