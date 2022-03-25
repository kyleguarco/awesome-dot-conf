-- update_player.lua (local scope)
-- Allows for control of the media player via `playerctl`
local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')

local function update_player(action)
    local cmd = script("player", action or "status")

    awful.spawn.easy_async_with_shell(cmd, function(stdout)
        -- ISPLAYING;TITLE;ARTIST;ART
        local data = gears.string.split(stdout, ";")
        wibox.emit_signal("player::toggle", data[4], data[3], data[2], data[1])
    end)
end

return update_player
