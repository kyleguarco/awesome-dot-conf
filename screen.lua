-- screen.lua (global scope)
--
-- Loaded in rc.lua to set up all the screens connected to the computer

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

-- `drawable`: A wibox; `placement`: An `awful.placement` function
local function fit(s, drawable, placement)
    drawable.s = s
    placement(drawable, {
        parent = s,
        attach = true,
        honor_padding = true,
    })
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Widget setup
    widget_battery = require("widgets.battery")(require("widgets.time"))
    fit(s, widget_battery, awful.placement.centered)
end)

-- Create a timer to emit an update signal for widgets
gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        screen.emit_signal("ws::update")
    end
}

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
