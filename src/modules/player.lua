local Player = {}
Player.__index = Player

function Player.new (spritesheet, mainSpriteQuad, pos, speed)
    local inst = {}
    setmetatable(inst, Player)

    inst.spritesheet = spritesheet
    inst.mainSpriteQuad = mainSpriteQuad
    inst.pos = pos
    inst.speed = {base = speed or 1, x = 0, y = 0}

    return inst
end

function Player:setSpeed(x, y)
    self.speed.x = x
    self.speed.y = y
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

function Player:gamepadpressed(...)

end

function Player:update(dt)
    self:move()
    if self:hasAttached() then
        self.animator:update(dt)
    end
end

function Player:move(x, y)
    self.pos.x = self.pos.x + (x or self.speed.x)
    self.pos.y = self.pos.y + (y or self.speed.y)
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
