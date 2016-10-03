local Stage = {}
Stage.__index = Stage

function Stage.new(filename)
    local inst = {}
    setmetatable(inst, Stage)

    inst.image = love.graphics.newImage(filename)
    inst.width = inst.image:getWidth()
    inst.height = inst.image:getHeight()
    inst.quad = love.graphics.newQuad(1, 1, inst.width, inst.height, inst.width, inst.height)

    return inst
end

function Stage:resize(resize)
    self.quad = love.graphics.newQuad(1, 1, self.width * resize, self.height * resize, self.width * resize, self.height * resize)
end

function Stage:draw()
    love.graphics.draw(self.image, self.quad, 1, 1)
    --love.graphics.draw(self.image, self.quad, 0 - self.width / 2, 0 - self.height / 2)
end

return Stage
