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
    -- stopped at net8.0, so net10.0 projects never matched.
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
    -- MSBuild C++ projects put their output at $(SolutionDir)$(Configuration), so
    -- from the solution root that is Debug/<project>.exe.
    program = function()
      return pick_artifact({ "/Debug/*.exe", "/x64/Debug/*.exe" }, {})
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    console = "integratedTerminal",
  },
  {
    -- Projects that build as DLLs cannot be launched at all --
    -- a host process loads them. Attaching to the running host is the only way to
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

-- The C++ projects share the same toolchain and layout.
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
