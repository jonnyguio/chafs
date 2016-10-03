local SS = require "modules.spritesheet"
local Player = require "modules.player"
local Stage = require "modules.stage"
local Animation = require "modules.animation"
local Animator = require "modules.animator"
local Camera = require "modules.camera"

local heroSS, hero, stage1, heroAnimations, heroAnimator, mainCamera
local resize = 2

function createStateMachine(conditions)
    local ret = {}
    for i = 1, #conditions do
        ret[i] = {}
        ret[i].condition = conditions[i]
    end
    return ret
end

function love.load()
    mainCamera = Camera.new()

    heroAnimations = {}
    local success = love.window.setMode( 16 * resize * 20, 16 * resize * 20)

    heroSS = SS.new("media/images/heroSpritesheet.png", 158, 654, 16, 16)
    table.insert(
        heroAnimations,
        Animation.new(heroSS, {
            heroSS:createQuad(1, 5, resize)
        }, "stand")
    )
    table.insert(
        heroAnimations,
        Animation.new(heroSS, {
            heroSS:createQuad(1, 1, resize),
            heroSS:createQuad(1, 5, resize, -1),
            heroSS:createQuad(1, 1, resize, -1),
            heroSS:createQuad(1, 5, resize),
        }, "walkDown")
    )
    table.insert(
        heroAnimations,
        Animation.new(heroSS, {
            heroSS:createQuad(1, 3, resize),
        }, "standLeft")
    )
    table.insert(
        heroAnimations,
        Animation.new(heroSS, {
            heroSS:createQuad(1, 3, resize),
            heroSS:createQuad(1, 4, resize),
        }, "walkLeft")
    )
    table.insert(
        heroAnimations,
        Animation.new(heroSS, {
            heroSS:createQuad(1, 2, resize),
            heroSS:createQuad(1, 2, resize, -1),
        }, "walkUp")
    )

    heroAnimator = Animator.new(heroAnimations,
        createStateMachine({
            [1] = function ()
                if love.keyboard.isDown("down") then
                    return 2
                elseif love.keyboard.isDown("left") then
                    return 4
                end
                return false
            end,
            [2] = function ()
                if not love.keyboard.isDown("down") then
                    return 1
                end
                return false
            end,
            [3] = function ()
                if love.keyboard.isDown("down") then
                    return 2
                elseif love.keyboard.isDown("left") then
                    return 4
                end
                return false
            end,
            [4] = function ()
                if not love.keyboard.isDown("left") then
                    return 3
                end
                return false
            end
        })
    )

    stage1 = Stage.new("media/images/map2.jpg")
    stage1:resize(resize)

    hero = Player.new(heroSS, heroSS:createQuad(1, 5, resize), {x = 16 * resize * 5, y = 16 * resize * 5})
    heroAnimator:attach(hero)
    heroAnimator:play()
end

function love.update(dt)
    mainCamera:update(dt, 1 / dt * 2, stage1, hero)
    hero:update(dt, 1 / dt * 2)
end

function love.draw()
    mainCamera:set()
    -- 1st layer
    stage1:draw()
    -- 2nd layer
    hero:draw()
    mainCamera:unset()
end

function love.quit()

end
