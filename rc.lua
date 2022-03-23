local awful = require('awful')
local beautiful = require('beautiful')
local naughty = require('naughty')

-- {{{ Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Load default options for awesome libraries
--- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.append_default_layouts {
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
-- }}}

-- {{{ Utility loader
-- Load various utility functions globally (see `util/init.lua`)
require("util")
-- }}}

-- {{{ Theme initialization
-- Themes define colours, icons, font and wallpapers.
-- Required as a global table for on-the-fly changes with 'awesome-client'
theme = require("theme")
beautiful.init(theme)
-- }}}

-- {{{ Screen initialization
-- Creates tags and widgets (see `screen.lua`)
require("screen")
-- }}}

-- {{{ Global input bindings
root.keys(require("keys.globalkeys"))
root.buttons(require("keys.globalbuttons"))
-- }}}

-- {{{ Client initialization
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = require("client.rules")

-- Connects clients to appropriate signals
require("client.signal")
-- }}}
