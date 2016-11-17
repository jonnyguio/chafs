SS = require "modules.spritesheet"
Player = require "modules.player"
Monster = require "modules.monster"
Stage = require "modules.stage"
Animation = require "modules.animation"
Animator = require "modules.animator"
Camera = require "modules.camera"
Scene = require "modules.scene"
Transition = require "modules.transition"
local Initializer = require "initializer"

require "enum"

-- Global Variables

runningScene = {}
icon = {}

-- Local Variables

local heroSS, hero, heroAnimations, heroAnimator, heroStateMachine
local monster1, monsterSS
local mainCamera
local controllers
local testScene, controllersScene
local stage1
local resize = 2

local currentScene, allScenes

function love.load()
    mainCamera = Camera.new()

    local success = love.window.setMode(800, 600)

    icon.gamepad = love.graphics.newImage("media/images/gamepad.png")
    icon.keyboard = love.graphics.newImage("media/images/keyboard.png")
    controllers = {}

    ----- Carrega spritesheet, animações e stateMachine
    heroSS = SS.new("media/images/heroine.jpg", 128, 128, 32, 32)
    heroAnimations = Initializer.loadHeroAnimations(heroSS, 1)
    monsterSS = SS.new("media/images/enemies.png", 425, 503, 16, 16)

    ----- Carrega estágio
    stage1 = Stage.new("media/images/map2.jpg")
    stage1:resize(resize)

    ----- Carrega player
    hero = Player.new(heroSS, heroSS:createQuad(1, 5, 1), {x = 32 * 5, y = 32 * 5}, 2)
    heroStateMachine = Initializer.loadHeroStateMachine(hero)
    heroAnimator = Animator.new(heroAnimations, heroStateMachine)
    heroAnimator:attach(hero)
    heroAnimator:play()
    monster1 = Monster.new(monsterSS, monsterSS:createQuad(1, 1, resize), {x = 32 * 14, y = 32 * 5}, 1.5, 4)

    ----- Carrega cenas
    controllersScene = Scene.new(ENUM_SCENES.CONTROLLER_LOAD)
    testScene = Scene.new(ENUM_SCENES.TEST)
    -- cena de controllers

    controllersScene:addkeyboardpressedFunction(function(self, key, ...)
        local args = {...}
        local _controllers = args[1][1]
        local newScene = args[1][2]
        local duration = args[1][3]

        if self.transitioning then return end

        for k, v in pairs(_controllers) do
            if v ~= _controllers.keyboard then
                print("Joystick " .. v:getID() .. " has left the game")
                table.remove(_controllers, k)
            end
        end
        if key == "space" then
            if not _controllers.keyboard then
                print("Keyboard entered the game")
                _controllers.keyboard = true
            end
        elseif key == "enter" or key == "return" then
            if _controllers.keyboard then
                Transition.black(self, newScene, duration)
            end
        end
    end, controllersScene, {controllers, testScene, 1})

    controllersScene:addgamepadpressedFunction(function(self, joystick, key, ...)
        local args = {...}
        local _controllers = args[1][1]
        local newScene = args[1][2]
        local duration = args[1][3]

        if self.transitioning then return end

        if key == "a" then
            for k, v in pairs(_controllers) do
                if v == joystick then
                    return
                end
            end
            _controllers.keyboard = false
            print("Joystick " .. joystick:getID() .. " entered the game.")
            table.insert(_controllers, joystick)
        elseif key == "start" then
            Transition.black(self, newScene, duration)
        end
    end, controllersScene, {controllers, testScene, 1})

    controllersScene:addDrawFunction(function(self, ...)
        local args = {...}
        local _controllers = args[1][1]
        local icons = args[1][2]
        local r, g, b, a = love.graphics.getColor()
        love.graphics.setColor(70, 130, 180, 255)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(r, g, b, a)

        if _controllers.keyboard then
            love.graphics.draw(icons.keyboard, love.graphics.getWidth() / 2 - icons.keyboard:getWidth() / 2, love.graphics.getHeight() / 2 - icons.keyboard:getHeight() / 2)
        else
            for k, v in pairs(_controllers) do
                love.graphics.draw(icons.gamepad, love.graphics.getWidth() / 2 - icons.gamepad:getWidth() / 2, love.graphics.getHeight() / 2 - icons.gamepad:getHeight() / 2)
            end
        end
    end, controllersScene, {controllers, icon}, ENUM_DRAWORDER.FOREGROUND)

    -- cena teste
    testScene:addkeyboardpressedFunction(hero.keyboardpressed, hero) -- 2 = speed
    testScene:addkeyboardreleasedFunction(hero.keyboardreleased, hero) -- 2 = speed
    testScene:addgamepadpressedFunction(hero.gamepadpressed, hero)
    testScene:addgamepadreleasedFunction(hero.gamepadreleased, hero)
    testScene:addUpdateFunction(mainCamera.update, mainCamera, {2, stage1, hero})
    testScene:addUpdateFunction(hero.update, hero, {})
    testScene:addUpdateFunction(monster1.update, monster1, {hero})
    testScene:addDrawFunction(hero.draw, hero, {}, ENUM_DRAWORDER.CREATURES)
    testScene:addDrawFunction(stage1.draw, stage1, {}, ENUM_DRAWORDER.SCENARIO)
    testScene:addDrawFunction(monster1.draw, monster1, {hero}, ENUM_DRAWORDER.CREATURES)
    testScene:addCamera(mainCamera, 1, 3)

    runningScene = ENUM_SCENES.CONTROLLER_LOAD
end

function love.keypressed(key, scancode, isrepeat)
    if runningScene == ENUM_SCENES.CONTROLLER_LOAD then
        controllersScene:keyboardpressed(key)
    elseif runningScene == ENUM_SCENES.TEST then
        if controllers.keyboard then
            testScene:keyboardpressed(key)
        end
    end
end

function love.keyreleased(key, scancode, isrepeat)
    if runningScene == ENUM_SCENES.CONTROLLER_LOAD then
        controllersScene:keyboardreleased(key)
    elseif runningScene == ENUM_SCENES.TEST then
        if controllers.keyboard then
            testScene:keyboardreleased(key)
        end
    end
end

function love.gamepadpressed(joystick, key)
    if runningScene == ENUM_SCENES.CONTROLLER_LOAD then
        controllersScene:gamepadpressed(joystick, key)
    elseif runningScene == ENUM_SCENES.TEST then
        for k, v in pairs(controllers) do
            if v ~= controllers.keyboard and v == joystick then
                testScene:gamepadpressed(joystick, key)
            end
        end
    end
end

function love.gamepadreleased(joystick, key)
    if runningScene == ENUM_SCENES.CONTROLLER_LOAD then
        controllersScene:gamepadreleased(joystick, key)
    elseif runningScene == ENUM_SCENES.TEST then
        for k, v in pairs(controllers) do
            if v ~= controllers.keyboard and v == joystick then
                testScene:gamepadreleased(joystick, key)
            end
        end
    end
end

function love.update(dt)
    if runningScene == ENUM_SCENES.CONTROLLER_LOAD then
        controllersScene:update(dt)
    elseif runningScene == ENUM_SCENES.TEST then
        testScene:update(dt)
    end
end

function love.draw()
    love.graphics.clear()
    if runningScene == ENUM_SCENES.CONTROLLER_LOAD then
        controllersScene:draw()
    elseif runningScene == ENUM_SCENES.TEST then
        testScene:draw()
    end
end

function love.quit()

end
