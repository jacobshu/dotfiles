require("codecompanion").setup({
	adapters = {
		anthropic = function()
			return require("codecompanion.adapters").extend("anthropic", {
				env = {
					api_key = 'cmd:op read "op://Employee/Anthropic API/credential" --no-newline',
				},
			})
		end,
	},
	strategies = {
		chat = {
			adapter = "anthropic",
		},
		inline = {
			adapter = "anthropic",
		},
		cmd = {
			adapter = "anthropic",
		},
	},
})
