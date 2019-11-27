local gears = require('gears')
local naughty = require('naughty')

-- Default notification position
naughty.config.defaults = gears.table.crush(naughty.config.defaults, {
    position = "top_middle"
})

-- Personal configuration (global table)
config = {
    terminal = "st"
}
