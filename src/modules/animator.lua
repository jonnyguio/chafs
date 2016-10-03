local Animator = {}
Animator.__index = Animator

function Animator.new(animations, stateMachine)
    local inst = {}
    setmetatable(inst, Animator)

    if (type(animations) ~= "table") then
        error("animations should be a table containing every animation object of an Player")
    end

    if (type(stateMachine) ~= "table") then
        error("stateMachine it's a translation that is kind of confusing (see animator.txt)")
    end

    inst.animations = animations
    inst.stateMachine = stateMachine
    inst.isPlaying = false
    inst.current = 1
    inst.playingAnimation = animations[inst.current]

    return inst
end

function Animator:attach(Player)
    Player.animator = self
end

function Animator:stop()
    self.isPlaying = false
    self.playingAnimation = animations[inst.current]
end

function Animator:draw(x, y)
    self.playingAnimation:draw(x, y)
end

function Animator:update(dt)
    if not self.isPlaying then return end
    self.playingAnimation:update(dt, self.isPlaying)
    stateResponse = self.stateMachine[self.current].condition()
    if stateResponse then
        self.current = stateResponse
        self.playingAnimation = self.animations[self.current]
        self.playingAnimation:reset()
    end
end

function Animator:play()
    self.isPlaying = true
end

return Animator
