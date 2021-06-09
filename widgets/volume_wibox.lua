local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local volume_widget = wibox.widget {
	{
		text = "NIL",
		align = "center",
		widget = wibox.widget.textbox,
		id = "volumetext",
	},
	{
		widget = require("widgets.volume"),
		id = "volume",
	},

	layout = wibox.layout.ratio.horizontal,
}

volume_widget:ajust_ratio(1, 0, 0.15, 0.85)

local volume_wibox = wibox {
	border_width = beautiful.border_width,
	border_color = beautiful.border_focus,
	bg = beautiful.bg,
	fg = beautiful.fg,
	height = beautiful.widget_volume_height,
	width = beautiful.widget_volume_width,
	widget = volume_widget,
	layout = wibox.layout.flex.horizontal,
	visible = false,
}

-- Again, works around a v4.3 bug.
volume_wibox.input_passthrough = false

local function _set_visibility(v)
	volume_wibox.ontop = v
	volume_wibox.visible = v
end

local volume_wibox_timer = gears.timer {
	autostart = false,
	single_shot = true,
	timeout = 3,
	callback = function()
		_set_visibility(false)
	end,
}

local function _on_volume_change(_, vol, enabled)
	volume_widget.volumetext.text = enabled .. " " .. vol
	_set_visibility(true)
	volume_wibox_timer:again()
end

widget:connect_signal("volume_widget::volume_changed", _on_volume_change)

return volume_wibox
