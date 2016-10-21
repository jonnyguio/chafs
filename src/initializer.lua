local Initializer = {}

local function createStateMachine(conditions)
    local ret = {}
    for i = 1, #conditions do
        ret[i] = {}
        ret[i].condition = conditions[i]
    end
    return ret
end

function Initializer.loadHeroStateMachine()
    return createStateMachine({
        [1] = function ()
            if love.keyboard.isDown("down") then
                return 2
            elseif love.keyboard.isDown("left") then
                return 4
            elseif love.keyboard.isDown("up") then
                return 5
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
            elseif love.keyboard.isDown("up") then
                return 5
            end
            return false
        end,
        [4] = function ()
            if not love.keyboard.isDown("left") then
                return 3
            end
            return false
        end,
        [5] = function ()
            if not love.keyboard.isDown("up") then
                return 6
            end
            return false
        end,
        [6] = function ()
            if love.keyboard.isDown("down") then
                return 2
            elseif love.keyboard.isDown("left") then
                return 4
            elseif love.keyboard.isDown("up") then
                return 5
            end
        end
    })
end

function Initializer.loadHeroAnimations(_HeroSS, resize)
    t_HeroAnimations = {}
    if type(_HeroSS) ~= "table" then
        error("_HeroSS is not a table.")
    end
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 1, resize)
        }, "stand", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 1, resize, -1),
            _HeroSS:createQuad(1, 1, resize),
            --_HeroSS:createQuad(1, 5, resize, -1),
            --_HeroSS:createQuad(1, 5, resize),
        }, "walkDown", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 3, resize),
        }, "standLeft", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 3, resize),
            _HeroSS:createQuad(1, 4, resize),
        }, "walkLeft", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 2, resize),
            _HeroSS:createQuad(1, 2, resize, -1),
        }, "walkUp", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 2, resize)
        }, "standUp", 0.08)
    )
    return t_HeroAnimations
end

return Initializer
