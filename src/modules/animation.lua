local Animation = {}
Animation.__index = Animation

function counter()
    local i = 0
    return function()
        i = i + 1
        return i
    end
end

local totalAnimations = counter()

function Animation.new(spritesheet, frames, name)
    local inst = {}
    setmetatable(inst, Animation)

    if (type(frames) ~= "table") then
        error("Frames must be a table containing each quadrant of a spritesheet.")
        return {}
    end

    inst.spritesheet = spritesheet
    inst.frames = frames
    inst.name = name or "Animation" .. totalAnimations()
    inst.currentFrame = 1
    inst.elapsed = 0
    inst.delay = 0.1

    return inst
end

function Animation:update(dt, isPlaying)
    if not isPlaying then return end
    self.elapsed = self.elapsed + dt
    if self.elapsed >= self.delay then
        self.elapsed = self.elapsed - self.delay
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > #self.frames then
            self.currentFrame = 1
        end
    end
end

function Animation:draw(x, y)
    local currentFrame = self.frames[self.currentFrame]
    love.graphics.draw(self.spritesheet.image, currentFrame.quad, x + currentFrame.addX, y + currentFrame.addY, currentFrame.rot, currentFrame.flipX, currentFrame.flipY)
end

function Animation:reset()
    self.currentFrame = 1
    self.elapsed = 0
end

return Animation
