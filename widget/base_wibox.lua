local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local w = { mt = {} }

local function new(args)
    args = args or {}

    local default = {
        border_width = beautiful.wibox_border_width or 5,
        width = beautiful.wibox_width or 480,
        height = beautiful.wibox_height or 120,
        bg = beautiful.wibox_bg or "#00000095",
        visible = true,
        type = "desktop",
        x = 720,
        y = 480,
    }
    
    gears.table.crush(args, default)
    return wibox(args)
end

function w.mt:__call(...)
    return new(...)
end

return setmetatable(w, w.mt)
