local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')

local taglist = wibox { 
    width = 400, 
    height = 100,
    visible = true, 
    ontop = true
}

local tag_widget = wibox {
    
}

return taglist
