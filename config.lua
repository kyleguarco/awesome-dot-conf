config = {}
config.terminal = "urxvt"
config.modkey = { m = "Mod4", a = "Mod1", c = "Control", s = "Shift" }

config.widget = {}
config.widget.battery = false

config.util = {}
config.util.screen_updates = false
config.util.screen_updates_tick = 20
-- An outfile for asynchronous stdout capture
config.util.outfile = "/tmp/AWESOMEOUT"
-- power_supply directory as listed under '/sys/class/power_supply'
-- Must have a 'capacity' file
config.util.batteryfile = "BAT0"
