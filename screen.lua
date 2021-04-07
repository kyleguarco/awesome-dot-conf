-- screen.lua (global scope)
-- Loaded in rc.lua to set up all the screens connected to the computer

local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- The default arguments for widget placement functions
local c_default_widget_args = {
    attach = true,
    honor_padding = true,
    honor_workarea = true,
    -- Sets all margins to the useless_gap of the workspace.
    margins = setmetatable({}, {
        __index = function()
            return beautiful.useless_gap + beautiful.useless_gap_offset
        end
    })
}

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
local function fit(drawable, placement, args)
    if args then
        gears.table.crush(args, c_default_widget_args)
    else
        args = c_default_widget_args
    end

    return placement(drawable, args)
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Widget setup
    stats_wibox = require("widgets.stats_wibox")
    systray_wibox = require("widgets.systray_wibox")
    taglist_wibox = require("widgets.taglist_wibox")(s)

    fit(stats_wibox, awful.placement.top_right)
    fit(systray_wibox, awful.placement.top_left)
    fit(taglist_wibox, awful.placement.bottom)
end)

-- Create a timer to emit an update signal for widgets
gears.timer {
    timeout = 5,
    call_now = true,
    autostart = true,
    callback = function()
        screen.emit_signal("mywidgets::update")
    end
}

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
