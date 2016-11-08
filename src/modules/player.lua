local Creature = require "modules.creature"

local Player = Creature:new()
Player.__index = Player

function Player.new(spritesheet, mainSpriteQuad, pos, speed)
    local inst = Creature.new(spritesheet, mainSpriteQuad, pos, speed)
    setmetatable(inst, Player)

    return inst
end

function Player:keyboardpressed(key, ...) -- Args : {speed}
    local args = {...}
    if key == "down" then
        self:setSpeed(self.speed.x, self.speed.y + self.speed.base)
    elseif key == "up" then
        self:setSpeed(self.speed.x, self.speed.y - self.speed.base)
    elseif key == "left" then
        self:setSpeed(self.speed.x - self.speed.base, self.speed.y)
    elseif key == "right" then
        self:setSpeed(self.speed.x + self.speed.base, self.speed.y)
    end
end

function Player:keyboardreleased(key, ...)
    local args = {...}
    if key == "down" then
        self:setSpeed(self.speed.x, self.speed.y - self.speed.base)
    elseif key == "up" then
        self:setSpeed(self.speed.x, self.speed.y + self.speed.base)
    elseif key == "left" then
        self:setSpeed(self.speed.x + self.speed.base, self.speed.y)
    elseif key == "right" then
        self:setSpeed(self.speed.x - self.speed.base, self.speed.y)
    end
end

function Player:gamepadpressed(joystick, key, ...)
    if key == "dpdown" then
        self:setSpeed(self.speed.x, self.speed.y + self.speed.base)
    elseif key == "dpup" then
        self:setSpeed(self.speed.x, self.speed.y - self.speed.base)
    elseif key == "dpleft" then
        self:setSpeed(self.speed.x - self.speed.base, self.speed.y)
    elseif key == "dpright" then
        self:setSpeed(self.speed.x + self.speed.base, self.speed.y)
    end
end

function Player:gamepadreleased(joystick, key, ...)
    if key == "dpdown" then
        self:setSpeed(self.speed.x, self.speed.y - self.speed.base)
    elseif key == "dpup" then
        self:setSpeed(self.speed.x, self.speed.y + self.speed.base)
    elseif key == "dpleft" then
        self:setSpeed(self.speed.x + self.speed.base, self.speed.y)
    elseif key == "dpright" then
        self:setSpeed(self.speed.x - self.speed.base, self.speed.y)
    end
end

function Player:update(dt)
    self:move()
    if self:hasAttached() then
        self.animator:update(dt)
    end
end

return Player
