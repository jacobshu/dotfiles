require("codecompanion").setup({
	adapters = {
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				env = {
					api_key = 'cmd:op read "op://Employee/Anthropic API/credential" --no-newline',
				},
			})
		end,
	},
})
