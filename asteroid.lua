require "window"

--asteroid object
local Asteroid = {}
Asteroid.__index = Asteroid

function Asteroid:new(x, y)
    local self = setmetatable({}, Asteroid)
        --asteroid position
        self.x = x
        self.y = y

        self.radius = 70

        self.angle = math.random(0, 359)

        --asteroid velocity
        self.vx, self.vy = math.cos(self.angle), math.sin(self.angle)

        self.speed = 50

    return self
end

--asteroid methods
function Asteroid:update(dt)
    -- apply forces
    self.x = self.x + self.vx * self.speed * dt
    self.y = self.y + self.vy * self.speed * dt
end

function Asteroid:draw()
    love.graphics.push()
    love.graphics.circle("line", self.x, self.y, self.radius)
    love.graphics.pop()
end

return Asteroid