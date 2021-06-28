local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local battery_widget = require("widgets.battery")
local time_widget = require("widgets.time")

-- `s`: The screen which this wibox will be drawn onto
local _taglist_widget_new = require("widgets.taglist")
local _tasklist_widget_new = require("widgets.tasklist")

local volume_widget = wibox.widget {
	{
		widget = require("widgets.volume"),
		id = "volume",
	},
	{
		align = "center",
		widget = wibox.widget.textbox,
		id = "volumetext",
	},

	layout = wibox.layout.stack,
}

local function _on_volume_change(_, vol, enabled)
	volume_widget.volumetext.text = enabled .. " " .. vol
end

widget:connect_signal("volume_widget::volume_changed", _on_volume_change)

local systray_widget = wibox.widget.systray()

return function(s)
	local wibar = awful.wibar {
		screen = s,
		stretch = true,
		position = "top",
	}

	wibar.input_passthrough = true

	wibar:setup {
		{
			_taglist_widget_new(s),
			systray_widget,
			layout = wibox.layout.flex.horizontal,
		},
		_tasklist_widget_new(s),
		{
			battery_widget,
			time_widget,
			layout = wibox.layout.flex.horizontal,
		},

		expand = "none",
		spacing = beautiful.widget_bar_spacing,
		layout = wibox.layout.flex.horizontal,
	}

	return wibar
end
