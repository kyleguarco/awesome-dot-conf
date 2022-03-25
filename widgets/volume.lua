local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local percent_widget = wibox.widget {
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox
}

local bar_widget = wibox.widget {
	color = beautiful.fg,
	background_color = beautiful.bg,
	max_value = 100,
	value = 0,
	shape = gears.shape.rounded_bar,
	widget = wibox.widget.progressbar
}

local final_widget = wibox.widget {
	{
		id = "inner",
		{ id = "barbox",
			{ id = "bar", widget = bar_widget },
			strategy = "max",
			width = dpi(200),
			height = dpi(20),
			widget = wibox.container.constraint
		},
		{ id = "barlabel", widget = percent_widget },
		layout = wibox.layout.stack,
	},
	margins = 8,
	widget = wibox.container.margin
}

local function update_widget(lefton, leftv)
	local statuscolor = lefton == "on" and beautiful.color4 or beautiful.color8

	final_widget.inner.barlabel.markup = 
		"<span foreground='"..statuscolor.."'>"
		..lefton.." || "..leftv..
		"</span>"
	final_widget.inner.barbox.bar.value = tonumber(leftv)

	wibox.emit_signal("volume_widget::changed", lefton, leftv)
end

wibox.connect_signal("volume_widget::request::new_volume", update_widget)

-- Just to make sure it updates periodically
return awful.widget.watch(script("volume", "get", "Master"), 20, function(widget, output)
	local data = gears.string.split(output, ";")

	update_widget(data[1], data[2])
end, final_widget)
