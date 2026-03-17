local wezterm = require "wezterm"

local config = wezterm.config_builder()

config.default_prog = { "pwsh.exe", "-NoLogo" }

config.cursor_blink_rate = 0
config.cursor_blink_ease_in = "EaseInOut"
-- config.cursor_blink_ease_out = "EaseInOut"
config.initial_cols = 100
config.initial_rows = 50

config.font_size = 11.0
config.color_scheme = "forestfox"

config.color_schemes = {
  forestfox = {
    ansi = {
      "#374149",
      "#da7280",
      "#a8c180",
      "#dbba79",
      "#78b1bd",
      "#d694be",
      "#7bc29a",
      "#cfc2a4",
    },
    brights = {
      "#526564",
      "#f1949c",
      "#b6d881",
      "#fae2b2",
      "#95dae8",
      "#fdade4",
      "#89e5be",
      "#e5d9bc",
    },
    background = "#2e373f",
    foreground = "#cfc2a4",
    selection_fg = "#e5d9bc",
    selection_bg = "#965e67",
    cursor_bg = "#ffa06a",
    cursor_border = "#ffa06a",
    cursor_fg = "#283038",
  }
}
config.colors = {
  tab_bar = {
    background = "#ff0000",
    active_tab = {
      bg_color = "#2e373f",
      fg_color = "#cfc2a4",
      intensity = "Bold",
    },
    inactive_tab = {
      bg_color = "#282b2e",
      fg_color = "#778378",
      intensity = "Half",
    }
  }
}

config.window_frame = {
  active_titlebar_bg = "#282b2e",
  inactive_titlebar_bg = "513c40",
}

config.keys = {
  {
    key = "{",
    mods = "SHIFT|CTRL",
    action = wezterm.action.ActivateTabRelative(-1)
  },
  {
    key = "}",
    mods = "SHIFT|CTRL",
    action = wezterm.action.ActivateTabRelative(1)
  }
}

return config
