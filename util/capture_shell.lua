-- util/capture_shell.lua (local scope)
-- Adds a wrapper for capturing command output.
-- https://awesomewm.org/doc/api/libraries/awful.spawn.html#easy_async_with_shell

local awful = require('awful')
local gears = require('gears')

-- This function passes a table of values to `callback`, seperated in stdout by a ";"
local function capture(cmd, callback, outfile)
	if not outfile then
		outfile = "AWESOMEOUT"
	end

	awful.spawn.easy_async_with_shell("sleep 1; " .. cmd .. "> /tmp/" .. outfile,
	function()
		-- Callback: stdout, stderr, exitreason ("exit" or "signal"), exitcode
		awful.spawn.easy_async_with_shell("cat /tmp/" .. outfile,
		function(stdout)
			-- For some reason, the string must end with a ';' to be properly processed.
			local data = gears.string.split(stdout, ";")
			callback(data)
		end)
	end)
end

return capture
