local SpriteSheet = {}
SpriteSheet.__index = SpriteSheet

function SpriteSheet.new(filename, widthT, heightT, widthP, heightP)
    local inst = {}
    setmetatable(inst, SpriteSheet)

    inst.image = love.graphics.newImage(filename)
    inst.widthT = widthT
    inst.widthP = widthT
    inst.heightT = heightT
    inst.heightP = heightP

    return inst
end

function SpriteSheet:createQuad(line, column)
    return love.graphics.newQuad((column - 1) * 16 + column, (line - 1) * 16 + line, self.widthP, self.heightP, self.widthT, self.heightT)
end

return SpriteSheet
