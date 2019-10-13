-- <Theme Module>
-- Returns a theme table, merged with a default theme

-- Define global theme table
-- Can be controlled with 'awesome-client'
theme = {}

local gears = require('gears')

local protected_call = gears.protected_call
local crush = gears.table.crush
local dofile = dofile

function theme:crush(theme)
    local default_path = gears.filesystem.get_themes_dir() .. "default/theme.lua"
    local default_theme = protected_call(dofile, default_path)

    crush(_G.theme, default_theme)
    -- If no theme is specified, return the default
    if theme == nil then return end
    
    local new_theme = require("theme.".. theme)
    crush(self, new_theme)
end

return theme
