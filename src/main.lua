SS = require "modules.spritesheet"
Player = require "modules.player"
Stage = require "modules.stage"
Animation = require "modules.animation"
Animator = require "modules.animator"
Camera = require "modules.camera"
Scene = require "modules.scene"
local Initializer = require "initializer"

local heroSS, hero, stage1, heroAnimations, heroAnimator, heroStateMachine, mainCamera, testScene, controllerScene
local resize = 2

local currentScene, allScenes

local ENUM_SCENES = {
    CONTROLLER_LOAD = 10,
    MAIN_MENU = 11,
    GAME = 12
}

function love.load()
    local joysticks = love.joystick.getJoysticks()

    mainCamera = Camera.new()

    local success = love.window.setMode(800, 600)

    -- Carrega spritesheet, animações e stateMachine
    heroSS = SS.new("media/images/heroSpritesheet.png", 158, 654, 16, 16)
    heroAnimations = Initializer.loadHeroAnimations(heroSS, resize)
    heroStateMachine = Initializer.loadHeroStateMachine()
    heroAnimator = Animator.new(heroAnimations, heroStateMachine)

    -- Carrega estágio
    stage1 = Stage.new("media/images/map2.jpg")
    stage1:resize(resize)

    -- Carrega player
    hero = Player.new(heroSS, heroSS:createQuad(1, 5, resize), {x = 16 * resize * 5, y = 16 * resize * 5})
    heroAnimator:attach(hero)
    heroAnimator:play()

    -- Carrega cenas
    controllerScene = Scene.new(ENUM_SCENES.GAME)
    controllerScene:

    testScene = Scene.new(ENUM_SCENES.GAME)
    testScene:addFunctionUpdate(mainCamera.update, mainCamera, {2, stage1, hero})
    testScene:addFunctionUpdate(hero.update, hero, {2})
end

function love.update(dt)
    testScene:update(dt)
end

function love.draw()
    mainCamera:set()
    -- 1st layer
    stage1:draw()
    -- 2nd layer
    hero:draw()
    mainCamera:unset()
    --[[for i, joystick in ipairs(joysticks) do
        love.graphics.print(joystick:getName(), 10, i * 20)
        love.graphics.print("Number of axis: " .. joystick:getAxisCount(), 15, i * 35)
        for k = 1, joystick:getAxisCount() do
            love.graphics.print("axis" .. k .. " - " .. joystick:getAxis(k), 20 + (k - 1) * 200, i * 50)
        end
    end]]--
end

function love.quit()

end
