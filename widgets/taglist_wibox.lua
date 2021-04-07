local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local tag_template_widget = {
	{
		{
			{
				id = 'index_role',
				align = "center",
				widget = wibox.widget.textbox,
			},
			margins = 4,
			widget = wibox.container.margin,
		},
		bg = beautiful.bg,
		shape = gears.shape.circle,
		widget = wibox.container.background,
		id = "background_role",
	},
	layout = wibox.layout.fixed.horizontal,

	create_callback = function(self, c3, index, objects)
		self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
	end,
	update_callback = function(self, c3, index, objects)
		self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
	end,
}

-- The return for this widget must be a function, since `awful.widget.taglist`
-- requires a screen as an argument, which can't be a constant during setup.
return function(s)
	local taglist_widget = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = tag_template_widget,
		layout = {
			spacing = 20,
			spacing_widget = wibox.widget.separator,
			inner_fill_strategy = "justify",
			layout  = wibox.layout.ratio.horizontal
		},
	}

	local taglist_wibox = wibox {
		border_width = beautiful.border_width,
		border_color = beautiful.border_focus,
		bg = beautiful.bg,
		fg = beautiful.fg,
		height = beautiful.widget_stat_height,
		width = beautiful.widget_stat_width,
		shape = gears.shape.infobubble,
		visible = false,
	}

	taglist_wibox:setup {
		taglist_widget,
		inner_fill_strategy = "center",
		layout = wibox.layout.ratio.horizontal,
	}

	local function set_visibility(v)
		taglist_wibox.ontop = v
		taglist_wibox.visible = v
	end

	local taglist_timer = gears.timer {
		autostart = false,
		single_shot = true,
		timeout = 3,
		callback = function()
			set_visibility(false)
		end,
	}

	screen.connect_signal("tag::history::update", function()
		if not taglist_wibox.ontop then
			set_visibility(true)
			taglist_timer:again()
		end
	end)

	return taglist_wibox
end
