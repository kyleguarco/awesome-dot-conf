local awful = require('awful')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')

local m = require("keys.modkey")
local mod, alt, ctrl, shft = m.m, m.a, m.c, m.s

local function meta(desc)
    desc = desc or "<>"
    return { group = "client", description = desc }
end

local clientkeys = gears.table.join(
    awful.key({ mod       }, "f", 
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        meta "toggle fullscreen"),

    awful.key({ mod, shft }, "c", function(c) c:kill() end,
        meta "close"),

    awful.key({ mod, ctrl }, "v", 
        function(c)
            c.floating = not c.floating
        end,
        meta "toggle floating"),

    awful.key({ mod, ctrl }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        meta "move to master"),

    awful.key({ mod       }, "o", function(c) c:move_to_screen() end,
        meta "move to screen"),

    awful.key({ mod       }, "t", function(c) c.ontop = not c.ontop end,
        meta "toggle keep on top"),

    awful.key({ mod       }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        meta "minimize"),

    awful.key({ mod       }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        meta "(un)maximize"),

    awful.key({ mod       }, "m",
        function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        meta "(un)maximize vertically"),

    awful.key({ mod, shft }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        meta "(un)maximize horizontally")
)

return clientkeys
