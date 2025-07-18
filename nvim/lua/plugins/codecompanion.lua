return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
    adapters = {
      anthropic = function()
        return require("codecompanion.adapters").extend("anthropic", {
          env = {
            api_key = 'cmd:op read "op://Private/Anthropic API/credential" --no-newline --account WR3MMMCNNZCNNDQKQ4YRVN6HWA',
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
            modes = { n = "<leader>ca" },
            description = "Accept the suggested change",
          },
          reject_change = {
            modes = { n = "<leader>cr" },
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
}
