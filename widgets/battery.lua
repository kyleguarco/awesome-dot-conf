local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local dpi = beautiful.xresources.apply_dpi

local function new()
	local percent_widget = wibox.widget {
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox
	}

	local bar_widget = wibox.widget {
		color = beautiful.color2,
		background_color = beautiful.fg,
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

	return awful.widget.watch(script("get_power"), 4, function(widget, output)
		local data = gears.string.split(output, ";")
		local power_s = data[1]
		local power = tonumber(power_s)
		local is_ac = data[2] == "1"

		if power <= 10 and not is_ac then
			wibox.emit_signal("battery_widget::critical")
		end

		widget.inner.barlabel.markup = "<span foreground='"..beautiful.bg.."'> 🔋"..power_s.."</span>"
		widget.inner.barbox.bar.value = power

		wibox.emit_signal("battery_widget::changed", is_ac, power)
	end, final_widget)
end

return new
