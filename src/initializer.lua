local Initializer = {}

local function createStateMachine(conditions)
    local ret = {}
    for i = 1, #conditions do
        ret[i] = {}
        ret[i].condition = conditions[i]
    end
    return ret
end


function Initializer.loadHeroStateMachine(_hero)
    local ENUM_STATES = {
        STANDDOWN = 1,
        WALKDOWN = 2,
        STANDUP = 3,
        WALKUP = 4,
        STANDLEFT = 5,
        WALKLEFT = 6,
        STANDRIGHT = 7,
        WALKRIGHT = 8
    }
    local hero = _hero
    return createStateMachine({
        [1] = function () -- standDown
            if hero.speed.y < 0 then
                return ENUM_STATES.WALKUP
            elseif hero.speed.y > 0 then
                return ENUM_STATES.WALKDOWN
            else
                if hero.speed.x < 0 then
                    return ENUM_STATES.WALKLEFT
                elseif hero.speed.x > 0 then
                    return ENUM_STATES.WALKRIGHT
                end
            end
            return false
        end,
        [2] = function () -- moveDown
            if hero.speed.y <= 0 then
                if hero.speed.x < 0 then
                    return ENUM_STATES.WALKLEFT
                elseif hero.speed.x > 0 then
                    return ENUM_STATES.WALKRIGHT
                end
                return ENUM_STATES.STANDDOWN
            end
            return false
        end,
        [3] = function ()
            if hero.speed.y < 0 then
                return ENUM_STATES.WALKUP
            elseif hero.speed.y > 0 then
                return ENUM_STATES.WALKDOWN
            else
                if hero.speed.x < 0 then
                    return ENUM_STATES.WALKLEFT
                elseif hero.speed.x > 0 then
                    return ENUM_STATES.WALKRIGHT
                end
            end
            return false
        end,
        [4] = function ()
            if hero.speed.y >= 0 then
                if hero.speed.x < 0 then
                    return ENUM_STATES.WALKLEFT
                elseif hero.speed.x > 0 then
                    return ENUM_STATES.WALKRIGHT
                end
                return ENUM_STATES.STANDUP
            end
            return false
        end,
        [5] = function ()
            if hero.speed.x < 0 then
                return ENUM_STATES.WALKLEFT
            elseif hero.speed.x > 0 then
                return ENUM_STATES.WALKRIGHT
            else
                if hero.speed.y < 0 then
                    return ENUM_STATES.WALKDOWN
                elseif hero.speed.y > 0 then
                    return ENUM_STATES.WALKUP
                end
            end
            return false
        end,
        [6] = function ()
            if hero.speed.x >= 0 then
                if hero.speed.y < 0 then
                    return ENUM_STATES.WALKUP
                elseif hero.speed.y > 0 then
                    return ENUM_STATES.WALKDOWN
                end
                return ENUM_STATES.STANDLEFT
            end
            return false
        end,
        [7] = function()
            if hero.speed.x < 0 then
                return ENUM_STATES.WALKLEFT
            elseif hero.speed.x > 0 then
                return ENUM_STATES.WALKRIGHT
            else
                if hero.speed.y < 0 then
                    return ENUM_STATES.WALKDOWN
                elseif hero.speed.y > 0 then
                    return ENUM_STATES.WALKUP
                end
            end
            return false
        end,
        [8] = function()
            if hero.speed.x <= 0 then
                if hero.speed.y < 0 then
                    return ENUM_STATES.WALKUP
                elseif hero.speed.y > 0 then
                    return ENUM_STATES.WALKDOWN
                end
                return ENUM_STATES.STANDRIGHT
            end
            return false
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
        }, "standDown", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 1, resize),
            _HeroSS:createQuad(2, 1, resize),
            _HeroSS:createQuad(3, 1, resize),
            _HeroSS:createQuad(4, 1, resize)
            --_HeroSS:createQuad(1, 5, resize, -1),
            --_HeroSS:createQuad(1, 5, resize),
        }, "walkDown", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 2, resize)
        }, "standUp", 0.08)
    )

    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 2, resize),
            _HeroSS:createQuad(2, 2, resize),
            _HeroSS:createQuad(3, 2, resize),
            _HeroSS:createQuad(4, 2, resize)
        }, "walkUp", 0.08)
    )

    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 4, resize),
        }, "standLeft", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 4, resize),
            _HeroSS:createQuad(2, 4, resize),
            _HeroSS:createQuad(3, 4, resize),
            _HeroSS:createQuad(4, 4, resize)
        }, "walkLeft", 0.08)
    )

    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 3, resize)
        }, "standRight", 0.08)
    )
    table.insert(
        t_HeroAnimations,
        Animation.new(_HeroSS, {
            _HeroSS:createQuad(1, 3, resize),
            _HeroSS:createQuad(2, 3, resize),
            _HeroSS:createQuad(3, 3, resize),
            _HeroSS:createQuad(4, 3, resize)
        }, "walkRight", 0.08)
    )
    return t_HeroAnimations
end

return Initializer
