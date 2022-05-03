local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')
local wibox = require('wibox')

local _dpi = beautiful.xresources.apply_dpi

local default_args = {
	bg = beautiful.bg,
	placement = function(d) return awful.placement.top(d, { margins = _dpi(10) }) end,
	shape = gears.shape.rounded_rect,
	type = "desktop",
	width = _dpi(1500),
	height = _dpi(35),
	visible = false,
	ontop = true,
}

local function new(args)
	args = gears.table.crush(default_args, args or {})

	local bar = wibox(args)

	args.placement(bar)

	local forced_visible = false

	wibox.connect_signal("floatbar::toggle", function()
		if bar.visible then
			wibox.emit_signal("floatbar::hide")
		else
			wibox.emit_signal("floatbar::show")
			forced_visible = true
		end
	end)

	wibox.connect_signal("floatbar::show", function()
		bar.visible = true
	end)

	wibox.connect_signal("floatbar::hide", function()
		bar.visible = false
		forced_visible = false
	end)

	-- Hide the bar if a client shows up on the current tag
	awful.tag.attached_connect_signal(bar.s, "tagged", function(t, c)
		if not forced_visible then
			wibox.emit_signal("floatbar::hide")
		end
	end)

	-- Show the bar if no clients are on the current tag
	awful.tag.attached_connect_signal(bar.s, "untagged", function(t, c)
		if #t:clients() == 0 and not forced_visible then
			wibox.emit_signal("floatbar::show")
		end
	end)

	screen.connect_signal("tag::history::update", function()
		local t = awful.screen.focused().selected_tag
		if forced_visible or t == nil then return end
		if #t:clients() == 0 then
			wibox.emit_signal("floatbar::show")
		else
			wibox.emit_signal("floatbar::hide")
		end
	end)

	return bar
end

return new
