local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')

local time_widget = require("widgets.time")

-- `s`: The screen which this wibox will be drawn onto
local _taglist_widget_new = require("widgets.taglist")
local _tasklist_widget_new = require("widgets.tasklist")

local battery_widget = wibox.widget {
	{
		text = "NIL",
		align = "left",
		widget = wibox.widget.textbox,
		id = "battext",
	},
	{
		widget = require("widgets.battery"),
		id = "bat",
	},
	forced_width = 100,
	layout = wibox.layout.fixed.horizontal,
}

local function _on_charge_change(_, charge, is_charging)
	if is_charging then
		battery_widget.battext.text = "🞧" .. charge
		return
	end

	charge = tonumber(charge)

	if charge >= 50 then
		battery_widget.battext.text = "🞉"
	elseif charge >= 10 then
		battery_widget.battext.text = "🞺"
	end

	battery_widget.battext.text = battery_widget.battext.text..charge
end

widget:connect_signal("battery_widget::changed", _on_charge_change)

local volume_widget = wibox.widget {
	{
		align = "center",
		widget = wibox.widget.textbox,
		id = "volumetext",
	},
	{
		widget = require("widgets.volume"),
		id = "volume",
	},
	forced_width = 100,
	layout = wibox.layout.fixed.horizontal,
}

local function _on_volume_change(_, vol, enabled)
	if enabled == "off" then
		volume_widget.volumetext.text = "🞮"
		return
	end

	vol = tonumber(vol)

	if vol >= 30 then
		volume_widget.volumetext.text = "🞛"
	elseif vol >= 20 then
		volume_widget.volumetext.text = "🞜"
	elseif vol >= 10 then
		volume_widget.volumetext.text = "🞚"
	end
end

widget:connect_signal("volume_widget::volume_changed", _on_volume_change)

local systray_widget = wibox.widget.systray()

return function(s)
	local wibar = awful.wibar {
		screen = s,
		stretch = true,
		position = "top",
	}

	wibar:setup {
		{
			_taglist_widget_new(s),
			systray_widget,
			layout = wibox.layout.fixed.horizontal,
		},
		_tasklist_widget_new(s),
		{
			volume_widget,
			battery_widget,
			time_widget,
			layout = wibox.layout.fixed.horizontal,
		},

		expand = "none",
		layout = wibox.layout.align.horizontal,
	}

	return wibar
end
