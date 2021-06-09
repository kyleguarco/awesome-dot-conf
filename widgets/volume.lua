local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local volume_widget = wibox.widget {
    value = 100,
    max_value = 100,
    border_color = beautiful.border_normal,
    border_width = beautiful.useless_gap,
    background_color = beautiful.bg,
    color = beautiful.border_focus,
    margins = beautiful.widget_bat_margin,
    widget = wibox.widget.progressbar,
}

local function _on_volume_changed(_, vol, enabled)
    if enabled == "off" then
        volume_widget.color = beautiful.bg
    else
        volume_widget.color = beautiful.border_focus
    end
    volume_widget.value = tonumber(vol)
end

widget:connect_signal("volume_widget::volume_changed", _on_volume_changed)

return volume_widget
