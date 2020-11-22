local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- placement(wibox, func, offset)
local geom = require("util.geom")
local place = geom.placement

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

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Widget setup
    if config.widget.enable then
        s.widget_display = require("widgets.display")
        s.widget_display.x = s.geometry.width / 8
        s.widget_display.y = s.geometry.height / 8
    end
end)

-- Create a timer to emit the update signal for widgets
if config.util.screen_updates then
    gears.timer {
        timeout   = config.util.screen_updates_tick,
        call_now  = true,
        autostart = true,
        callback  = function()
            screen.emit_signal("ws::update")
        end
    }
end
