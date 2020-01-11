local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

local w = { mt = {} }

local function new(args)
    local default = {
        border_width = beautiful.wibox_border_width or 5,
        bg = beautiful.wibox_bg or "#00000095",
        width = 480,
        height = 120,
        type = "normal"
    }
    
    if args then gears.table.crush(default, args) end
    return wibox(default)
end

function w.mt:__call(...)
    return new(...)
end

return setmetatable(w, w.mt)
