return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    suggestion = { enabled = false },
    panel = { enabled = true },
    filetypes = {
      -- Configure for specific filetypes
      ["*"] = true,
    },
  },
}
