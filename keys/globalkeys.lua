-- keys/globalkeys.lua (global scope)
-- Initializes hotkey assignments.
local awesome = awesome

local awful = require('awful')
local beautiful = require('beautiful')
local naughty = require('naughty')
local wibox = require('wibox')
local hotkeys_popup = require('awful.hotkeys_popup')
require("awful.hotkeys_popup.keys")

-- `action`: "set" or "get"; `perc`: Used on "set", sets the volume
local update_volume = require("util.update_volume")

-- `action`: "toggle" or "status"
local update_player = require("util.update_player")

-- Modifiers
local modkeys = require("keys.modkey")
local mod, alt, ctrl, shft = modkeys.m, modkeys.a, modkeys.c, modkeys.s

local function meta(grp, desc)
	desc = desc or "<>"
	return { group = grp, description = desc }
end

local function notify(title, msg)
	local action = { timeout = 2 }
	action.title = title
	action.text = msg or nil

	naughty.notify(action)
end

awful.keyboard.append_global_keybindings {
	awful.key({ mod,	  }, "s", hotkeys_popup.show_help,
		meta("awesome", "show help")),
	awful.key({ mod, ctrl }, "r", awesome.restart,
		meta("awesome", "reload awesome")),
	awful.key({ mod, shft }, "q", awesome.quit,
		meta("awesome", "quit awesome")),
	awful.key({ mod		  }, "w", function() awful.spawn("xscreensaver-command -lock") end,
		meta("awesome", "lock the user")),
	-- HUD
	awful.key({ mod		  }, "Escape", function() wibox.emit_signal("show_all") end,
		meta("awesome", "show menu")),

	awful.key({ mod		  }, "Left", awful.tag.viewprev,
		meta("tag", "view previous")),
	awful.key({ mod		  }, "Right", awful.tag.viewnext,
		meta("tag", "view next")),

	awful.key({ mod, ctrl }, "Left", function() awful.client.focus.byidx(-1) end,
		meta("client", "focus previous by index")),
	awful.key({ mod, ctrl }, "Right", function() awful.client.focus.byidx(1) end,
		meta("client", "focus next by index")),

	-- Layout manipulation
	awful.key({ mod		  }, "j", function() awful.client.swap.byidx(-1) end,
		meta("client", "swap with previous client by index")),
	awful.key({ mod		  }, "k", function() awful.client.swap.byidx(1) end,
		meta("client", "swap with next client by index")),

	awful.key({ mod		  }, "u", awful.client.urgent.jumpto,
		meta("client", "jump to urgent client")),

	awful.key({ mod		  }, "Tab",
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		meta("client", "switch to previous client (same tag)")),

	awful.key({ mod, ctrl }, "n",
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
			c:emit_signal(
				"request::activate", "key.unminimize",
				{raise = true}
			)
			end
		end,
		meta("client", "restore minimized")),

	awful.key({ mod, ctrl }, "z", function() awful.spawn("rofi -modi window -show window -show-icons") end,
		meta("client", "Show the rofi window switcher")),

	awful.key({ mod, ctrl }, "l",	  function() awful.tag.incmwfact(0.05) end,
		meta("layout", "increase master width factor")),
	awful.key({ mod, ctrl }, "h",	  function() awful.tag.incmwfact(-0.05) end,
		meta("layout", "decrease master width factor")),
	awful.key({ mod		  }, "h",	  function() awful.tag.incnmaster(1, nil, true) end,
		meta("layout", "increase the number of master clients")),
	awful.key({ mod		  }, "l",	  function() awful.tag.incnmaster(-1, nil, true) end,
		meta("layout", "decrease the number of master clients")),
	awful.key({ mod, shft }, "h",	  function() awful.tag.incncol(1, nil, true) end,
		meta("layout", "increase the number of columns")),
	awful.key({ mod, shft }, "l",	  function() awful.tag.incncol(-1, nil, true) end,
		meta("layout", "decrease the number of columns")),
	awful.key({ mod		  }, "space", function() awful.layout.inc(1) end,
		meta("layout", "view next")),
	awful.key({ mod, ctrl }, "space", function() awful.layout.inc(-1) end,
		meta("layout", "view previous")),

	awful.key({ mod, shft }, "Left", function() awful.screen.focus_relative(-1) end,
		meta("screen", "focus the previous screen")),
	awful.key({ mod, shft }, "Right", function() awful.screen.focus_relative(1) end,
			meta("screen", "focus next screen")),

	-- Screenshots
	awful.key({ mod		  }, "Print", function() awful.spawn.easy_async(script("screenshot")) end,
		meta("screen", "take a screenshot")),
	awful.key({ mod, alt  }, "Print", function() awful.spawn.easy_async(script("screenshot", "-c")) end,
		meta("screen", "take a screenshot and copy to memory")),
	awful.key({ mod, ctrl }, "Print", function() awful.spawn.easy_async(script("screenshot", "-s", "-c")) end,
		meta("screen", "take a selection screenshot and copy to memory")),

	-- Standard program
	awful.key({ mod		  }, "Return", function() awful.spawn("alacritty") end,
		meta("launcher", "open a terminal (alacritty)")),

	awful.key({ mod, alt  }, "Return", function() awful.spawn("urxvt") end,
		meta("launcher", "open a terminal (urxvt)")),

	-- Prompt
	awful.key({ mod		  }, "r", function() awful.spawn("rofi -modi drun,window -show drun -show-icons") end,
		meta("launcher", "rofi run prompt")),

	-- Volume Keys
	awful.key({			  }, "XF86AudioRaiseVolume", function() update_volume("set", "5%+") end,
		meta("audio", "raise volume")),
	awful.key({			  }, "XF86AudioLowerVolume", function() update_volume("set", "5%-") end,
		meta("audio", "lower volume")),
	awful.key({			  }, "XF86AudioMute", function() update_volume("set", "toggle") end,
		meta("audio", "mute")),

	-- Media Player Controls
	awful.key({			  }, "XF86AudioPlay", function() update_player("toggle") end,
		meta("audio", "toggle play/pause")),
	awful.key({			  }, "XF86AudioNext", function() update_player("next") end,
		meta("audio", "next track")),
	awful.key({			  }, "XF86AudioPrev", function() update_player("prev") end,
		meta("audio", "previous track"))
}

-- Bind all key numbers to tags.
-- This should map on the top row of your keyboard, usually 1 to 9.
awful.keyboard.append_global_keybindings {
	awful.key {
		modifiers = { mod },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function (index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	},
	awful.key {
		modifiers = { mod, ctrl },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function (index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	},
	awful.key {
		modifiers = { mod, shft },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function (index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	},
	awful.key {
		modifiers = { mod, ctrl, shft },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function (index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}
}
