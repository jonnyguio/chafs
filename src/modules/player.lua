local Player = {}
Player.__index = Player

function Player.new (spritesheet, mainSpriteQuad, pos)
    local inst = {}
    setmetatable(inst, Player)

    inst.spritesheet = spritesheet
    inst.mainSpriteQuad = mainSpriteQuad
    inst.pos = pos

    return inst
end

function Player:update(dt)
    if self:hasAttached() then
        self.animator:update(dt)
    end
end

function Player:hasAttached()
    return self.animator and true
end

function Player:draw()
    if self:hasAttached() then
        self.animator:draw(self.pos.x, self.pos.y)
    else
        love.graphics.draw(self.spritesheet.image, self.mainSpriteQuad.quad, self.pos.x, self.pos.y, self.mainSpriteQuad.rot, self.mainSpriteQuad.flipX, self.mainSpriteQuad.flipY)
    end
end

return Player
