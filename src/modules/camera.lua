local Camera = {}
Camera.__index = Camera

function Camera.new(x, y, scaleX, scaleY, rotation)
    local inst = {}
    setmetatable(inst, Camera)

    inst.x = x or 0
    inst.y = y or 0
    inst.scaleX = scaleX or 1
    inst.scaleY = scaleY or 1
    inst.rot = rotation or 0

    return inst

end

function Camera:update(dt, ...) -- Args: (dt, speed, stage, player)
    local args = {...}
    local speed = args[1][1]
    local stage = args[1][2]
    local player = args[1][3]
    local width, height, flags = love.window.getMode()
    if player.pos.y == self.y + height / 2 then
        if love.keyboard.isDown("down") then
            self:move(0, speed, stage)
        end
        if love.keyboard.isDown("up") then
            self:move(0, -speed, stage)
        end
    end
    if player.pos.x == self.x + width / 2 then
        if love.keyboard.isDown("left") then
            self:move(-speed, 0, stage)
        end
        if love.keyboard.isDown("right") then
            self:move(speed, 0, stage)
        end
    end
end

function Camera:set()
    love.graphics.push()
    love.graphics.rotate(-self.rot)
    love.graphics.scale(self.scaleX, self.scaleY)
    love.graphics.translate(-self.x, -self.y)
end

function Camera:unset()
  love.graphics.pop()
end

function Camera:move(dx, dy, stage)
    if self.x + dx > 0 and self.x + dx < stage.image:getWidth() then
        self.x = self.x + (dx or 0)
    else
        if self.x + dx <= 0 then
            self.x = 0
        elseif self.x + dx >= stage.image:getHeight() then
            self.x = stage.image:getWidth()
        end
    end
    if self.y + dy > 0 and self.y + dy < stage.image:getHeight() then
        self.y = self.y + (dy or 0)
    else
        if self.y + dy <= 0 then
            self.y = 0
        elseif self.y + dy >= stage.image:getHeight() then
            self.y = stage.image:getHeight()
        end
    end
end

function Camera:rotate(dr)
  self.rot = self.rot + dr
end

function Camera:scale(sx, sy)
    sx = sx or 1
    self.scaleX = self.scaleX * sx
    self.scaleY = self.scaleY * (sy or sx)
end

function Camera:setPosition(x, y)
    self.x = x or self.x
    self.y = y or self.y
end

function Camera:setScale(sx, sy)
    self.scaleX = sx or self.scaleX
    self.scaleY = sy or self.scaleY
end

return Camera
