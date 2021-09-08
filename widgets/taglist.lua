local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local tag_template_widget = {
	{
		{
			{
				align = "center",
				widget = wibox.widget.textbox,
				id = 'text_role',
			},
			margins = 3,
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
		id = "background_role",
	},
	forced_width = 32,
	layout = wibox.layout.stack,
}

return function(s)
	return awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = tag_template_widget,
		layout = {
			spacing = 4,
			layout = wibox.layout.fixed.horizontal
		},
	}
end
