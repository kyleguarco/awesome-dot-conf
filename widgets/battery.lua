local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local capture = require("util.capture_shell")

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

local function on_update()
    -- Updates the battery widget
    if battery_widget.visible then
        capture(script("get_power"),
        function(data)
            local is_charge = data[2] == "1"
            local charge = tonumber(data[1])

            battery_widget.value = charge

            if is_charge then
                battery_widget.color = beautiful.widget_bat_charging
            else
                battery_widget.color = beautiful.widget_bat_normal
            end

            -- So interestingly enough, this emit_signal call pushes arguments onto
            -- the stack backwards (with data[2] actually being the first argument "is_charging")
            battery_widget:emit_signal("battery_widget::changed", data[1], data[2])
        end, "BATOUT")
    end
end

screen.connect_signal("mywidgets::update", on_update)

return battery_widget
