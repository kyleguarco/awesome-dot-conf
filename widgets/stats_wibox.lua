local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local battery_widget = require("widgets.battery")
local time_widget = require("widgets.time")

local stats_widget = wibox.widget {
	{
		{
			widget = battery_widget,
			id = "battery",
		},
		{
			align = "center",
			widget = wibox.widget.textbox,
			id = "batterytext",
		},
		layout = wibox.layout.stack,
		id = "batbox",
	},
	time_widget,

	layout = wibox.layout.ratio.horizontal,
}

stats_widget:ajust_ratio(1, 0, 0.40, 0.60)

local stats_wibox = wibox {
	bg = beautiful.transparent,
	fg = beautiful.fg,
	height = beautiful.widget_stat_height,
	width = beautiful.widget_stat_width,
	widget = stats_widget,
	layout = wibox.layout.flex.horizontal,
}

local function _on_charge_change(_, charge, is_charging)
	stats_widget.batbox.batterytext.text = charge
end

widget:connect_signal("battery_widget::changed", _on_charge_change)

return stats_wibox
