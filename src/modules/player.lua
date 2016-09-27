local Player = {}

Player.__index = Player

function Player.new(world, controller, x, y)
    local inst = {}
    setmetatable(inst, Player)

    world.player = inst
    inst.controller = controller
    inst.x = x
    inst.y = y

    return inst
end

return Player
