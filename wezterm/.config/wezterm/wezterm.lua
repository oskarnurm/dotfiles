local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.max_fps = 120
config.font_size = 15.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" } -- disable font ligatures
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.send_composed_key_when_left_alt_is_pressed = false -- disable Option key composition
config.send_composed_key_when_right_alt_is_pressed = false
config.line_height = 1.1
config.color_scheme = "dark"
config.window_padding = {
	top = 30,
	bottom = 30,
	left = 30,
}
config.keys = {
	{ -- send the escape sequence for Ctrl+Tab
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1b[27;5;9~"),
	},
	{ -- send the sequence for Ctrl+Shift+Tab
		key = "Tab",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SendString("\x1b[27;6;9~"),
	},
}

return config
