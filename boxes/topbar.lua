-- boxes/topbar.lua (local scope)
-- Sets up the "taskbar" at the top of the screen

local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local _floatbar = require("boxes.floatbar")
local _battery_widget = require("widgets.battery")
local _volume_widget = require("widgets.volume")
local _textclock_widget = require("widgets.textclock")

local _dpi = beautiful.xresources.apply_dpi

local function new()
	local floatbar = _floatbar()

	floatbar:setup {
		_battery_widget(),
		_volume_widget(),

		wibox.widget.systray,
		_textclock_widget(),
		spacing = _dpi(10),
		layout = wibox.layout.flex.horizontal,
	}

	return floatbar
end

return new
