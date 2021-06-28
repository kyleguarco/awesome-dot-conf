-- manage_wibox.lua (local scope)
-- Utilities for capturing wibox visibility.

local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

-- The default arguments for widget placement functions
local c_default_widget_args = {
    attach = true,
    honor_padding = true,
    honor_workarea = true,
    -- Sets all margins to the useless_gap of the workspace.
    margins = beautiful.useless_gap + beautiful.useless_gap_offset,
}

local manage_wibox = {}

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

-- `drawable`: A wibox; `placement`: An `awful.placement` function
-- Fits a wibox to a part of the screen with default arguments
function manage_wibox.fit_wibox(drawable, placement, args)
    if args then
        gears.table.crush(c_default_widget_args, args)
    else
        args = c_default_widget_args
    end

    placement(drawable, args)
end

-- `w`: A wibox
-- Connects wibox `w` to signals that can trigger `_manage_visi[_force]`
function manage_wibox.manage_wibox(w)
    widget:connect_signal("show", _manage_visi_force(w))
    screen.connect_signal("tag::history::update", _manage_visi(w))
    client.connect_signal("manage", _manage_visi(w))
    client.connect_signal("unmanage", _manage_visi(w))
end

return manage_wibox
