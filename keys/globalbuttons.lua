local awful = require('awful')
local gears = require('gears')

local m = require("keys.modkey")
local mod = m.m

return gears.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ mod }, 4, awful.tag.viewnext),
    awful.button({ mod }, 5, awful.tag.viewprev)
)
