local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
config.max_fps = 120

-- Disable Option key composition
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

config.window_background_opacity = 1.0

config.window_padding = {
	left = "2cell",
}

config.colors = {
	foreground = "#ffffff",
	background = "#000000",
	cursor_bg = "#efefef",

	ansi = {
		"#000000",
		"#ff7676",
		"#a3d6a3",
		"#ffffff",
		"#b3b3b3",
		"#f4b8e4",
		"#fafafa",
		"#a5adce",
	},
	brights = {
		"#666666",
		"#ff5733",
		"#8ec772",
		"#d9ba73",
		"#ffffff",
		"#f2a4db",
		"#5abfb5",
		"#b5bfe2",
	},
}

-- Disable font ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.font_size = 13.0

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

return config
