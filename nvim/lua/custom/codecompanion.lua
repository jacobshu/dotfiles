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
			keymaps = {
				accept_change = {
					modes = { n = "<leader>a" },
					description = "Accept the suggested change",
				},
				reject_change = {
					modes = { n = "<leader>r" },
					description = "Reject the suggested change",
				},
			},
		},
		cmd = {
			adapter = "anthropic",
		},
	},
	display = {
		action_palette = {
			provider = "telescope",
		},
	},
})
