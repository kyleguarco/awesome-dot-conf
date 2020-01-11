local gears = require('gears')
local xresources = require('beautiful.xresources')
local dpi = xresources.apply_dpi

local theme = {}

theme.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpapers/meadow.jpg"

theme.font = "Fira Code 12"
theme.icon_theme = "Faba"

theme.notification_font = "Fira Code Bold 8"
theme.notificaion_border_width = dpi(4)
--theme.notification_height = dpi(25)
theme.notification_spacing = dpi(4)

theme.titlebar_font = "Fira Code Bold 8"
theme.titlebar_bg = "#000020"

theme.useless_gap   = dpi(4)
theme.border_width  = dpi(2)
--theme.border_normal = "#AB0AC0"
--theme.border_focus  = "#0ABAEB"
--theme.border_marked = "#BEABA0"
theme.border_normal = "#100525"
theme.border_focus  = "#605075"
theme.border_marked = "#BEABA0"

do
    local theme_path = gears.filesystem.get_themes_dir()
    local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

    gears.table.crush(default, theme)
    theme = default
end

return theme
