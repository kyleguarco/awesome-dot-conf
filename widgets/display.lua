local awful = require('awful')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local wibox = require('wibox')

local widget_collection = wibox.widget {
	(config.widget.battery.enable and require("widgets.battery")),
	{
		(config.widget.systray.enable and require("widgets.systray")),
		(config.widget.time.enable and require("widgets.time")),
		layout = wibox.layout.flex.horizontal,
	},
	layout = wibox.layout.flex.horizontal,
}

local display_widget = wibox {
	widget = widget_collection,
	visible = true,
}

local function on_client_visible()
	if #awful.screen.focused().selected_tag:clients() >= 1 then
		display_widget.visible = false
	else
		display_widget.visible = true
	end
	display_widget.ontop = false
end

local function on_tag_switch()
	display_widget.visible = not display_widget.visible
	display_widget.ontop = not display_widget.ontop
end

-- Toggle the widget visibility when a new client is added to the current tag
client.connect_signal("manage", on_client_visible)
client.connect_signal("unmanage", on_client_visible)
-- Toggle the widget when the tag is switched
screen.connect_signal("tag::history::update", on_client_visible)
-- Toggle the widget when a hotkey is pressed
screen.connect_signal("ws::show_display", on_tag_switch)

return display_widget
