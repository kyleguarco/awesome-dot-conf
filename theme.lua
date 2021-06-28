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
local _dpi = xresources.apply_dpi

local theme = {
    -- "wallpaper" should be a symlink (see script/set_wallpaper.sh)
    wallpaper                               = asset "wallpaper",

    font                                    = "lemon 12",
    icon_theme                              = "candy-icons",

    separator_thinkness                     = 4,
    separator_span_ratio                    = 0.25,

    notification_border_width               = _dpi(4),
    notification_border_color               = colordb.color7,
    notification_spacing                    = _dpi(4),
    notification_width                      = _dpi(600),
    notification_icon_size                  = _dpi(70),
    notification_shape                      = gears.shape.rounded_rect,

    wibar_height                            = _dpi(20),
    wibar_bg                                = colordb.background,
    wibar_fg                                = colordb.foreground,
    wibar_type                              = "desktop",

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

    bg_systray                              = colordb.background,
    systray_icon_spacing                    = _dpi(1),

    useless_gap                             = 0, --_dpi(4),
    border_width                            = _dpi(2),
    border_normal                           = colordb.color8,
    border_focus                            = colordb.color13,
    border_marked                           = colordb.color7,

    bg                                      = colordb.background,
    fg                                      = colordb.color7,

    -- Custom theme variables
    transparent                             = colordb.background .. "00",
    hotkey_popup_width                      = _dpi(1024),
    hotkey_popup_height                     = _dpi(820),
    hotkey_popup_margin                     = _dpi(40),

    titlebar_position                       = "bottom",

    widget_stat_height                      = _dpi(55),
    widget_stat_width                       = _dpi(500),
    widget_taglist_height                   = _dpi(55),
    widget_taglist_width                    = _dpi(525),
    widget_taglist_margin                   = _dpi(3),
    widget_systray_height                   = _dpi(55),
    widget_systray_width                    = _dpi(500),
    widget_volume_height                    = _dpi(60),
    widget_volume_width                     = _dpi(525),

    widget_bat_margin                       = _dpi(5),
    widget_bat_border_width                 = _dpi(2),

    widget_vol_margin                       = _dpi(20),

    widget_bar_spacing                      = _dpi(15),
    -- Used to offset widgets behind clients.
    useless_gap_offset                      = _dpi(10),
}

-- Merge the default theme with the custom one.
do
    local theme_path = gears.filesystem.get_themes_dir()
    local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

    gears.table.crush(default, theme)
    theme = default
end

return theme
