local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

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

	create_callback = function(self, t, index, tags)
		self:get_children_by_id("index_role")[1].markup = '<b> '..index..' </b>'
	end,
}

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

	create_callback = function(self, c, index, clients)
		self:get_children_by_id("name_role")[1].markup = '<b>'..c.class..'</b>'
	end
}

-- The return for this widget must be a function, since `awful.widget.taglist`
-- requires a screen as an argument, which can't be a constant during setup.
return function(s)
	local taglist_widget = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		widget_template = tag_template_widget,
		style = {
			bg = beautiful.fg,
			shape = gears.shape.circle,
		},
		layout = {
			inner_fill_strategy = "justify",
			layout = wibox.layout.ratio.horizontal
		},
	}

	local tasklist_widget = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		widget_template = task_template_widget,
		layout = {
			inner_fill_strategy = "justify",
			layout = wibox.layout.ratio.horizontal
		},
	}

	local taglist_wibox = wibox {
		border_width = beautiful.border_width,
		border_color = beautiful.border_focus,
		bg = beautiful.bg,
		fg = beautiful.fg,
		height = beautiful.widget_taglist_height,
		width = beautiful.widget_taglist_width,
		shape = gears.shape.rectangle,
		visible = false,
	}

	local r_taglist_widget = wibox.widget {
		{
			{
				taglist_widget,
				inner_fill_strategy = "center",
				layout = wibox.layout.ratio.horizontal,
			},
			margins = beautiful.widget_taglist_margin,
			layout = wibox.container.margin,
		},
		{
			{
				{
					tasklist_widget,
					inner_fill_strategy = "center",
					layout = wibox.layout.ratio.horizontal,
				},
				margins = beautiful.border_width,
				color = beautiful.fg,
				layout = wibox.container.margin,
			},
			margins = 2 * beautiful.widget_taglist_margin,
			layout = wibox.container.margin,
		},
		layout = wibox.layout.ratio.vertical,
	}
	r_taglist_widget:ajust_ratio(1, 0, 0.4, 0.6)

	taglist_wibox:setup {
		r_taglist_widget,
		inner_fill_strategy = "justify",
		layout = wibox.layout.flex.vertical,
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

	local function on_show()
		if not taglist_wibox.ontop then
			set_visibility(true)
			taglist_timer:again()
		end
	end

	screen.connect_signal("tag::history::update", on_show)
	client.connect_signal("focus", on_show)

	return taglist_wibox
end
