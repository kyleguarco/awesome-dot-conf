local beautiful = require('beautiful')
local wibox = require('wibox')

local bar_widget = wibox.widget {
    max_value = 100,
    value = 0,
    paddings = 1,
    border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    color = beautiful.widget_battery_fg or "#105010",
    background_color = beautiful.widget_battery_bg or "#A01020",
    widget = wibox.widget.progressbar,
}

local text_widget = wibox.widget {
    text = "NAN%",
    align = "center",
    widget = wibox.widget.textbox
}

local battery_widget = wibox.widget {
    bar_widget,
    text_widget,
    layout = wibox.layout.stack
}

screen.connect_signal("ws::update", function()
    -- Updates the battery widget
    os.capture(script("grab_battery", config.util.batteryfile),
    function(out)
        text_widget.text = out
        bar_widget.value = tonumber(out)
    end)
end)

return battery_widget
