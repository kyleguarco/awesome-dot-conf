local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local _dpi = beautiful.xresources.apply_dpi

local default_args = {
	bg = beautiful.transparent,
	fg = beautiful.bg,
	placement = function(d) awful.placement.centered end,
	shape = gears.shape.rounded_rect,
	type = "desktop",
	width = _dpi(300),
	height = _dpi(300),
	visible = false,
	ontop = true,
}

local function new(args)
	args = gears.table.crush(args or {}, default_args)

	local notebox = awful.popup(args)

	local hide_timer = gears.timer {
		timeout = 2,
		callback = function()
			wibox.emit_signal("notebox::hide")
		end,
		single_shot = true
	}

	notebox:connect_signal("press", function()
		hide_timer:stop()
		wibox.emit_signal("notebox::hide")
	end)

	wibox.connect_signal("notebox::show", function()
		bar.visible = true
	end)

	wibox.connect_signal("notebox::hide", function()
		bar.visible = false
	end)

	return bar
end

return new
