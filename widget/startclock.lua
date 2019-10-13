local gears = require('gears')
local wibox = require('wibox')

local dpi = require('beautiful.xresources').get_dpi

local date = wibox.widget.textclock("%A, %B %d, %Y")
local time = wibox.widget.textclock("%I:%M%p")
date.font = "lemon Medium 29"
time.font = "lemon Medium 16"

local clockbox = wibox {
    border_width = 5,
    --border_color = "#0DABF0",
    visible = true,
    type = "desktop",
    x = 720,
    y = 480,
    width = 480,
    height = 120,
    bg = "#00000095",
}

clockbox : setup {
    layout = wibox.layout.align.vertical,
    {
        layout = wibox.layout.align.vertical,
        date,
        time
    }
}

return clockbox
