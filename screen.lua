local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

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

local function placement(widget, func, offset)
    -- If offset isn't even present, return
    if not offset then return end
    -- If one element in the table isn't preset, return 0
    setmetatable(offset, { __index = function() return 0 end })

    local new_geom = func(widget)
    widget.x = new_geom.x + offset.x
    widget.y = new_geom.y + offset.y
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Widget setup
    if config.widget.battery then
        s.battery_widget = require("widget.battery")
        placement(s.battery_widget, awful.placement.top, {y = 10})
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
