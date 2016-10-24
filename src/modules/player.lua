local Player = {}
Player.__index = Player

function Player.new (spritesheet, mainSpriteQuad, pos)
    local inst = {}
    setmetatable(inst, Player)

    inst.spritesheet = spritesheet
    inst.mainSpriteQuad = mainSpriteQuad
    inst.pos = pos
    inst.speedx = 0
    inst.speedy = 0

    return inst
end

function Player:setSpeed(x, y)
    self.speedx = x
    self.speedy = y
end

function Player:keyboardpressed(dt, ...) -- Args : {speed}
    local args = {...}
    local speed = args[1][1]
    if love.keyboard.isDown("down") then
        self:setSpeed(0, speed)
    end
    if love.keyboard.isDown("up") then
        self:setSpeed(0, -speed)
    end
    if love.keyboard.isDown("left") then
        self:setSpeed(-speed, 0)
    end
    if love.keyboard.isDown("right") then
        self:setSpeed(speed, 0)
    end
end

function Player:gamepadpressed(dt, ...)

end

function Player:update(dt)
    self:move()
    if self:hasAttached() then
        self.animator:update(dt)
    end
end

function Player:move(x, y)
    self.pos.x = self.pos.x + (x or self.speedx)
    self.pos.y = self.pos.y + (y or self.speedy)
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
