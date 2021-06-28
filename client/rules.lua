local awful = require('awful')
local beautiful = require('beautiful')

local clientkeys = require("keys.clientkeys")
local clientbuttons = require("keys.clientbuttons")

local default_properties = {
    -- border_width = beautiful.border_width,
    -- border_color = beautiful.border_normal,
    focus = awful.client.focus.filter,
    raise = true,
    keys = clientkeys,
    buttons = clientbuttons,
    screen = awful.screen.preferred,
    placement = awful.placement.no_overlap+awful.placement.no_offscreen,
    maximized_horizontal = false,
    maximized_vertical = false,
    maximized = false
}

local rules = {
    -- All clients will match this rule.
    {   rule = { },
        properties = default_properties
    },

    {	rule = { class = "URxvt" },
    	properties = {
            size_hints_honor = false
        }
    },

    {   rule_any = { type = { "normal" } },
        properties = {
            titlebars_enabled = true
        }
    },

    -- Floating clients.
    {   rule_any = { type = { "floating" } },
        properties = {
            titlebars_enabled = false
        }
    },

    -- Disable titlebars for the terminal
    {   rule = { class = "URxvt" },
        properties = {
            titlebars_enabled = false
        }
    },

    {   rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Wpa_gui",
                "Gimp-2.10",
                -- Set any Godot window to float (Works around some bugs in 4.0)
                "Godot",
				"vncviewer",
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
        except_any = {
            instance = {
                -- Make an exception to the GIMP editor itself
                "gimp-2.10",
                -- ... and the Godot editor windows
                "Godot_Editor",
                "Godot_ProjectList",
            }
        },
        properties = {
            floating = true,
            placement = awful.placement.centered
        },
    },

    -- Popup dialogs
    {   rule_any = { type = { "dialog" } },
        properties = {
            placement = awful.placement.centered
        }
    }
}

return rules
