local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

-- Load personal configuration
require("config")

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

-- {{{ Theme Initialization
-- Themes define colours, icons, font and wallpapers.
-- Required as a global table for on-the-fly changes with 'awesome-client'
theme = require(config.themefile) 
beautiful.init(theme)
-- }}}

-- {{{ Screen Initialization (Creates tags and widgets)
require(".screen")
-- }}}

-- {{{ Global input bindings
root.keys(require("keys.globalkeys"))
root.buttons(require("keys.globalbuttons"))
-- }}}

-- {{{ Client Initialization
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = require(".client.rules")

-- Connects clients to appropriate signals
require(".client.signal")
-- }}}
