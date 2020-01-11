local awful = require('awful')
local wibox = require('wibox')

local mywibox = require("widget.base_wibox")

local screen_geo = awful.screen.focused().geometry

local hud = mywibox {
    width = screen_geo.width,
    height = screen_geo.height,
    ontop = true
}

function hud:toggle()
    self.visible = not self.visible
end

hud:setup {
    layout = wibox.layout.align.vertical,
    {
        require("widget.startclock"),
        layout = wibox.layout.align.horizontal,
    }
}

return hud
