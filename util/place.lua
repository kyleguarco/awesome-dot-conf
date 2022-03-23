-- util/place.lua (local scope)
-- A utility function for modifying 'awful.placement'

local awful = require('awful')
local gears = require('gears')

-- The default arguments for widget placement functions
local c_default_widget_args = {
	attach = true,
	honor_padding = true,
	honor_workarea = true
}

-- `placement`: An `awful.placement` function
-- Fits a wibox to a part of the screen with default arguments
local function place(placement, args)
	gears.table.crush(c_default_widget_args, args)
	return placement(args)
end

return place
