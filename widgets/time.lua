local wibox = require('wibox')

local time_widget = wibox.widget {
	align = "center",
	widget = wibox.widget.textclock ("%A %m/%d/%y (%I:%M%p)"),
}

return time_widget
