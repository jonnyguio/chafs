-- Requiring classes
local Player = require "modules.player"

--[[
Variables used on main declared to manage space, and don't lose track of variable creation (also control scoping)
]]

-- Variables
    --[[ Control Time Variables]]
    local t

    --[[ World variables]]
    local world = {}
    local p

-- Function responsible to load/initialize components
function love.load()
    t = 0
    local controller = love.joystick.getJoysticks()
    p = Player.new(world, controller[1], 0, 0)
end

-- Function responsible for updating world
function love.update(deltatime)
    t = t + deltatime

end

-- Function responsible for all draw actions
function love.draw()

end
-- End of program
function love.quit()

end
