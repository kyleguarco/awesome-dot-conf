local gears = require('gears')
local xresources = require('beautiful.xresources')

local dpi = xresources.get_dpi

local theme = {}

theme.wallpaper = os.getenv("HOME") .. "/Pictures/Wallpapers/meadow.jpg"

theme.font = "Fira Code 12"
theme.icon_theme = "Faba"

theme.notification_font = "Fira Code 8"
theme.notificaion_border_width = 4
theme.notification_spacing = 4

theme.useless_gap   = 8
theme.border_width  = 4
theme.border_normal = "#BCABDA"
theme.border_focus  = "#ABCBFC"
theme.border_marked = "#CFBCBA"

do
    local theme_path = gears.filesystem.get_themes_dir()
    local default = gears.protected_call(dofile, theme_path .. "default/theme.lua")

    --gears.table.crush(theme, default)
end

return theme
