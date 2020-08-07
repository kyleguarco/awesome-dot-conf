local awful = require('awful')
local gears = require('gears')
local naughty = require('naughty')
local hotkeys_popup = require('awful.hotkeys_popup')

-- Modifiers
local mod, alt, ctrl, shft = config.modkey.m, config.modkey.a, config.modkey.c, config.modkey.s

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

local function volume(action)
    awful.spawn.with_shell("amixer set Master " .. action)
    notify("volume " .. action)
end

local function brightness(value)
    --awful.spawn.with_shell("xbacklight -inc " .. value)
    notify("brightness " .. value)
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
        meta("client-g", "restore minimized")),
    
    awful.key({ mod, ctrl }, "z", function() awful.spawn("rofi -show window -show-icons") end,
        meta("client-g", "Show the rofi window switcher")),
    
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
    awful.key({ mod       }, "r", function() awful.spawn("rofi -show drun -show-icons") end,
        meta("launcher", "rofi run prompt")),

    -- HUD
    --awful.key({ mod       }, "v", function() awful.screen.focused().tasklist:popup() end,
    --  meta("screen", "show hud")),

    -- Volume Keys

    awful.key({           }, "XF86AudioRaiseVolume", function() volume("5%+") end,
        meta("audio", "raise volume")),

    awful.key({           }, "XF86AudioLowerVolume", function() volume("5%-") end,
        meta("audio", "lower volume")),
    
    awful.key({           }, "XF86AudioMute", function() volume("toggle") end,
        meta("audio", "mute")),
    
    -- Brightness Keys

    -- WARNING: A dirty fix was implemented for this. Refer to this forum
    -- for more info: https://unix.stackexchange.com/a/482413/248296

    -- xf86-video-intel was also installed for this functionality.
    
    awful.key({           }, "XF86MonBrightnessUp", function() brightness("2.5") end,
    meta("display", "increase brightness")),
    
    awful.key({           }, "XF86MonBrightnessDown", function() brightness("-2.5") end,
    meta("display", "decrease brightness"))
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 4 do
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
            meta("tag", "toggle focused client on tag #" .. i)),

        -- Move client to tag.
        awful.key({ mod, alt      }, "#" .. i + 9,
            function()
                if client.focus then
                    local screen = screen[i]
                    if screen then
                        client.focus:move_to_screen(i)
                    end
                end
            end,
            meta("screen", "move focused client to screen #" .. i))
    )
end

return globalkeys
