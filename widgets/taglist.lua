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
			margins = beautiful.taglist_tag_textmargin or 3,
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
		id = "background_role",
	},
	forced_width = beautiful.taglist_tag_forcewidth or 32,
	layout = wibox.layout.stack,
}

return function(s)
	return awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = tag_template_widget,
		layout = {
			spacing = beautiful.taglist_tag_spacing or 4,
			layout = wibox.layout.fixed.horizontal
		},
	}
end
