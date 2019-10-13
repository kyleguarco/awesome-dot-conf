local gears = require('gears')
local wibox = require('wibox')

local dpi = require('beautiful.xresources').get_dpi

local time = wibox.widget.textclock("%I:%M%p")
local date = wibox.widget.textclock("%a, %b %d")

local clock = wibox.widget 
{
    layout = wibox.layout.align.verical,
    time,
    date
}

local clockbox = wibox {
    border_width = dpi(2),
    border_color = "#000000",
    cursor = nil,
    visible = true,
    type = "desktop",
    x = 20,
    y = 20,
    width = dpi(800),
    height = dpi(600),
    widget = clock,
    shape_bounding = gears.shape.rectangle,
    shape_clip = nil,
    bg = "#0000FF",
    bgimage = nil,
    fg = "#00FF00",
    shape = gears.shape.rectangle
}

return clockbox
