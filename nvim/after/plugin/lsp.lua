local lsp = require("lsp-zero")

lsp.preset("recommended")

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  })
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»',
    }
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

local lua_opts = lsp.nvim_lua_ls()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'cssls',
    'gopls',
    'html',
    'intelephense',
    'lua_ls',
    'tsserver',
    'rust_analyzer',
  },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
    intelephense = function()
      require('lspconfig').intelephense.setup({
        -- Add wordpress to the list of stubs
        stubs = {
            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype", "curl", "date",
            "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
            "gmp", "hash", "iconv", "imap", "intl", "json", "ldap", "libxml", "mbstring", "meta", "mysqli",
            "oci8", "odbc", "openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
            "Phar", "posix", "pspell", "readline", "Reflection", "session", "shmop", "SimpleXML", "snmp", "soap",
            "sockets", "sodium", "SPL", "sqlite3", "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy",
            "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip", "zlib",
            "wordpress", "phpunit",
        },
      }) 
    end,
  }
})


lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['tsserver'] = {'javascript', 'typescript'},
    ['rust_analyzer'] = {'rust'},
  }
})

require('flutter-tools').setup({
  lsp = {
    capabilities = lsp.get_capabilities()
  }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
