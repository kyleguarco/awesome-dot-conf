local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

-- `action`: "set" or "get"; `perc`: Used on "set", sets the volume
local _update_volume = require("util.update_volume")

-- `s`: The screen which this wibox will be drawn onto
local _taglist_widget_new = require("widgets.taglist")
local _tasklist_widget_new = require("widgets.tasklist")

local function wrap_in_margins(base)
	return wibox.widget {
		base,
		top = beautiful.wibar_widget_margin or 3,
		color = beautiful.fg,
		draw_empty = false,
		widget = wibox.container.margin,
	}
end

local function update_battery_widget(widget, stdout)
	local data = gears.string.split(stdout, ';')

	local charge = tonumber(data[1])
	local is_charging = data[2] == "1"

	if is_charging then
		widget.text.text = "🔌" .. charge
		return
	end

	if charge <= 10 then
		widget.text.text = "🔥" .. charge
	else
		widget.text.text = "🔋" .. charge
	end
end

local battery_widget = wrap_in_margins {
	align = "left",
	widget = wibox.widget.textbox,
	id = "text",
}

local battery_widget = awful.widget.watch(script("get_power"), 4,
	update_battery_widget, battery_widget)

local volume_widget = wrap_in_margins {
	align = "left",
	widget = wibox.widget.textbox,
	id = "text",
}

local function _on_volume_change(vol, enabled)
	vol = tonumber(vol)

	if enabled == "off" or vol == 0 then
		volume_widget.text.text = "🔈" .. vol
		return
	end

	volume_widget.text.text = "🔊" .. vol
end

local function _on_startup_volume()
	_update_volume("get")
end

awesome.connect_signal("volume::volume_changed", _on_volume_change)
awesome.connect_signal("startup", _on_startup_volume)

local time_widget = wibox.widget {
	align = "center",
	widget = wibox.widget.textclock ("%A %m/%d/%y (%I:%M%p)"),
}

local systray_widget = wrap_in_margins {
	base_size = beautiful.wibar_systray_iconsize or 64,
	widget = wibox.widget.systray(),
}

return function(s)
	local wibar = awful.wibar {
		screen = s,
		stretch = true,
		position = "top",
	}

	wibar:setup {
		{
			_taglist_widget_new(s),
			spacing = beautiful.wibar_widget_tagspace or 10,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			_tasklist_widget_new(s),
			layout = wibox.layout.flex.horizontal,
		},
		{
			systray_widget,
			battery_widget,
			volume_widget,
			time_widget,
			spacing = beautiful.wibar_widget_statspace or 10,
			fill_space = true,
			layout = wibox.layout.fixed.horizontal,
		},
		layout = wibox.layout.align.horizontal,
	}

	return wibar
end
