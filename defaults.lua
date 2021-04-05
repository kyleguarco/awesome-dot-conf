-- defaults.lua (global scope)
-- This is loaded in rc.lua to load the defaults for some services in awesome.

local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local xresources = require('beautiful.xresources')

local dpi = xresources.apply_dpi

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
