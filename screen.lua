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
    margins = beautiful.useless_gap + beautiful.useless_gap_offset,
}

-- `s`: The screen which this wibox will be drawn onto
-- The new taglist function returned by the taglist script
local _taglist_wibox_new = require("widgets.taglist_wibox")

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

-- `drawable`: A wibox; `placement`: An `awful.placement` function
-- Fits a wibox to a part of the screen with default arguments
local function _fit_wibox(drawable, placement, args)
    if args then
        gears.table.crush(c_default_widget_args, args)
    else
        args = c_default_widget_args
    end

    return placement(drawable, args)
end

-- `w`: A wibox
-- Toggles a wibox' visibility according to the number of clients.
local function _manage_visi(w)
    return function()
        if not w.ontop then
            w.visible = #awful.screen.focused().selected_tag:clients() == 0
        end
    end
end

-- `w`: A wibox
-- Toggles a wibox' visibility as requested by 'mywidgets::show'
local function _manage_visi_force(w)
    return function()
        w.ontop = not w.ontop
        if not w.ontop then
            w.visible = #awful.screen.focused().selected_tag:clients() == 0
        else
            w.visible = true
        end
    end
end

-- `w`: A wibox
-- Connects wibox `w` to signals that can trigger `_manage_visi[_force]`
local function _manage_wibox(w)
    screen.connect_signal("mywidgets::show", _manage_visi_force(w))
    screen.connect_signal("tag::history::update", _manage_visi(w))
    client.connect_signal("manage", _manage_visi(w))
    client.connect_signal("unmanage", _manage_visi(w))
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    _set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" }, s, awful.layout.layouts[1])

    -- Widget setup
    local stats_wibox = require("widgets.stats_wibox")
    local systray_wibox = require("widgets.systray_wibox")
    local taglist_wibox = _taglist_wibox_new(s)

    _fit_wibox(stats_wibox, awful.placement.top_right)
    _manage_wibox(stats_wibox)
    _fit_wibox(systray_wibox, awful.placement.top_left)
    _manage_wibox(systray_wibox)
    _fit_wibox(taglist_wibox, awful.placement.bottom, {
        margins = 8 * beautiful.useless_gap
    })
end)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", _set_wallpaper)
