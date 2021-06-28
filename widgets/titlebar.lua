local awful = require('awful')
local gears = require('gears')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- `c`: A client
local _titlebar_buttons_new = require("keys.titlebarbuttons")

return function(c)
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
        buttons = _titlebar_buttons_new(c),
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

    c:connect_signal("property::floating", function()
        floattext_widget.visible = c.floating
    end)

	return titlebar
end
