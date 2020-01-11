local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')

-- Personal configuration (global table)
config = {
    -- "themefile" in module notation
    themefile = "theme.angel",
    terminal = "st",
    modkeys = { m = "Mod4", a = "Mod1", c = "Control", s = "Shift" }
}

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
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

-- Set the default notification position
naughty.config.defaults = gears.table.crush(naughty.config.defaults, {
    position = "top_middle"
})
