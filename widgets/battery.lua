local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local capture = require("util.capture_shell")

local cont_placeholder

-- Widget
local battery_widget = wibox.widget {
    {
        require("widgets.time"),
        visible = true,
        strategy = "min",
        layout = wibox.container.constraint,
    },
    max_value = 100,
    min_value = 1,
    start_angle = math.rad(90),
    thickness = 9,
    paddings = {
        top = 100, bottom = top,
        left = top, right = top,
    },
    values = { 100, },
    colors = { beautiful.widget_bat_normal, },
    border_width = beautiful.border_width,
    bg = beautiful.bg,
    visible = true,
    layout = wibox.container.arcchart,
}

function battery_widget:fit(context, width, height)
	self.x = width / 8
	self.y = height / 8
	self.width = width / 2
	self.height = height / 4
end

local battery_wibox = wibox {
    width = 1000,
    height = 1000,
    shape = gears.shape.circle,
    border_color = beautiful.border_focus,
    opacity = 1,
    visible = true,
    ontop = false,
    widget = battery_widget,
}

local function on_update()
    -- Updates the battery widget
    if battery_wibox.visible then
        capture(script("get_power"),
        function(data)
            local is_charge = data[2] == "1"
            if is_charge then
                battery_widget.colors[1] = beautiful.widget_bat_charge
            else
                battery_widget.colors[1] = beautiful.widget_bat_normal
            end

            local charge = tonumber(data[1])
            battery_widget.value = charge

            if charge < 20 and not is_charge then
                battery_widget.colors[1] = beautiful.widget_bat_critical
            end
        end)
    end
end

local function on_swap()
    if #awful.screen.focused().clients > 0 then
        battery_wibox.opacity = 0.8
    else
        battery_wibox.opacity = 1
    end
end

local function on_show()
    battery_wibox.ontop = not battery_wibox.ontop
    battery_wibox.visible = not battery_wibox.visible
    on_swap()
end

local function on_manage()
    battery_wibox.ontop = #awful.screen.focused().clients == 0
    battery_wibox.visible = not battery_wibox.visible
end

screen.connect_signal("ws::update", on_update)
screen.connect_signal("ws::show", on_show)
screen.connect_signal("tag::history::update", on_swap)
client.connect_signal("unmanage", on_manage)

return function(widget)
    cont_placeholder = widget
    return battery_wibox
end
