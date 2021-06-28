local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local naughty = require('naughty')
local wibox = require('wibox')

local battery_widget = wibox.widget {
    value = 100,
    max_value = 100,
    border_color = beautiful.border_marked,
    border_width = beautiful.widget_bat_border_width,
    background_color = beautiful.bg,
    color = beautiful.border_focus,
    margins = beautiful.widget_bat_margin,
    widget = wibox.widget.progressbar,
}

local function _on_watch_update(batwidget, stdout)
    local data = gears.string.split(stdout, ';')

    local is_charging = data[2] == "1"
    local charge = tonumber(data[1])

    batwidget.value = charge

    if is_charging then
        batwidget.color = beautiful.border_marked
    else
        batwidget.color = beautiful.border_focus
    end

    if charge <= 10 then
        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Battery warning!",
            text = "Charge percentage is less than ten percent!",
        }
    end

    widget:emit_signal("battery_widget::changed", data[1], is_charging)
end

local battery_widget_watch = awful.widget.watch(
    script("get_power"), 4, _on_watch_update, battery_widget)

return battery_widget_watch
