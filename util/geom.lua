-- geom.lua (Local scope)
--
-- Functions that can align widgets to a certain part of the screen, taking useless_gap
-- into account whe aligning the widgets. This is mainly used for the display widget.

local beautiful = require('beautiful')

local geom = {}

-- s: current screen; widget: An AwesomeWM widget
geom.screen = {}
function geom.screen.top(s, widget)
	widget.x = beautiful.useless_gap
	widget.y = beautiful.useless_gap
	widget.height = beautiful.widget_display_size
	widget.width = s.geometry.width - beautiful.useless_gap * 2
end

function geom.screen.bottom(s, widget)
	widget.x = beautiful.useless_gap
	widget.height = beautiful.widget_display_size
	widget.y = s.geometry.height - beautiful.useless_gap - widget.height
	widget.width = s.geometry.width - beautiful.useless_gap * 2
end

function geom.screen.right(s, widget)
	widget.width = beautiful.widget_display_size
	widget.x = s.geometry.width - beautiful.useless_gap - widget.width
	widget.y = beautiful.useless_gap
	widget.height = s.geometry.height - beautiful.useless_gap * 2
end

function geom.screen.left(s, widget)
	widget.x = beautiful.useless_gap
	widget.y = beautiful.useless_gap
	widget.height = s.geometry.height - beautiful.useless_gap * 2
	widget.width = beautiful.useless_gap + beautiful.widget_display_size
end

function geom.screen.center_box(s, widget)
	local center_x = s.geometry.width / 2
	local center_y = s.geometry.height / 2

	widget.x = center_x - beautiful.widget_display_size
	widget.y = center_y - beautiful.widget_display_size
	widget.height = beautiful.widget_display_size * 2
	widget.width = beautiful.widget_display_size * 2
end

function geom.screen.center_bar(s, widget)
	local half_y = s.geometry.height / 2

	widget.x = beautiful.useless_gap
	widget.height = beautiful.widget_display_size
	widget.y = half_y - widget.height / 2
	widget.width = s.geometry.width - beautiful.useless_gap * 2
end

return geom
