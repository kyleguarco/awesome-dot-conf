local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local hotkeys_popup = require('awful.hotkeys_popup')

local m = require("keys.modkey")
local mod, alt, ctrl, shft = m.m, m.a, m.c, m.s

local function meta(grp, desc)
    desc = desc or "<>"
    return { group = grp, description = desc }
end

local function volume(action, msg)
    awful.spawn.with_shell("amixer set Master " .. action)
    naughty.notify { 
        title = "Volume",
        timeout = 0.5, 
        text = msg 
    }
end

local globalkeys = gears.table.join(
    awful.key({ mod,      }, "s", hotkeys_popup.show_help,
        meta("awesome", "show help")),
    awful.key({ mod, ctrl }, "r", awesome.restart,
        meta("awesome", "reload awesome")),
    awful.key({ mod, shft }, "q", awesome.quit,
        meta("awesome", "quit awesome")),

    awful.key({ mod       }, "Left", awful.tag.viewprev,
        meta("tag", "view previous")),
    awful.key({ mod       }, "Right", awful.tag.viewnext,
        meta("tag", "view next")),
    awful.key({ mod       }, "Escape", awful.tag.history.restore,
        meta("tag", "go back")),

    awful.key({ mod       }, "j", function() awful.client.focus.byidx(1) end,
        meta("client-g", "focus next by index")),
    awful.key({ mod       }, "k", function() awful.client.focus.byidx(-1) end,
        meta("client-g", "focus previous by index")),

    -- Layout manipulation
    awful.key({ mod, shft }, "j", function() awful.client.swap.byidx(1) end,
        meta("client-g", "swap with next client by index")),
    awful.key({ mod, shft }, "k", function() awful.client.swap.byidx(-1) end,
        meta("client-g", "swap with previous client by index")),

    awful.key({ mod       }, "u", awful.client.urgent.jumpto,
        meta("client-g", "jump to urgent client")),

    awful.key({ mod       }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        meta("client-g", "go back")),

    awful.key({ mod       }, "n",
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
        meta("client-g", "restore minimized")),

    awful.key({ mod       }, "l",     function() awful.tag.incmwfact(0.05) end,
        meta("layout", "increase master width factor")),
    awful.key({ mod       }, "h",     function() awful.tag.incmwfact(-0.05) end,
        meta("layout", "decrease master width factor")),
    awful.key({ mod, shft }, "h",     function() awful.tag.incnmaster(1, nil, true) end,
        meta("layout", "increase the number of master clients")),
    awful.key({ mod       }, "l",     function() awful.tag.incnmaster(-1, nil, true) end,
        meta("layout", "increase the number of master clients")),
    awful.key({ mod       }, "h",     function() awful.tag.incncol(1, nil, true) end,
        meta("layout", "increase the number of columns")),
    awful.key({ mod       }, "l",     function() awful.tag.incncol(-1, nil, true) end,
        meta("layout", "decrease the number of columns")),
    awful.key({ mod       }, "space", function() awful.layout.inc(1) end,
        meta("layout", "view next")),
    awful.key({ mod, ctrl }, "space", function() awful.layout.inc(-1) end,
        meta("layout", "view previous")),

    awful.key({ mod, ctrl }, "j", function() awful.screen.focus_relative(1) end,
        meta("screen", "focus next screen")),
    awful.key({ mod, ctrl }, "k", function() awful.screen.focus_relative(-1) end,
        meta("screen", "focus the previous screen")),

            -- Standard program
    awful.key({ mod       }, "Return", function() awful.spawn(config.terminal) end,
        meta("launcher", "open a terminal")),

    -- Prompt
    awful.key({ mod       }, "r", function() awful.screen.focused().runprompt:run() end,
        meta("launcher", "run prompt")),

    -- Volume Keys
    awful.key({ mod       }, "XF86AudioMute", 
        function()
            volume("toggle", "Muted")
        end,
        meta("audio", "mute")),

    awful.key({ mod       }, "XF86AudioRaiseVolume", 
        function()
            volume("5%+", "Risen 5%")
        end,
        meta("audio", "raise volume")),

    awful.key({ mod       }, "XF86AudioLowerVolume", 
        function()
            volume("5%-", "Lowered 5%")
        end,
        meta("audio", "lower volume"))
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ mod            }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            meta("tag", "view tag #" .. i)),
        
        -- Toggle tag display.
        awful.key({ mod, ctrl      }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            meta("tag", "toggle tag #" .. i)),
        
        -- Move client to tag.
        awful.key({ mod, shft      }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            meta("tag", "move focused client to tag #" .. i)),
        
        -- Toggle tag on focused client.
        awful.key({ mod, ctrl, shft }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            meta("tag", "toggle focused client on tag #" .. i))
    )
end

return globalkeys
