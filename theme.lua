-- theme.lua
--
-- This theme file should only touch widget components of the window manager, 
-- not how windows are designed. This theme file should only define what icons 
-- are used for different widgets.
--
-- Anything else should go into the Xresources file (colors, window icon themes, fonts...)
--

local gears = require('gears')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local theme = {
    wallpaper = os.getenv("HOME") .. "/Pictures/wallpapers/moonlit.jpg",

    font = "Charybdis 18",
    icon_theme = "Faba",

    separator_thinkness = 5,
    separator_span_ratio = 0.25,

    notificaion_border_width = dpi(4),
    -- notification_height = dpi(25),
    notification_spacing = dpi(4),

    titlebar_bg = "#001020",
    titlebar_close_button_focus = get_config_dir().."assets/window_close.png",
    titlebar_close_button_normal = get_config_dir().."assets/window_close.png",

    useless_gap   = dpi(4),
    border_width  = dpi(2),
    --border_normal = "#AB0AC0",
    --border_focus  = "#0ABAEB",
    --border_marked = "#BEABA0",
    border_normal = "#100525",
    border_focus  = "#605075",
    border_marked = "#BEABA0",
}

-- Merge the default theme with the custom one.
do
    local theme_path = gears.filesystem.get_themes_dir()
    local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

    gears.table.crush(default, theme)
    theme = default
end

return theme
