local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local battery_widget = require("widgets.battery")
local time_widget = require("widgets.time")

local stats_widget = wibox.widget {
	{
		align = "right",
		widget = wibox.widget.textbox,
		id = "batterytext",
	},
	{
		widget = battery_widget,
		id = "battery",
	},
	{
		widget = time_widget
	},

	--spacing = 1,
	--spacing_widget = wibox.widget.separator,
	inner_fill_strategy = "justify",
	layout = wibox.layout.ratio.horizontal,
}

stats_widget:ajust_ratio(2, 0.10, 0.40, 0.50)

local stats_wibox = wibox {
	border_width = beautiful.border_width,
	border_color = beautiful.border_focus,
	bg = beautiful.bg,
	fg = beautiful.fg,
	height = beautiful.widget_stat_height,
	width = beautiful.widget_stat_width,
	widget = stats_widget,
	layout = wibox.layout.flex.horizontal,
}

local function _on_charge_change(_, charge, is_charging)
	stats_widget.batterytext.text = charge
end

widget:connect_signal("battery_widget::changed", _on_charge_change)

return stats_wibox
