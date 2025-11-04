return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  -- Optional: Lazy load nvim-dap based on an event or command
  event = "VeryLazy", -- Loads when Neovim is mostly idle
  -- or
  -- cmd = "DapSetLogLevel", -- Loads when a DAP command is executed
  config = function()
    -- DAP configurations go here
    local dap = require("dap")
    
    -- .NET Core debugger adapter configuration
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'C:/Program Files/netcoredbg/netcoredbg.exe',
      args = { '--interpreter=vscode' }
    }

    -- .NET debugging configurations
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          -- Try to find the main assembly in common build paths
          local cwd = vim.fn.getcwd()
          local possible_paths = {
            cwd .. "/bin/Debug/net8.0/*.dll",
            cwd .. "/bin/Debug/net7.0/*.dll",
            cwd .. "/bin/Debug/net6.0/*.dll",
            cwd .. "/bin/Debug/netcoreapp3.1/*.dll",
            cwd .. "/*/bin/Debug/net8.0/*.dll",
            cwd .. "/*/bin/Debug/net7.0/*.dll",
            cwd .. "/*/bin/Debug/net6.0/*.dll",
          }
          
          for _, pattern in ipairs(possible_paths) do
            local matches = vim.fn.glob(pattern, false, true)
            if #matches > 0 then
              -- Filter out test assemblies and prefer the main assembly
              for _, match in ipairs(matches) do
                if not string.match(match, "%.Test%.") and not string.match(match, "%.Tests%.") then
                  return match
                end
              end
              -- If no non-test assembly found, return the first one
              return matches[1]
            end
          end
          
          -- Fallback: ask user to input the path
          return vim.fn.input('Path to dll: ', cwd .. '/bin/Debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
        console = "internalConsole",
      },
      {
        type = "coreclr",
        name = "launch with arguments - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
        args = function()
          local args_input = vim.fn.input('Arguments: ')
          return vim.split(args_input, ' ')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
        console = "internalConsole",
      },
      {
        type = "coreclr",
        name = "attach - netcoredbg",
        request = "attach",
        processId = function()
          return require('dap.utils').pick_process()
        end,
        cwd = '${workspaceFolder}',
      }
    }

    -- Key mappings for debugging
    vim.keymap.set('n', '<F12>', function() dap.continue() end, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Set Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { desc = 'Debug: Set Log Point' })
    vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Debug: Open REPL' })
    vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { desc = 'Debug: Run Last' })
    
    -- DAP UI integration
    local dapui = require("dapui")
    
    -- Automatically open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    require("dapui").setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Use this to override mappings for specific elements
      element_mappings = {
        -- Example:
        -- stacks = {
        --   open = "<CR>",
        --   expand = "o",
        -- }
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has("nvim-0.7") == 1,
      -- Layouts define sections of the screen to place windows.
      -- The position can be "left", "right", "top" or "bottom".
      -- The size specifies the height/width depending on position. It can be an Int
      -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
      -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
      -- Elements are the elements shown in the layout (in order).
      -- Layouts are opened in order so that earlier layouts take priority in window sizing.
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches",
          },
          size = 40, -- 40 columns
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom",
        },
      },
      controls = {
        -- Requires Neovim nightly (or 0.8 when released)
        enabled = true,
        -- Display controls in this element
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "↻",
          terminate = "□",
        },
      },
      floating = {
        max_height = nil,  -- These can be integers or a float between 0 and 1.
        max_width = nil,   -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      }
    })                         -- UI setup
  end,
}
