-- os_wrapper.lua (Global scope)
--
-- Functions that wrap around awesome for easy usage.

local awful = require('awful')
local naughty = require('naughty')

-- Returns the output of a shell script.
-- Copied from https://stackoverflow.com/questions/132397/get-back-the-output-of-os-execute-in-lua
function os.capture(cmd, callback, raw)
    raw = raw or false

    local command = "sleep 1; " .. cmd .. " > " .. config.util.outfile
    local retcmd = "cat " .. config.util.outfile

    awful.spawn.easy_async_with_shell(command, function()
        awful.spawn.easy_async_with_shell(retcmd, function(stdout, stderr, reason, exit_code)
            if raw then
                stdout = string.gsub(stdout, '^%s+', '')
                stdout = string.gsub(stdout, '%s+$', '')
                stdout = string.gsub(stdout, '[\n\r]+', ' ')
            end

            callback(stdout)
        end)
    end)
end

function os.execute(cmd)
    awful.spawn.with_shell(command)
end
