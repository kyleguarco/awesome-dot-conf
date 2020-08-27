-- display.lua
--
-- This is the widget that displays all the other widgets. It is the first
-- widget placed on the screen. 

local wibox = require('wibox')

local display = { window = wibox(), widgets = {} }

function display:redraw()
    self.window:draw()
end

function display:add_widget(widget)
    local widget_count = #self.widgets
    self.widgets[widget_count + 1] = widget
end

return display
