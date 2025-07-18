return {
	{
		"nvim-treesitter/nvim-treesitter",
    version = false,
		build = ":TSUpdate",
		branch = "master",
		lazy = false,
		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				ensure_installed = {
					"astro",
					"c_sharp",
					"c",
					"css",
					"csv",
					"dart",
					"go",
					"html",
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
				ignore_install = {},
				sync_install = true,
				auto_install = true,
--- 1020  x 287   292740
---  222  x  89    19758
---  214  x 138    29532
---  848  x 184   113632
---  312  x 114    35568
---               491230
---                 3411
---  (593 garage)   2818
				highlight = {
					enable = true,
					disable = {},
					-- disable = function(_, buf)
					-- 	local max_filesize = 512 * 1024 -- 512 KB
					-- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					-- 	if ok and stats and stats.size > max_filesize then
					-- 		return true
					-- 	end
					-- end,

					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
			})
		end,
	},
}
