local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local default_args = {
	format = "%A %m/%d/%y (%I:%M%p)",
	align = "center",
	shape = gears.shape.rounded_rect,
	bg = beautiful.bg,
}

local function new(args)
	args = gears.table.crush(default_args, args or {})

	local textclock_widget = wibox.widget {
		format = args.format,
		align = args.align,
		widget = wibox.widget.textclock,
	}

	return wibox.widget {
		textclock_widget,
		shape = args.shape,
		bg = args.bg,
		widget = wibox.container.background,
	}
end

return new
