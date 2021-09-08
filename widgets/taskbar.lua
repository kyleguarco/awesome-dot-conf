local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local time_widget = require("widgets.time")

-- `s`: The screen which this wibox will be drawn onto
local _taglist_widget_new = require("widgets.taglist")
local _tasklist_widget_new = require("widgets.tasklist")

local function wrap_in_margins(base)
	return wibox.widget {
		base,
		top = 3,
		color = beautiful.fg,
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

-- local function _on_volume_change(_, vol, enabled)
-- 	vol = tonumber(vol)

-- 	if enabled == "off" or vol == 0 then
-- 		volume_widget.volumetext.text = "🔈" .. vol
-- 		return
-- 	end

-- 	volume_widget.volumetext.text = "🔊" .. vol
-- end

local systray_widget = wrap_in_margins {
	forced_width = 100,
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
			spacing = 5,
			layout = wibox.layout.fixed.horizontal,
		},
		{
			_tasklist_widget_new(s),
			spacing = 5,
			layout = wibox.layout.flex.horizontal,
		},
		{
			systray_widget,
			battery_widget,
			time_widget,
			spacing = 5,
			layout = wibox.layout.fixed.horizontal,
		},
		layout = wibox.layout.align.horizontal,
	}

	return wibar
end
