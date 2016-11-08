local Creature = require "modules.creature"
local Vector = require "library.vector"

local Monster = Creature:new()
Monster.__index = Monster

function Monster.new(spritesheet, mainSpriteQuad, pos, speed, life)
    local inst = Creature.new(spritesheet, mainSpriteQuad, pos, speed)

    setmetatable(inst, Monster)
    inst.life = life
    inst.alive = true

    return inst
end

function Monster:update(dt, ...)
    local args = {...}
    local player = args[1][1]
    if self.life == 0 then
        self.alive = false
        print("monstro morreu")
    end
    self:move()
    if self.alive then
        local dist = Vector.dist(player.pos, self.pos)
        if dist < 200 then
            self:setSpeed((player.pos.x - self.pos.x) / dist * self.speed.base, (player.pos.y - self.pos.y) / dist * self.speed.base)
        else
            self:setSpeed(0, 0)
        end
    end
end

return Monster
