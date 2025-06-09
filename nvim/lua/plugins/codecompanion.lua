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
    config = function()
      vim.keymap.set({ "n", "v" }, "<Leader>ac", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })

      vim.keymap.set(
        { "n", "v" },
        "<Leader>ch",
        "<cmd>CodeCompanionChat Toggle<cr>",
        { noremap = true, silent = true }
      )
      vim.keymap.set("v", "<Leader>ah", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
	end,
}
