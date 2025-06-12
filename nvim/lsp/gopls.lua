local mod_cache = nil

local function get_root(fname)
  if mod_cache and fname:sub(1, #mod_cache) == mod_cache then
    local clients = vim.lsp.get_clients { name = 'gopls' }
    if #clients > 0 then
      return clients[#clients].config.root_dir
    end
  end
  return vim.fs.root(fname, 'go.work') or vim.fs.root(fname, 'go.mod') or vim.fs.root(fname, '.git')
end

return {
  cmd = { "gopls" },                                          -- Command to start the language server
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" }, -- File types that this server will handle
  root_markers = { "go.mod", "go.work", ".git" },             -- Markers to identify the root of the project
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    -- see: https://github.com/neovim/nvim-lspconfig/issues/804
    if mod_cache then
      on_dir(get_root(fname))
      return
    end
    local cmd = { 'go', 'env', 'GOMODCACHE' }
    vim.system(cmd, { text = true }, function(output)
      if output.code == 0 then
        if output.stdout then
          mod_cache = vim.trim(output.stdout)
        end
        on_dir(get_root(fname))
      else
        vim.schedule(function()
          vim.notify(('[gopls] cmd failed with code %d: %s\n%s'):format(output.code, cmd, output.stderr))
        end)
      end
    end)
  end,
  settings = { -- Settings for the language server
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
      hints = {
        assignVariableTypes = false,
        compositeLiteralFields = false,
        compositeLiteralTypes = false,
        constantValues = false,
        functionTypeParameters = false,
        parameterNames = false,
        rangeVariableTypes = false,
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        unreachable = true,
        modernize = true,
        stylecheck = true,
        appends = true,
        asmdecl = true,
        assign = true,
        atomic = true,
        bools = true,
        buildtag = true,
        cgocall = true,
        composite = true,
        contextcheck = true,
        deba = true,
        atomicalign = true,
        composites = true,
        copylocks = true,
        deepequalerrors = true,
        defers = true,
        deprecated = true,
        directive = true,
        embed = true,
        errorsas = true,
        fillreturns = true,
        framepointer = true,
        gofix = true,
        hostport = true,
        infertypeargs = true,
        lostcancel = true,
        httpresponse = true,
        ifaceassert = true,
        loopclosure = true,
        nilfunc = true,
        nonewvars = true,
        noresultvalues = true,
        printf = true,
        shadow = true,
        shift = true,
        sigchanyzer = true,
        simplifycompositelit = true,
        simplifyrange = true,
        simplifyslice = true,
        slog = true,
        sortslice = true,
        stdmethods = true,
        stdversion = true,
        stringintconv = true,
        structtag = true,
        testinggoroutine = true,
        tests = true,
        timeformat = true,
        unmarshal = true,
        unsafeptr = true,
        unusedfunc = true,
        unusedresult = true,
        waitgroup = true,
        yield = true,
        unusedvariable = true,
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true,
    },
  },
}
