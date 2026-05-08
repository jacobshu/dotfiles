-- tree-sitter CLI must be installed system-wide
require("tree-sitter-manager").setup({
  ensure_installed = {
          "astro",
          "c_sharp",
          "c",
          "cpp",
          "css",
          "csv",
          "dart",
          "gitcommit",
          "gitignore",
          "go",
          "html",
          "hurl",
          "javascript",
          "jinja",
          "json",
          "lua",
          "markdown",
          "php",
          "python",
          "rust",
          "sql",
          "svelte",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",

  },
  languages = {
    pico8 = {
      install_info = {
        url = "https://github.com/paradoxskin/tree-sitter-pico8",
        use_repo_queries = true
      }
    }
  },
  -- Optional: custom paths
  -- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
  -- query_dir = vim.fn.stdpath("data") .. "/site/queries",
})
