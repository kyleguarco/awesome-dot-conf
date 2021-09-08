-- screen.lua (global scope)
-- Loaded in rc.lua to set up all the screens connected to the computer
local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local beautiful = require('beautiful')

local manage = require("util.manage_wibox")

-- `w`: A wibox; `show_only`: Only triggers the visibility signals
local _manage_wibox = manage.manage_wibox

-- `s`: The screen which this wibox will be drawn onto
local _taskbar_wibar_new = require("widgets.taskbar")

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

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    s.taskbar = _taskbar_wibar_new(s)
    _manage_wibox(s.taskbar, true)
end)

local function _on_screen_added()
    naughty.notify({
        title = "Screen added!",
        text = "A new screen has been connected. Opening Arandr.",
    })

    awful.spawn("arandr")
end

screen.connect_signal("added", _on_screen_added)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
