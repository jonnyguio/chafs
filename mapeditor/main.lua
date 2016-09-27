local Map = require "modules.map"

local mapInstance

function love.load()
    mapInstance = Map.new("common/maps/1.map", 100, 100, {})
    mapInstance:open()
end

function love.update()

end

function love.draw()

end

function love.quit()
    mapInstance:close()
end
