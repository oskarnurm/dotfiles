-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
-- Will provide clearer error messages.
local config = wezterm.config_builder()

config.default_prog = { "/opt/homebrew/bin/fish", "-l" }

config.window_background_opacity = 1.0
config.color_scheme = "Gruvbox dark, medium (base16)"

-- config.font = wezterm.font("JetBrains Mono", { weight = "Regular", italic = false })
config.font_size = 11.0
-- Disable font ligatures
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.hide_tab_bar_if_only_one_tab = true

-- Hides the buttons on top
-- config.window_decorations = "RESIZE"

-- and finally, return the configuration to wezterm
return config
