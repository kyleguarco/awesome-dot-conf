local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local battery_widget = require("widgets.battery")

local battery_popup = awful.popup {
	bg = beautiful.transparent,
	widget = battery_widget,
	placement = function(d) awful.placement.top(d, { margins = 8 }) end,
	shape = gears.shape.rounded_rect,
	hide_on_right_click = true,
	type = "dock",
	visible = false,
	ontop = true,
}

local hide_timer = gears.timer {
	timeout = 2,
	callback = function()
		wibox.emit_signal("battery_popup::hide")
	end,
	single_shot = true
}

battery_popup:connect_signal("press", function()
	hide_timer:stop()
end)

wibox.connect_signal("show_all", function()
	wibox.emit_signal("battery_popup::show")
end)

wibox.connect_signal("battery_popup::show", function()
	battery_popup.visible = true
	hide_timer:again()
end)

wibox.connect_signal("battery_popup::hide", function()
	battery_popup.visible = false
end)

return battery_popup
