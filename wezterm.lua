-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
-- Will provide clearer error messages.
local config = wezterm.config_builder()

-- Colors
config.color_scheme = "github_dark_high_contrast"

-- Fonts
config.font = wezterm.font("Hack Nerd Font Mono", { weight = "Bold", italic = false })
config.font_size = 14.0

-- Tabs
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

-- Window
config.window_frame = {
	-- Fancy tab bar
	active_titlebar_bg = "#000000",
	inactive_titlebar_bg = "#000000",
}

config.window_padding = {
	left = 15,
}

-- and finally, return the configuration to wezterm
return config
