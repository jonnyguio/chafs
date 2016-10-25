SS = require "modules.spritesheet"
Player = require "modules.player"
Stage = require "modules.stage"
Animation = require "modules.animation"
Animator = require "modules.animator"
Camera = require "modules.camera"
Scene = require "modules.scene"
local Initializer = require "initializer"

local heroSS, hero, heroAnimations, heroAnimator, heroStateMachine
local mainCamera
local controllers
local testScene, controllerScene
local stage1
local resize = 2

local currentScene, allScenes

--[[local ENUM_PS3BUTTONS = {
    SELECT = 1,
    L3 = 2,
    R3 = 3,
    START = 4,
    ARROW_UP = 5,
    ARROW_RIGHT = 6,
    ARROW_DOWN = 7,
    ARROW_LEFT = 8,
    L2 = 9,
    R2 = 10,
    L1 = 11,
    L2 = 12,
    TRIANGLE = 13,
    CIRCLE = 14,
    CROSS = 15,
    SQUARE = 16,
    PS = 17
}]]--

local ENUM_SCENES = {
    CONTROLLER_LOAD = 10,
    MAIN_MENU = 11,
    GAME = 12
}

local ENUM_DRAWORDER = {
    BACKGROUND = 1,
    MIDGROUND = 2,
    FOREGROUND = 3,
    SCENARIO = 4,
    CREATURES = 5
}

function love.load()
    mainCamera = Camera.new()

    local success = love.window.setMode(800, 600)

    ----- Carrega spritesheet, animações e stateMachine
    heroSS = SS.new("media/images/heroSpritesheet.png", 158, 654, 16, 16)
    heroAnimations = Initializer.loadHeroAnimations(heroSS, resize)

    ----- Carrega estágio
    stage1 = Stage.new("media/images/map2.jpg")
    stage1:resize(resize)

    ----- Carrega player
    hero = Player.new(heroSS, heroSS:createQuad(1, 5, resize), {x = 16 * resize * 5, y = 16 * resize * 5}, 2)
    heroStateMachine = Initializer.loadHeroStateMachine(hero)
    heroAnimator = Animator.new(heroAnimations, heroStateMachine)
    heroAnimator:attach(hero)
    heroAnimator:play()

    ----- Carrega cenas
    -- cena de controllers
    controllerScene = Scene.new(ENUM_SCENES.GAME)
    controllers = {}
    --[[controllerScene:addUpdateFunction(function()
        local joysticks = love.joystick.getJoysticks()
        for k in pairs (joysticks) do
            if k:isDown() then
            end
        end
    end)]]--

    -- cena teste
    testScene = Scene.new(ENUM_SCENES.GAME)
    testScene:addkeyboardpressedFunction(hero.keyboardpressed, hero) -- 2 = speed
    testScene:addkeyboardreleasedFunction(hero.keyboardreleased, hero) -- 2 = speed
    testScene:addUpdateFunction(mainCamera.update, mainCamera, {2, stage1, hero})
    testScene:addUpdateFunction(hero.update, hero, {})
    testScene:addDrawFunction(hero.draw, hero, {}, ENUM_DRAWORDER.CREATURES)
    testScene:addDrawFunction(stage1.draw, stage1, {}, ENUM_DRAWORDER.SCENARIO)
    testScene:addCamera(mainCamera, 1, 2)

end

function love.keypressed(key, scancode, isrepeat)
    if controllers.keyboard then
        testScene:keyboardpressed(key)
    end
end

function love.keyreleased(key, scancode, isrepeat)
    if controllers.keyboard then
        testScene:keyboardreleased(key)
    end
end

function love.gamepadpressed(joystick, key)
    for k, v in pairs(controllers) do
        if v.joystick == joystick then
            testScene:gamepadpressed(key)
        end
    end
end

function love.update(dt)
    testScene:update(dt)
    for k in pairs(love.joystick.getJoysticks()) do
    end
end

function love.draw()
    testScene:draw()
    --[[mainCamera:set()
    -- 1st layer
    stage1:draw()
    -- 2nd layer
    hero:draw()
    mainCamera:unset()]]--
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
