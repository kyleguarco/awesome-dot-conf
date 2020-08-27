-- geom.lua (Local scope only)
-- 
-- Uses the geometry returned from any 'awful.placement' function and
-- applies an offset.

local geom = {}

function placement(widget, func, offset)
    -- If offset isn't even present, return
    if not offset then return end
    -- If one element in the table isn't preset, return 0
    setmetatable(offset, { __index = function() return 0 end })

    local new_geom = func(widget)
    widget.x = new_geom.x + offset.x
    widget.y = new_geom.y + offset.y
end

return geom
