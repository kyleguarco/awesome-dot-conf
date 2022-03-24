-- keys/globalbuttons.lua (local scope)
-- Initializes mouse functionality
local awful = require('awful')

-- Modifiers
local modkeys = require("keys.modkey")
local mod = modkeys.m

awful.mouse.append_global_mousebindings {
    awful.button({ mod }, 4, awful.tag.viewnext),
    awful.button({ mod }, 5, awful.tag.viewprev)
}
