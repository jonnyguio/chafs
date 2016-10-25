local Transition = {}
Transition.__index = Transition

function Transition.new(oldScene, newScene)
end

function Transition.black(oldScene, newScene, duration)
    local r, g, b = love.graphics.getColor()
    local a = 0
    local dur = duration
    oldScene.transitioning = true
    newScene.transitioning = true
    oldScene:addUpdateFunction(
        function(self, dt)
            if a <= 255 then
                a = a + 255 / dur * dt
            else
                a = 255
                runningScene = newScene.index
                oldScene.transitioning = false
            end
        end
    )
    oldScene:addDrawFunction(
        function()
            local r, g, b, alpha = love.graphics.getColor()
            love.graphics.setColor(0, 0, 0, a)
            love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(r, g, b, alpha)
        end
    )
    newScene:addUpdateFunction(
        function(self, dt)
            if a >= 0 then
                a = a - 255 / (dur / 2) * dt
            else
                a = 0
                newScene.transitioning = false
            end
        end
    )
    newScene:addDrawFunction(
        function()
            local r, g, b, alpha = love.graphics.getColor()
            love.graphics.setColor(0, 0, 0, a)
            love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
            love.graphics.setColor(r, g, b, alpha)
        end
    )
end

return Transition
