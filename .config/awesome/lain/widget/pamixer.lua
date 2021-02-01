--[[

     Licensed under GNU General Public License v2

--]]

local helpers = require("lain.helpers")
local shell   = require("awful.util").shell
local wibox   = require("wibox")
local string  = string

-- PAMIXER volume
-- lain.widget.pamixer

local function factory(args)
    local pamixer  = { widget = wibox.widget.textbox() }
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    pamixer.cmd           = args.cmd or "pamixer --get-mute ; pamixer --get-volume"

    local format_cmd = string.format("%s", pamixer.cmd)

    pamixer.last = {}

    function pamixer.update()
        helpers.async(format_cmd, function(res)
			s = string.match(res, "%a+")
			v = string.match(res, "%d+")
			volume_now = { level = v, muted = s }
			widget = pamixer.widget
			settings()
			pamixer.last = volume_now
        end)
    end

    helpers.newtimer(string.format("pamixer-%s", pamixer.cmd), timeout, pamixer.update)

    return pamixer
end

return factory
