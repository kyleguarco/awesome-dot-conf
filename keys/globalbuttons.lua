local awful = require('awful')
local gears = require('gears')

-- Modifiers
local modkeys = require("keys.modkey")
local mod = modkeys.m

return gears.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ mod }, 4, awful.tag.viewnext),
    awful.button({ mod }, 5, awful.tag.viewprev)
)
