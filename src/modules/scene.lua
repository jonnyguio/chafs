local Scene = {}
Scene.__index = Scene

function Scene.new(index)
    local inst = {}
    setmetatable(inst, Scene)

    inst.index = index
    inst.updateFunctions = {}; inst.updateFunctionsSelfs = {}; inst.updateFunctionsArgs = {}
    inst.cameras = {}; inst.camerasIndexBegin = {}; inst.camerasIndexEnd = {}
    inst.drawFunctions = {}; inst.drawFunctionsSelfs = {}; inst.drawFunctionsArgs = {}; inst.drawOrders = {}
    inst.gamepadpressedFunctions = {}; inst.gamepadpressedFunctionsSelfs = {}; inst.gamepadpressedFunctionsArgs = {}    inst.keyboardpressedFunctions = {}; inst.keyboardpressedFunctionsSelfs = {}; inst.keyboardpressedFunctionsArgs = {}

    return inst
end

function Scene:addUpdateFunction(func, _self, args)
    table.insert(self.updateFunctions, func)
    table.insert(self.updateFunctionsSelfs, _self)
    table.insert(self.updateFunctionsArgs, args)
end

function Scene:update(dt)
    for k in pairs(self.updateFunctions) do
        self.updateFunctions[k](self.updateFunctionsSelfs[k], dt, self.updateFunctionsArgs[k])
    end
end

function Scene:addkeyboardpressedFunction(func, _self, args)
    table.insert(self.keyboardpressedFunctions, func)
    table.insert(self.keyboardpressedFunctionsSelfs, _self)
    table.insert(self.keyboardpressedFunctionsArgs, args)
end

function Scene:keyboardpressed()
    print("test")
    for k in pairs(self.keyboardpressedFunctions) do
        self.keyboardpressedFunctions[k](self.keyboardpressedFunctionsSelfs[k], dt, self.keyboardpressedFunctionsArgs[k])
    end
end

function Scene:addgamepadpressedFunction(func, _self, args)
    table.insert(self.gamepadpressedFunctions, func)
    table.insert(self.gamepadpressedFunctionsSelfs, _self)
    table.insert(self.gamepadpressedFunctionsArgs, args)
end

function Scene:gamepadpressed()
    for k in pairs(self.gamepadpressedFunctions) do
        self.gamepadpressedFunctions[k](self.gamepadpressedFunctionsSelfs[k], dt, self.gamepadpressedFunctionsArgs[k])
    end
end

function Scene:addCamera(cam, indexBegin, indexEnd)
    table.insert(self.cameras, cam)
    table.insert(self.camerasIndexBegin, indexBegin)
    table.insert(self.camerasIndexEnd, indexEnd)
end

function Scene:painterReOrder()
    local aux
    local x = #self.drawOrders
    for k = 1, x do
        for j = k, x do
            if self.drawOrders[k] > self.drawOrders[j] then
                --print("reordenei")
                aux = self.drawFunctions[j]
                self.drawFunctions[j] = self.drawFunctions[k]
                self.drawFunctions[k] = aux
                aux = self.drawFunctionsArgs[j]
                self.drawFunctionsArgs[j] = self.drawFunctionsArgs[k]
                self.drawFunctionsArgs[k] = aux
                aux = self.drawFunctionsSelfs[j]
                self.drawFunctionsSelfs[j] = self.drawFunctionsSelfs[k]
                self.drawFunctionsSelfs[k] = aux
                print(self.drawOrders[k], self.drawOrders[j])
                aux = self.drawOrders[j]
                self.drawOrders[j] = self.drawOrders[k]
                self.drawOrders[k] = aux
                print(self.drawOrders[k], self.drawOrders[j])
            end
        end
    end
end

function Scene:addDrawFunction(func, _self, args, drawOrder)
    table.insert(self.drawFunctions, func)
    table.insert(self.drawFunctionsSelfs, _self)
    table.insert(self.drawFunctionsArgs, args)
    table.insert(self.drawOrders, drawOrder)
    self:painterReOrder()
end

function Scene:draw()
    for k in pairs(self.drawFunctions) do
        for j in pairs(self.cameras) do
            if k == self.camerasIndexBegin[j] then
                self.cameras[j]:set()
            end
        end
        self.drawFunctions[k](self.drawFunctionsSelfs[k], self.drawFunctionsArgs)
        for j in pairs(self.cameras) do
            if k == self.camerasIndexEnd[j] then
                self.cameras[j]:unset()
            end
        end
    end
end

return Scene
