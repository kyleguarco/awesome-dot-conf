-- screen.lua (global scope)
-- Loaded in rc.lua to set up all the screens connected to the computer

local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local naughty = require('naughty')
local beautiful = require('beautiful')

local manage = require("util.manage_wibox")

-- `s`: The screen which this wibox will be drawn onto
-- The new taglist function returned by the taglist script
-- local _taglist_wibox_new = require("widgets.taglist_wibox")
-- local _fit_wibox = manage.fit_wibox
-- local _manage_wibox = manage.manage_wibox
local _wibar_wibox_new = require("widgets.taskbar_wibox")

-- Sets the wallpaper on screen `s`
local function _set_wallpaper(s)
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
    _set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Widget setup
    -- s.stats_wibox = require("widgets.stats_wibox")
    -- s.systray_wibox = require("widgets.systray_wibox")
    -- s.volume_wibox = require("widgets.volume_wibox")
    -- s.taglist_wibox = _taglist_wibox_new(s)

    -- _manage_wibox(s.stats_wibox)
    -- _fit_wibox(s.stats_wibox, awful.placement.top_left)

    -- _manage_wibox(s.systray_wibox)
    -- _fit_wibox(s.systray_wibox, awful.placement.top_right)

    -- _fit_wibox(s.taglist_wibox, awful.placement.top)
    -- _manage_wibox(s.taglist_wibox)

    -- _manage_wibox(s.volume_wibox)
    -- _fit_wibox(s.volume_wibox, awful.placement.next_to, {
    --     geometry = s.taglist_wibox,
    --     preferred_positions = "bottom",
    -- })

    s.taskbar = _wibar_wibox_new(s)
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
screen.connect_signal("property::geometry", _set_wallpaper)
