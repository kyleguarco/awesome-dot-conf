local wibox = require('wibox')

local systray_widget = wibox.widget {
	forced_height = 50,
	forced_width = 100,
	widget = wibox.widget.systray,
}

return systray_widget
