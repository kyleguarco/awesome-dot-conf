local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local wibox = require('wibox')

local dpi = xresources.apply_dpi

local widget_collection = wibox.widget {
	(config.widget.battery.enable and require("widgets.battery") or nil),
	layout = wibox.layout.manual
}

local display_widget = wibox {
	widget = widget_collection,
	width = dpi(1000),
	height = dpi(500),
	visible = true,
	layout = wibox.layout.flex.vertical
}

return display_widget
