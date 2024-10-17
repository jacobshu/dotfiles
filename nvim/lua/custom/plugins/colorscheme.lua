return {
	-- { "EdenEast/nightfox.nvim" },
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			-- require("custom/everforest")
			vim.cmd.colorscheme("everforest")
		end,
	},
}
