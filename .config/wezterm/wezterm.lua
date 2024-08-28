local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.term = "wezterm"

config.color_scheme = "Catppuccin Macchiato"
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 14

config.enable_tab_bar = false

config.keys = {
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 2,
}

return config
