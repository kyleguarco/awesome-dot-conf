-- update_volume.lua (local scope)
local awful = require('awful')
local gears = require('gears')

local function update_volume(action, perc)
    local cmd = script("volume", action, "Master", perc or "0%+")

    awful.spawn.easy_async_with_shell(cmd, function(stdout)
        -- LEFTON;LEFT;RIGHTON;RIGHT;
        local data = gears.string.split(stdout, ";")
        awesome.emit_signal("volume::volume_changed", data[2], data[1])
    end)
end

return update_volume
