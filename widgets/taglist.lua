local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')

local function _tag_create_callback(self, t, index, tags)
	self:get_children_by_id("index_role")[1].markup = '<b> '..index..' </b>'
end

local tag_template_widget = {
	{
		{
			{
				align = "center",
				widget = wibox.widget.textbox,
				id = 'index_role',
			},
			margins = 4,
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
		id = "background_role",
	},
	layout = wibox.layout.stack,

	create_callback = _tag_create_callback,
}

return function(s)
	return awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = tag_template_widget,
		layout = {
			inner_fill_strategy = "justify",
			layout = wibox.layout.ratio.horizontal
		},
	}
end
