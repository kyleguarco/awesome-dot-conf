local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local task_template_widget = {
	{
		wibox.widget.base.make_widget(),
		forced_height = beautiful.wibar_widget_margin or 3,
		widget = wibox.container.background,
		id = "background_role",
	},
	{
		{
			{
				widget = wibox.widget.imagebox,
				id = "icon_role",
			},
			{
				widget = wibox.widget.textbox,
				id = "text_role",
			},
			spacing = 2,
			fill_space = true,
			layout = wibox.layout.fixed.horizontal,
		},
		margins = 2,
		widget = wibox.container.margin
	},
	layout = wibox.layout.align.vertical,
}

return function(s)
	return awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		widget_template = task_template_widget,
		layout = {
			inner_fill_strategy = "justify",
			layout = wibox.layout.ratio.horizontal
		},
	}
end
