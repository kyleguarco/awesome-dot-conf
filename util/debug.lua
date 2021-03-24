-- debug.lua (local scope)
--
-- Provides a function that prints some output to a naughty function
local naughty = require('naughty')

local function debug(msg)
	local text = msg
	if type(msg) == "table" then
		text = ""
		for idx, str in ipairs(msg) do
			text = text..idx..":"..str..","
		end
	end

	naughty.notify {
		preset = naughty.config.presets.critical,
		position = "bottom_right",
		title = "DEBUG",
		text = text
	}
end

return debug
