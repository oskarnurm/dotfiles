-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
-- Will provide clearer error messages.
local config = wezterm.config_builder()

config.window_background_opacity = 1.0
config.color_scheme = "Gruvbox dark, medium (base16)"

-- config.font = wezterm.font("JetBrains Mono", { weight = "Regular", italic = false })
config.font_size = 11.0
-- Disable font ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.hide_tab_bar_if_only_one_tab = true

-- config.window_decorations = "RESIZE"

-- Window
-- config.window_frame = {
-- 	-- Fancy tab bar
-- 	active_titlebar_bg = "#000000",
-- 	inactive_titlebar_bg = "#000000",
-- }

-- Padding
-- config.window_padding = {
-- 	left = 15,
-- }

-- and finally, return the configuration to wezterm
return config
