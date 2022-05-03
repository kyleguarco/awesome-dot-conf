-- update_volume.lua (local scope)
local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')

local function update_volume(action, perc)
    local cmd = script("volume", action, "Master", perc or "0%+")

    awful.spawn.easy_async_with_shell(cmd, function(stdout)
        -- LEFTON;LEFT;RIGHTON;RIGHT;
        local data = gears.string.split(stdout, ";")
        wibox.emit_signal("player::request::volume", data[1], data[2])
		wibox.emit_signal("player::show")
    end)
end

return update_volume
