local gears = require('gears')
local wibox = require('wibox')

local mywibox = require("widget.base_wibox")

local date = wibox.widget.textclock("%A, %B %d, %Y")
local time = wibox.widget.textclock("%I:%M%p")

local clockbox = mywibox() 

clockbox : setup {
    layout = wibox.layout.align.vertical,
    {
        layout = wibox.layout.align.vertical,
        date,
        time
    }
}

return clockbox
