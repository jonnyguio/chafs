local SpriteSheet = {}
SpriteSheet.__index = SpriteSheet

function SpriteSheet.new(filename, widthT, heightT, widthP, heightP)
    local inst = {}
    setmetatable(inst, SpriteSheet)

    inst.image = love.graphics.newImage(filename)
    inst.widthT = widthT
    inst.widthP = widthP
    inst.heightT = heightT
    inst.heightP = heightP

    return inst
end

function SpriteSheet:createQuad(line, column, resize, flipX, flipY, rotation)
    local ret = {}
    ret.quad = love.graphics.newQuad(((column - 1) * self.widthP + column) * (resize or 1), ((line - 1) * self.heightP + line) * (resize or 1), self.widthP * (resize or 1), self.heightP * (resize or 1), self.widthT * (resize or 1), self.heightT * (resize or 1))
    ret.flipX = flipX or 1
    ret.flipY = flipY or 1
    ret.rotation = rotation or 0
    if ret.flipX == -1 then
        ret.addX = self.widthP * resize
    else
        ret.addX = 0
    end

    if ret.flipY == -1 then
        ret.addY = self.heightP * resize
    else
        ret.addY = 0
    end
    return ret
end

return SpriteSheet
