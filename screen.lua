-- screen.lua (global scope)
-- Loaded in rc.lua to set up all the screens connected to the computer
local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local battery_popup = require("boxes.battery_popup")

-- Sets the wallpaper on screen `s`
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

	s.battery_popup = battery_popup

    -- Each screen has its own tag table.
    awful.tag({ "I", "II", "III", "IV" }, s, awful.layout.layouts[1])
end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
