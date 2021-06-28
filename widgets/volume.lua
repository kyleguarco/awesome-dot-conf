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
    margins = beautiful.widget_vol_margin,
    widget = wibox.widget.progressbar,
}

local function _on_startup()
    awful.spawn.easy_async_with_shell(script("volume", "get", "Master"),
    function(stdout)
        -- LEFTON;LEFT;RIGHTON;RIGHT;
        local data = gears.string.split(stdout, ";")
        widget:emit_signal("volume_widget::volume_changed", data[2], data[1])
    end)
end

local function _on_volume_changed(_, vol, enabled)
    if enabled == "off" then
        volume_widget.color = beautiful.bg
        volume_widget.value = 100
        return
    end

    volume_widget.color = beautiful.border_focus
    volume_widget.value = tonumber(vol)
end

awesome.connect_signal("startup", _on_startup)
widget:connect_signal("volume_widget::volume_changed", _on_volume_changed)

return volume_widget
