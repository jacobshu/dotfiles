local dap = require("dap")

---match the artifact named after the project first, and only guess after.
---@param patterns string[] glob patterns to search, in priority order
---@param names string[] extra artifact basenames to prefer, highest first
---@return string
local function pick_artifact(patterns, names)
  local cwd = vim.fn.getcwd()

  -- prefer whatever was passed in, then the directory name,
  -- then any .sln or project file sitting at the root.
  local wanted = vim.list_extend({}, names or {})
  table.insert(wanted, vim.fs.basename(cwd))
  for _, glob in ipairs({ "/*.sln", "/*.csproj", "/*.vcxproj" }) do
    for _, f in ipairs(vim.fn.glob(cwd .. glob, false, true)) do
      table.insert(wanted, vim.fn.fnamemodify(f, ":t:r"))
    end
  end

  local found = {}
  for _, pattern in ipairs(patterns) do
    vim.list_extend(found, vim.fn.glob(cwd .. pattern, false, true))
  end

  for _, name in ipairs(wanted) do
    for _, artifact in ipairs(found) do
      if vim.fn.fnamemodify(artifact, ":t:r"):lower() == name:lower() then
        return artifact
      end
    end
  end

  for _, artifact in ipairs(found) do
    if not artifact:match("[Tt]ests?%.%a+$") then
      return artifact
    end
  end

  return vim.fn.input("Path to artifact: ", cwd, "file")
end

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
    -- Glob any target framework rather than a hardcoded list. The old list
    -- stopped at net8.0, so net10.0 projects (zdApi, zdAuth) never matched.
    program = function()
      return pick_artifact({ "/bin/Debug/*/*.dll", "/*/bin/Debug/*/*.dll" }, {})
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


-- C++ (MSVC) debugging via codelldb.
local codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe"

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb,
    args = { "--port", "${port}" },
  },
}

dap.configurations.cpp = {
  {
    name = "launch - codelldb",
    type = "codelldb",
    request = "launch",
    -- Echo.vcxproj puts its output at $(SolutionDir)$(Configuration)\, so
    -- from the Echo repo root that is Debug/Echo.exe.
    program = function()
      return pick_artifact({ "/Debug/*.exe", "/x64/Debug/*.exe" }, {})
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    console = "integratedTerminal",
  },
  {
    -- The NX_* drivers build as DLLs, so they cannot be launched at all --
    -- Echo loads them. Attaching to a running Echo.exe is the only way to
    -- put a breakpoint in driver code.
    name = "attach to process - codelldb",
    type = "codelldb",
    request = "attach",
    pid = function()
      return require("dap.utils").pick_process()
    end,
    cwd = "${workspaceFolder}",
  },
}

-- Drivers and Echo share the same toolchain and layout.
dap.configurations.c = dap.configurations.cpp

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

-- Keymaps. Defined last so `dapui` is already in scope.
--
-- Everything debug lives under <leader>D. It moved here from <leader>b,
-- <leader>B, <leader>lp, <leader>dr and <leader>dl, all of which collided:
-- <leader>lp lost to the pico8-ls toggle and <leader>dl lost to the
-- diagnostic loclist, so log-point and run-last were silently dead, and
-- <leader>dr sat behind the bare <leader>d blackhole-delete operator, which
-- stalls every <leader>d press for `timeoutlen`.
--
-- <leader>D was unmapped and reads as Debug. Nothing else in the config
-- uses it, and there is no bare <leader>D mapping, so no press stalls.
local function dbg(lhs, fn, desc, mode)
  vim.keymap.set(mode or "n", "<leader>D" .. lhs, fn, { desc = "Debug: " .. desc })
end

dbg("c", function() dap.continue() end, "Start / continue")
dbg("i", function() dap.step_into() end, "Step into")
dbg("o", function() dap.step_over() end, "Step over")
dbg("O", function() dap.step_out() end, "Step out")
dbg("t", function() dap.terminate() end, "Terminate session")
dbg("R", function() dap.restart() end, "Restart session")

dbg("b", function() dap.toggle_breakpoint() end, "Toggle breakpoint")
dbg("B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, "Conditional breakpoint")
dbg("p", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, "Log point")

dbg("r", function() dap.repl.open() end, "Open REPL")
dbg("l", function() dap.run_last() end, "Run last")
dbg("u", function() dapui.toggle() end, "Toggle UI")
-- Inspect the value under the cursor, or the visual selection.
dbg("e", function() dapui.eval() end, "Eval", { "n", "v" })

-- The F-keys stay as the fast path for repeated stepping mid-session; typing
-- <leader>Do over and over is no way to walk a loop. Note <F1> shadows :help.
vim.keymap.set("n", "<F12>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F1>", function() dap.step_into() end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F2>", function() dap.step_over() end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F3>", function() dap.step_out() end, { desc = "Debug: Step Out" })
