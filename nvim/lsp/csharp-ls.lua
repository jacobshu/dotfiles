local function escape_wildcards(path)
  return path:gsub('([%[%]%?%*])', '\\%1')
end

local function search_ancestors(startpath, func)
  if vim.fn.has 'nvim-0.11' == 1 then
    vim.validate('func', func, 'function')
  end
  if func(startpath) then
    return startpath
  end
  local guard = 100
  for path in vim.fs.parents(startpath) do
    guard = guard - 1
    if guard == 0 then
      return
    end

    if func(path) then
      return path
    end
  end
end

local function root_pattern(...)
  local patterns = vim.iter(...):flatten(math.huge):totable() or vim.tbl_flatten(...)
  return function(startpath)
    startpath = vim.fn.substitute(startpath, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', '\\1', '')
    startpath = vim.fn.substitute(startpath, 'tarfile:\\(.\\{-}\\)::.*$', '\\1', '')
    for _, pattern in ipairs(patterns) do
      local match = search_ancestors(startpath, function(path)
        for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true)) do
          if vim.uv.fs_stat(p) then
            return path
          end
        end
      end)

      if match ~= nil then
        return match
      end
    end
  end
end

return {
  cmd = { "csharp-ls" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(root_pattern("*.sln", fname) or root_pattern("*.csproj", fname))
  end,
  filetypes = { "cs" },
  init_options = {
    AutomaticWorkspaceInit = true,
  },
}
