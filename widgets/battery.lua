local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local label_widget = wibox.widget {
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox
}

local percent_widget = wibox.widget {
	align = "center",
	valign = "center",
	widget = wibox.widget.textbox
}

local bar_widget = wibox.widget {
	background_color = beautiful.fg,
	max_value = 100,
	value = 0,
	shape = gears.shape.rounded_bar,
	widget = wibox.widget.progressbar
}

local final_widget = wibox.widget {
	{
		id = "inner",
		{ id = "iconlabel", widget = label_widget },
		{ id = "innerbar",
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
		layout = wibox.layout.ratio.horizontal,
	},
	margins = 8,
	widget = wibox.container.margin
}
final_widget.inner:adjust_ratio(2, 0.2, 0.8, 0)

local was_ac = false

return awful.widget.watch(script("get_power"), 4, function(widget, output)
	data = gears.string.split(output, ";")
	power_s = data[1]
	power = tonumber(power_s)
	is_ac = data[2] == "1"
	
	if not is_ac then
		widget.inner.iconlabel.text = "⏻ "
		if was_ac or power <= 10 then
			wibox.emit_signal("battery_widget::show")
			was_ac = false
		end
	else
		widget.inner.iconlabel.text = "🞦 "
		was_ac = true
	end

	widget.inner.innerbar.barlabel.text = power_s
	widget.inner.innerbar.barbox.bar.value = power
end, final_widget)
