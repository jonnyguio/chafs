local Creature = {}
Creature.__index = Creature

function Creature.new (spritesheet, mainSpriteQuad, pos, speed)
    local inst = {}
    setmetatable(inst, Creature)

    inst.spritesheet = spritesheet
    inst.mainSpriteQuad = mainSpriteQuad
    inst.pos = pos
    inst.speed = {base = speed or 1, x = 0, y = 0}

    return inst
end

function Creature:setSpeed(x, y)
    self.speed.x = x
    self.speed.y = y
end

function Creature:move(x, y)
    self.pos.x = self.pos.x + (x or self.speed.x)
    self.pos.y = self.pos.y + (y or self.speed.y)
end

function Creature:hasAttached()
    return self.animator and true
end

function Creature:draw()
    if self:hasAttached() then
        self.animator:draw(self.pos.x, self.pos.y)
    else
        --  print("printing creature")
        love.graphics.draw(self.spritesheet.image, self.mainSpriteQuad.quad, self.pos.x, self.pos.y, self.mainSpriteQuad.rot, self.mainSpriteQuad.flipX, self.mainSpriteQuad.flipY)
    end
end

return Creature
