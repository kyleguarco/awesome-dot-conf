local awful = require('awful')
local beautiful = require('beautiful')
local xresources = require('beautiful.xresources')
local wibox = require('wibox')

local widget_collection = wibox.widget {
	{
		(config.widget.battery.enable and require("widgets.battery")),
		layout = wibox.layout.flex.horizontal,
	},
	{
		(config.widget.battery.enable and require("widgets.battery")),
		layout = wibox.layout.flex.horizontal,
	},
	layout = wibox.layout.flex.vertical,
}

local display_widget = wibox {
	widget = widget_collection,
	visible = true,
}

local function client_callback()
	if #awful.screen.focused().selected_tag:clients() >= 1 then
		display_widget.visible = false
	else
		display_widget.visible = true
	end
	display_widget.ontop = false
end

local function toggle_visible()
	display_widget.visible = not display_widget.visible
	display_widget.ontop = not display_widget.ontop
end

-- Toggle the widget visibility when a new client is added to the current tag
client.connect_signal("manage", client_callback)
-- Toggle the widget when the tag is switched
screen.connect_signal("tag::history::update", client_callback)
-- Toggle the widget when a hotkey is pressed
screen.connect_signal("ws::show_display", toggle_visible)

return display_widget
