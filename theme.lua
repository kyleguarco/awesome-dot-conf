-- theme.lua
--
-- Anything else should go into the Xresources file (colors, window icon themes, fonts...)

local gears = require('gears')
local xresources = require('beautiful.xresources')

local colordb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local theme = {
	-- "wallpaper" should be a symlink (see script/set_wallpaper.sh)
	wallpaper					= os.getenv("HOME") .. "/.wallpaper",

	font						= "Fira Code Bold 10",
	icon_theme					= "Arc",

	hotkeys_border_width		= dpi(1),
	hotkeys_group_margin		= dpi(4),
	hotkeys_modifiers_fg		= colordb.color12,

	separator_thinkness			= 4,
	separator_span_ratio		= 0.25,

	notification_border_width	= dpi(3),
	notification_border_color	= colordb.color6,
	notification_spacing		= dpi(5),
	notification_width			= dpi(550),
	notification_icon_size		= dpi(60),
	notification_shape			= gears.shape.octogon,

	wibar_height				= dpi(24),
	wibar_bg					= colordb.background,
	wibar_fg					= colordb.foreground,
	wibar_type					= "desktop",

	tasklist_align				= "center",
	tasklist_bg_minimize		= colordb.color7,

	bg_systray					= colordb.background,
	systray_icon_spacing		= dpi(4),

	bg							= colordb.background,
	fg							= colordb.foreground,

	-- Custom theme variables
	transparent					= colordb.background .. "25",
}

-- Copy 'colordb' into 'theme'
theme = gears.table.join(theme, colordb)

-- Merge the default theme with the custom one.
do
	local theme_path = gears.filesystem.get_themes_dir()
	local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

	gears.table.crush(default, theme)
	theme = default
end

return theme
