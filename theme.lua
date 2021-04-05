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
    -- "wallpaper" should be a symlink (see script/set_wallpaper.sh)
    wallpaper                               = asset "wallpaper",

    font                                    = "lemon 12",
    icon_theme                              = "candy-icons",

    separator_thinkness                     = 4,
    separator_span_ratio                    = 0.25,

    notification_border_width               = dpi(4),
    notification_border_color               = colordb.color7,
    notification_spacing                    = dpi(4),
    notification_width                      = dpi(600),
    notification_icon_size                  = dpi(70),
    notification_shape                      = gears.shape.rounded_rect,

    titlebar_fg                             = colordb.foreground,
    titlebar_bg                             = colordb.color0,
    titlebar_bg_normal                      = colordb.foreground,
    titlebar_fg_normal                      = colordb.color0,
    titlebar_close_button_focus             = asset "window_close.png",
    titlebar_close_button_normal            = asset "window_close.png",
 	titlebar_minimize_button_focus          = asset "window_minimize.png",
	titlebar_minimize_button_normal         = asset "window_minimize.png",
	titlebar_sticky_button_focus_active     = asset "window_sticky_active.png",
	titlebar_sticky_button_normal_active    = asset "window_sticky_active.png",
	titlebar_sticky_button_focus_inactive   = asset "window_sticky_inactive.png",
	titlebar_sticky_button_normal_inactive  = asset "window_sticky_inactive.png",

    bg_systray                              = colordb.foreground,
    systray_icon_spacing                    = dpi(1),

    useless_gap                             = dpi(4),
    border_width                            = dpi(2),
    border_normal                           = colordb.color8,
    border_focus                            = colordb.color13,
    border_marked                           = colordb.color7,

    bg                                      = colordb.background,
    fg                                      = colordb.color7,

    -- Custom theme variables
    widget_stat_height                      = dpi(70),
    widget_stat_width                       = dpi(500),
    widget_systray_height                   = dpi(70),
    widget_systray_width                    = dpi(500),

    widget_bat_normal                       = colordb.foreground,
    widget_bat_charging                     = colordb.color4,
    widget_bat_margin                       = dpi(13),
    widget_bat_padding_charge               = dpi(5),
    -- Used to offset widgets behind clients.
    useless_gap_offset                      = dpi(5),
}

-- Merge the default theme with the custom one.
do
    local theme_path = gears.filesystem.get_themes_dir()
    local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

    gears.table.crush(default, theme)
    theme = default
end

return theme
