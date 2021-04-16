local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local systray_widget = wibox.widget {
	widget = wibox.widget.systray,
}

local systray_wibox = wibox {
	border_width = beautiful.border_width,
	border_color = beautiful.border_focus,
	bg = beautiful.bg,
	fg = beautiful.fg,
	height = beautiful.widget_systray_height,
	width = beautiful.widget_systray_width,
}

systray_wibox:setup {
	systray_widget,
	layout = wibox.layout.flex.horizontal,
}

return systray_wibox
