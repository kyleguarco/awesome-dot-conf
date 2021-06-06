local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local stats_widget = wibox.widget {
	{
		{
			widget = require("widgets.battery"),
			id = "battery",
		},
		{
			markup = "00",
			align = "center",
			widget = wibox.widget.textbox,
			id = "batterytext",
		},
		layout = wibox.layout.stack,
		id = "bstack",
	},
	{
		widget = require("widgets.time")
	},

	spacing = 10,
	--spacing_widget = wibox.widget.separator,
	inner_fill_strategy = "justify",
	layout = wibox.layout.flex.horizontal,
}

local stats_wibox = wibox {
	border_width = beautiful.border_width,
	border_color = beautiful.border_focus,
	bg = beautiful.bg,
	fg = beautiful.fg,
	height = beautiful.widget_stat_height,
	width = beautiful.widget_stat_width,
}

stats_wibox:setup {
	stats_widget,
	layout = wibox.layout.flex.horizontal,
}

local function _on_charge_change(is_charging, charge)
	stats_widget.bstack.batterytext.markup = "<span fgcolor='#000000'> " .. charge .. "</span>"
end

widget:connect_signal("battery_widget::changed", _on_charge_change)

return stats_wibox
