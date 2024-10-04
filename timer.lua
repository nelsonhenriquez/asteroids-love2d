local Timer = {}
Timer.__index = Timer

function Timer:new(time)
    --Timer object
    local self = setmetatable({}, Timer)

    self.expired = false
    self.time = time

    return self
end

function Timer:update(dt)
    if self.time < 0 then
          self.expired = true
    end
    self.time = self.time - dt         
end

function Timer:isExpired()
    return self.expired
end

return Timer