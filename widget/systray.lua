local wibox = require('wibox')

return wibox { 
    widget = wibox.widget.systray(), 
    x = 560, 
    y = 480,
    width = 480,
    height = 60,
    visible = true
}
