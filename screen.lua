-- screen.lua (global scope)
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
        honor_workarea = true,
        -- Sets all margins to the useless_gap of the workspace.
        margins = setmetatable({}, {
            __index = function()
                return beautiful.useless_gap + beautiful.useless_gap_offset
            end
        })
    })
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Widget setup
    stats_wibox = require("widgets.stats_wibox")
    systray_wibox = require("widgets.systray_wibox")

    fit(s, stats_wibox, awful.placement.top_right)
    fit(s, systray_wibox, awful.placement.top_left)
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

-- local function on_tag_swap()
--     awful.popup {
--         border_color = beautiful.border_normal,
--         border_width = 2,
--         placement = awful.placement.top,
--         width = 800,
--         height = 100,
--         shape = gears.shape.rounded_rect,
--         screen = awful.screen.focused(),
--         widget = {
--             text = "HI!",
--             widget = wibox.widget.textbox,
--             margins = 10,
--             layout = wibox.container.margin,
--         },
--         ontop = true,
--         visible = true,
--     }
-- end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
-- screen.connect_signal("tag::history::update", on_tag_swap)
