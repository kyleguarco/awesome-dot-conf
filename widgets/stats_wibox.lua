local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local stats_widget = wibox.widget {
	{
		widget = require("widgets.battery"),
		id = "battery",
	},
	{
		text = "00",
		align = "center",
		widget = wibox.widget.textbox,
		id = "batterytext",
	},
	{ widget = require("widgets.time") },

	spacing = 10,
	--spacing_widget = wibox.widget.separator,
	inner_fill_strategy = "justify",
	layout = wibox.layout.ratio.horizontal,
}
stats_widget:ajust_ratio(2, 0.45, 0.05, 0.50)

local stats_wibox = wibox {
	border_width = beautiful.border_width,
	border_color = beautiful.border_focus,
	bg = beautiful.bg,
	fg = beautiful.fg,
	height = beautiful.widget_stat_height,
	width = beautiful.widget_stat_width,
	visible = true,
}

stats_wibox:setup {
	stats_widget,
	layout = wibox.layout.flex.horizontal,
}

local function on_charge_change(is_charging, charge)
	stats_widget.batterytext.text = charge
end

stats_widget.battery:connect_signal("battery_widget::changed", on_charge_change)

local function on_show()
	stats_wibox.ontop = not stats_wibox.ontop
end

screen.connect_signal("mywidgets::show", on_show)

return stats_wibox
