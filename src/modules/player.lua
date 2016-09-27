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

function Player:update()

end

function Player:draw()
    love.graphics.draw(self.spritesheet.image, self.mainSpriteQuad, self.pos.x, self.pos.y)
end

return Player
