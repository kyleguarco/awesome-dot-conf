local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local function _task_create_callback(self, c, index, clients)
	self:get_children_by_id("name_role")[1].markup = '<b>'..c.class..'</b>'
end

local task_template_widget = {
	{
		{
			{
				align = "center",
				valign = "center",
				widget = wibox.widget.textbox,
				id = "name_role",
			},
			margins = 2,
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
		id = "background_role",
	},
	layout = wibox.layout.stack,

	create_callback = _task_create_callback,
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
