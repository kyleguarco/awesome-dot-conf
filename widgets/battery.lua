local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local battery_widget = wibox.widget {
    value = 100,
    max_value = 100,
    border_color = beautiful.border_focus,
    border_width = beautiful.widget_bat_border_width,
    background_color = beautiful.bg,
    color = beautiful.widget_bat_normal,
    margins = beautiful.widget_bat_margin,
    widget = wibox.widget.progressbar,
}

local function _on_watch_update(batwidget, stdout)
    local data = gears.string.split(stdout, ';')

    local is_charging = data[2] == "1"
    batwidget.value = tonumber(data[1])

    if is_charging then
        batwidget.color = beautiful.widget_bat_charging
    else
        batwidget.color = beautiful.widget_bat_normal
    end

    -- So interestingly enough, this emit_signal call pushes arguments onto
    -- the stack backwards (with data[2] actually being the first argument "is_charging")
    widget:emit_signal("battery_widget::changed", data[1], is_charging)
end

local battery_widget_watch = awful.widget.watch(
    script("get_power"), 4, _on_watch_update, battery_widget)

return battery_widget_watch
