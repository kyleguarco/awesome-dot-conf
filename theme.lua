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

local font = "lemon"

local theme = {
    -- "wallpaper" should be a symlink (see script/set_wallpaper.sh)
    wallpaper                               = get_home_dir() .. ".wallpaper",

    font                                    = font,
    icon_theme                              = "Arc",

    hotkeys_border_width                    = _dpi(1),
    hotkeys_group_margin                    = _dpi(4),
    hotkeys_modifiers_fg                    = colordb.color12,

    separator_thinkness                     = 4,
    separator_span_ratio                    = 0.25,

    notification_border_width               = _dpi(3),
    notification_border_color               = colordb.color6,
    notification_spacing                    = _dpi(5),
    notification_width                      = _dpi(550),
    notification_icon_size                  = _dpi(60),
    notification_shape                      = gears.shape.octogon,

    wibar_height                            = _dpi(24),
    wibar_bg                                = colordb.background,
    wibar_fg                                = colordb.foreground,
    wibar_type                              = "desktop",

    tasklist_align                          = "center",
    tasklist_font_minimized                 = font .. " Italic",
    tasklist_font_urgent                    = font .. " Bold",
    tasklist_bg_minimize                    = colordb.color7,

    titlebar_fg                             = colordb.foreground,
    titlebar_bg                             = colordb.color0,
    titlebar_bg_normal                      = colordb.foreground,
    titlebar_fg_normal                      = colordb.color0,

    bg_systray                              = colordb.background,
    systray_icon_spacing                    = _dpi(4),

    border_width                            = _dpi(2),
    border_normal                           = colordb.color8,
    border_focus                            = colordb.color13,
    border_marked                           = colordb.color7,

    bg                                      = colordb.background,
    fg                                      = colordb.foreground,

    -- Custom theme variables
    transparent                             = colordb.background .. "00",
    hotkey_popup_width                      = _dpi(1024),
    hotkey_popup_height                     = _dpi(820),
    hotkey_popup_margin                     = _dpi(40),

    titlebar_position                       = "bottom",

    -- Used to offset widgets behind clients.
    useless_gap_offset                      = _dpi(10),

    taglist_tag_spacing                     = _dpi(4),
    taglist_tag_textmargin                  = _dpi(1),
    taglist_tag_forcewidth                  = _dpi(30),
    wibar_systray_iconsize                  = _dpi(20),
    wibar_widget_margin                     = _dpi(3),
    wibar_widget_tagspace                   = _dpi(4),
    wibar_widget_statspace                  = _dpi(6),
}

-- Merge the default theme with the custom one.
do
    local theme_path = gears.filesystem.get_themes_dir()
    local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

    gears.table.crush(default, theme)
    theme = default
end

return theme
