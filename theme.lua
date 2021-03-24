-- theme.lua
--
-- This theme file should only touch widget components of the window manager,
-- not how windows are designed. This theme file should only define what icons
-- are used for different widgets.
--
-- Anything else should go into the Xresources file (colors, window icon themes, fonts...)

local gears = require('gears')
local xresources = require('beautiful.xresources')
local colordb = xresources.get_current_theme()
local dpi = xresources.apply_dpi

local theme = {
    wallpaper = os.getenv("HOME") .. "/Pictures/wallpapers/mechanical_keyboards.png",

    font = "lemon 12",
    icon_theme = "Faba",

    separator_thinkness = 5,
    separator_span_ratio = 0.25,

    notificaion_border_width = dpi(4),
    -- notification_height = dpi(25),
    notification_spacing = dpi(4),

    titlebar_bg = "#001020",
    titlebar_close_button_focus = get_config_dir().."assets/window_close.png",
    titlebar_close_button_normal = get_config_dir().."assets/window_close.png",
 	titlebar_minimize_button_focus = get_config_dir().."assets/window_minimize.png",
	titlebar_minimize_button_normal = get_config_dir().."assets/window_minimize.png",
	titlebar_sticky_button_focus_active = get_config_dir().."assets/window_sticky_active.png",
	titlebar_sticky_button_normal_active = get_config_dir().."assets/window_sticky_active.png",
	titlebar_sticky_button_focus_inactive = get_config_dir().."assets/window_sticky_inactive.png",
	titlebar_sticky_button_normal_inactive = get_config_dir().."assets/window_sticky_inactive.png",

    useless_gap   = dpi(5),
    border_width  = dpi(2),
    border_normal = colordb.color8,
    border_focus  = colordb.color13,
    border_marked = colordb.color7,

    bg = colordb.color8,
    fg = colordb.color7,

    -- Custom theme variables
    widget_bat_normal = colordb.color7,
    widget_bat_charge = colordb.color13,
    widget_bat_critical = colordb.color2,
}

-- Merge the default theme with the custom one.
do
    local theme_path = gears.filesystem.get_themes_dir()
    local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

    gears.table.crush(default, theme)
    theme = default
end

return theme
