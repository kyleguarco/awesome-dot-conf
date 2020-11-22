local awful = require('awful')
require('awful.autofocus')
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

-- Load the global config
require("config")

-- Load various utility functions globally (see util.init)
require("util")

-- Load the new default options for awesome libraries
require("defaults")

-- {{{ Theme Initialization
-- Themes define colours, icons, font and wallpapers.
-- Required as a global table for on-the-fly changes with 'awesome-client'
theme = require("theme")
beautiful.init(theme)
-- }}}

-- {{{ Screen Initialization (Creates tags and widgets)
require("screen")
-- }}}

-- {{{ Global input bindings
local keys_keyboard = require("keys.globalkeys")
local keys_mouse = require("keys.globalbuttons")
root.keys(keys_keyboard)
root.buttons(keys_mouse)
-- }}}

-- {{{ Client Initialization
-- Rules to apply to new clients (through the "manage" signal).
local client_rules = require("client.rules")
awful.rules.rules = client_rules

-- Connects clients to appropriate signals
require("client.signal")
-- }}}
