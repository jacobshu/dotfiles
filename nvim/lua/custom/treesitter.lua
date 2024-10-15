local M = {}

M.setup = function()
	require("nvim-treesitter").setup({
		ensure_installed = {
			"astro",
			"c",
			"css",
			"dart",
			"go",
			"javascript",
			"json",
			"lua",
			"markdown",
			"php",
			"rust",
			"sql",
			"svelte",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
			"vue",
		},
		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,
		auto_install = true,

		highlight = {
			enable = true,

			-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
			disable = function(_, buf)
				local max_filesize = 512 * 1024 -- 512 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
	})
end

return M
