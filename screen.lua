-- screen.lua (global scope)
-- Loaded in rc.lua to set up all the screens connected to the computer
local screen = screen

local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

local battery_popup = require("boxes.battery_popup")
local volume_popup = require("boxes.volume_popup")

screen.connect_signal("request::wallpaper", function(s)
	awful.wallpaper {
		screen = s,
		widget = {
			{
				image = beautiful.wallpaper,
				upscale = true,
				downscale = true,
				widget = wibox.widget.imagebox,
			},
			valign = "center",
			halign = "center",
			tiled  = false,
			widget = wibox.container.tile,
		}
	}
end)

screen.connect_signal("request::desktop_decoration", function(s)
	-- Each screen has its own tag table.
	awful.tag(
		{ "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" }, 
		s, awful.layout.layouts[1]
	)
	
	s.battery_popup = battery_popup
	s.volume_popup = volume_popup
end)
