local Controller = {}
Controller.__index = Controller

function Controller.new(joystick, number)
    local inst = {}
    setmetatable(inst, Controller)

    inst.joystick = joystick
    inst.number = number

    return inst
end

--function Controller:

return Controller
