local wibox = require('wibox')

local systray_widget = wibox.widget {
	widget = wibox.widget.systray (true),
}

return systray_widget
