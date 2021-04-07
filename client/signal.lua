local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local floattext_widget = wibox.widget {
        text = " floating",
        visible = false,
        widget = wibox.widget.textbox,
    }

    local title_template_widget = {
        {
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout = wibox.layout.flex.horizontal
    }

    local button_template_widget = {
        awful.titlebar.widget.stickybutton(c),
        awful.titlebar.widget.minimizebutton(c),
        awful.titlebar.widget.closebutton(c),

        layout = wibox.layout.fixed.horizontal
    }

    local titlebar = awful.titlebar(c, {
        font = beautiful.titlebar_font or beautiful.font,
        position = beautiful.titlebar_position
    })

    titlebar:setup {
        floattext_widget,
        title_template_widget,
        button_template_widget,
        layout = wibox.layout.align.horizontal
    }

    c:connect_signal("property::floating", function(is_floating)
        floattext_widget.visible = not floattext_widget.visible
    end)
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
