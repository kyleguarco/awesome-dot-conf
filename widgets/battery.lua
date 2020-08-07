local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local battery_widget = wibox { 
    width = 50, 
    height = 50, 
    visible = true, 
    ontop = true 
}

local textbox = wibox.widget {
    markup = "update_charge",
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox
}

battery_widget : setup {
    textbox,
    layout = wibox.layout.manual
}

screen.connect_signal("ws::update", function()
    -- Updates the battery widget
    os.capture(script("grab_battery", { config.util.batteryfile }),
    function(out)
        textbox.markup = out
        battery_widget:draw() 
    end)
end)

return battery_widget
