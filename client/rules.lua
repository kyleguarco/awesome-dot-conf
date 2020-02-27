local awful = require('awful')
local beautiful = require('beautiful')

local clientkeys = require("keys.clientkeys")
local clientbuttons = require("keys.clientbuttons")

return {
    -- All clients will match this rule.
    { rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },

            class = {
                "Arandr",
                "Wpa_gui",
                "gimp",
                "Gimp",
                "st"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
				"Picture-in-Picture", -- Firefox PIP Feature (72.0.1)
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }, 
        properties = { 
            floating = true
        },
    },

    -- Popup dialogs
    { rule_any = { type = { "dialog" } },
        properties = { 
            placement = awful.placement.centered
        }
    },

    -- Add titlebars to normal clients
    { rule_any = { type = { "normal" } }, 
        properties = { 
            titlebars_enabled = true 
        }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
