local Scene = {}
Scene.__index = Scene

function Scene.new(index)
    local inst = {}
    setmetatable(inst, Scene)

    inst.index = index
    inst.updateFunctions = {}
    inst.updateFunctionsSelfs = {}
    inst.updateFunctionsArgs = {}
    inst.drawFunctions = {}

    return inst
end

function Scene:update(dt)
    for k in pairs(self.updateFunctions) do
        self.updateFunctions[k](self.updateFunctionsSelfs[k], dt, self.updateFunctionsArgs[k])
    end
end

function Scene:addFunctionUpdate(func, _self, args)
    table.insert(self.updateFunctions, func)
    table.insert(self.updateFunctionsSelfs, _self)
    table.insert(self.updateFunctionsArgs, args)
end

return Scene
