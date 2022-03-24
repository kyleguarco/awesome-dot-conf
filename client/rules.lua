local awful = require('awful')
local ruled = require('ruled')

local default_properties = {
    focus = awful.client.focus.filter,
    raise = true,
    screen = awful.screen.preferred,
    placement = awful.placement.no_overlap+awful.placement.no_offscreen,
    maximized_horizontal = false,
    maximized_vertical = false,
    maximized = false
}

local add_rule = ruled.client.append_rule

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    add_rule {
		id = "global",
		rule = { },
        properties = default_properties
    }

    add_rule {
		id = "terminal_size_honor",
		rule = { class = { "URxvt", "Alacritty" } },
    	properties = {
            size_hints_honor = false
        }
    }

	add_rule {
		id = "force_floating_dialog",
		rule_any = {
			type = { "dialog" },
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
				"Godot_Engine",
				"vncviewer",
                -- ImageMagick "display" tool
                "display-im6.q16",
                "Display-im6.q16",
                -- GCR-Viewer (X11 authentication)
                "gcr-prompter",
                "Gcr-prompter",
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
    }
end)
