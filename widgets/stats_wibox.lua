local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local stats_widget = wibox.widget {
	{
		widget = require("widgets.battery"),
		id = "battery",
	},
	{ widget = require("widgets.time") },

	spacing = 10,
	spacing_widget = wibox.widget.separator,
	inner_fill_strategy = "justify",
	layout = wibox.layout.ratio.horizontal,
}

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

local function on_show()
	stats_wibox.ontop = not stats_wibox.ontop
end

screen.connect_signal("mywidgets::show", on_show)

return stats_wibox
