SS = require "modules.spritesheet"
Player = require "modules.player"

local heroSS, hero

function love.load()
    heroSS = SS.new("media/images/heroSpritesheet.png", 158, 654, 16, 16)
    heroStandQuad = heroSS:createQuad(1,1)
    hero = Player.new(heroSS, heroStandQuad, {x = 100, y = 100})
end

function love.update(dt)
    hero:update(dt)
end

function love.draw()
    hero:draw()
end

function love.quit()

end
