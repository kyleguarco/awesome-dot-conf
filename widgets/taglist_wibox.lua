local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

-- `s`: The screen which this wibox will be drawn onto
local _taglist_widget_new = require("widgets.taglist")
local _tasklist_widget_new = require("widgets.tasklist")

-- The return for this widget must be a function, since `awful.widget.taglist`
-- requires a screen as an argument, which can't be a constant during setup.
return function(s)
	local taglist_widget = _taglist_widget_new(s)
	local tasklist_widget = _tasklist_widget_new(s)

	local taglist_wibox = wibox {
		bg = beautiful.transparent,
		fg = beautiful.fg,
		height = beautiful.widget_taglist_height,
		width = beautiful.widget_taglist_width,
		shape = gears.shape.rectangle,
		visible = false,
	}
	-- This is a workaround for a v4.3 bug.
	taglist_wibox.input_passthrough = true

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
		layout = wibox.layout.ratio.horizontal,
	}
	r_taglist_widget:ajust_ratio(1, 0, 0.4, 0.6)

	taglist_wibox:setup {
		r_taglist_widget,
		inner_fill_strategy = "justify",
		layout = wibox.layout.flex.vertical,
	}

	local function _set_visibility(v)
		taglist_wibox.ontop = v
		taglist_wibox.visible = v
	end

	local taglist_timer = gears.timer {
		autostart = false,
		single_shot = true,
		timeout = 3,
		callback = function()
			_set_visibility(false)
		end,
	}

	local function _on_show()
		if not taglist_wibox.ontop then
			_set_visibility(true)
			taglist_timer:again()
		end
	end

	screen.connect_signal("tag::history::update", _on_show)
	client.connect_signal("focus", _on_show)

	return taglist_wibox
end
