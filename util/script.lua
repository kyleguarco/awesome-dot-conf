-- util/script.lua (global scope)
-- Defines a global funcion 'script' that returns he path of a shell script.
-- Useful for widgets with 'capture' to grab the output of a command for display.

local gears = require('gears')

function script(name, ...)
    local args = table.pack(...)
    local cmd = gears.filesystem.get_configuration_dir().."script/"..name..".sh "

    for _, arg in ipairs(args) do
        cmd = cmd..arg.." "
    end

    return cmd
end
