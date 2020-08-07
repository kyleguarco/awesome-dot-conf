-- os_wrapper.lua
-- 
-- Defines 'os.capture' to return the output of a shell script.
-- Copied from https://stackoverflow.com/questions/132397/get-back-the-output-of-os-execute-in-lua
--

local awful = require('awful')
local naughty = require('naughty')

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
