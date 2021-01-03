-- config.lua (Local scope)
--
-- For customizing small parts of the configuration, without having to
-- dig deep into the source code to change it.

local geom = require("util.geom")

config = {}

config.terminal = "urxvt"
config.modkey = { m = "Mod4", a = "Mod1", c = "Control", s = "Shift" }

config.widget = {}
config.widget.enable = true

-- The widget that displays the screen widgets
config.widget.display = {}
config.widget.display.layout_func = geom.screen.top

config.widget.battery = {}
config.widget.battery.enable = true

config.widget.systray = {}
config.widget.systray.enable = true

config.widget.time = {}
config.widget.time.enable = true

config.util = {}
config.util.screen_updates = config.widget.enable
config.util.screen_updates_tick = 20
-- An outfile for asynchronous stdout capture
config.util.outfile = "/tmp/AWESOMEOUT"
-- power_supply directory as listed under '/sys/class/power_supply'
-- Must have a 'capacity' file
config.util.batteryfile = "BAT0"
