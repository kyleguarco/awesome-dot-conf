local wibox = require('wibox')

local time_widget = wibox.widget {
	align = "center",
	widget = wibox.widget.textclock ("%a, %b %d, %Y - %I:%M%p"),
}

return time_widget
