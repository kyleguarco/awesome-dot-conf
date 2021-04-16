local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local battery_widget = wibox.widget {
    value = 10,
    max_value = 100,
    border_color = beautiful.border_focus,
    border_width = beautiful.widget_bat_border_width,
    background_color = beautiful.bg,
    color = beautiful.widget_bat_normal,
    margins = beautiful.widget_bat_margin,
    widget = wibox.widget.progressbar,
}

local battery_widget_watch = awful.widget.watch(script("get_power"), 5,
    function(widget, stdout)
        local data = gears.string.split(stdout, ';')

        local is_charge = data[2] == "1"
        local charge = tonumber(data[1])

        widget.value = charge

        if is_charge then
            widget.color = beautiful.widget_bat_charging
        else
            widget.color = beautiful.widget_bat_normal
        end

        -- So interestingly enough, this emit_signal call pushes arguments onto
        -- the stack backwards (with data[2] actually being the first argument "is_charging")
        widget:emit_signal("battery_widget::changed", data[1], data[2])
    end,
battery_widget)

return battery_widget_watch
