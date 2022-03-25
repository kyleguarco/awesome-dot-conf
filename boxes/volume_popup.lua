local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local volume_widget = require("widgets.volume")

local volume_popup = awful.popup {
	bg = beautiful.bg,
	widget = volume_widget,
	placement = function(d) awful.placement.bottom(d, { margins = 8 }) end,
	shape = gears.shape.rounded_rect,
	hide_on_right_click = true,
	type = "dock",
	visible = false,
	ontop = true,
}

local hide_timer = gears.timer {
	timeout = 2,
	callback = function()
		wibox.emit_signal("volume_popup::hide")
	end,
	single_shot = true
}

wibox.connect_signal("show_all", function()
	wibox.emit_signal("volume_popup::show")
end)

wibox.connect_signal("volume_popup::show", function()
	volume_popup.visible = true
	hide_timer:again()
end)

wibox.connect_signal("volume_popup::hide", function()
	volume_popup.visible = false
end)

return volume_popup
