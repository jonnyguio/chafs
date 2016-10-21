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

function Player:update(dt, ...) -- Args : {speed}
    local args = {...}
    local speed = args[1][1]
    if love.keyboard.isDown("down") then
        self:move(0, speed)
    end
    if love.keyboard.isDown("up") then
        self:move(0, -speed)
    end
    if love.keyboard.isDown("left") then
        self:move(-speed, 0)
    end
    if love.keyboard.isDown("right") then
        self:move(speed, 0)
    end
    if self:hasAttached() then
        self.animator:update(dt)
    end
end

function Player:move(x, y)
    self.pos.x = self.pos.x + (x or 0)
    self.pos.y = self.pos.y + (y or 0)
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
