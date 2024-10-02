require "window"

--bullet object
local Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, vx, vy)
    local self = setmetatable({}, Bullet)
        --bullet position
        self.x = x
        self.y = y

        self.radius = 3

        --bullet velocity
        self.vx, self.vy = vx, vy

        self.speed = 700

    return self
end

--bullet methods
function Bullet:update(dt)
    -- apply forces
    self.x = self.x + self.vx * self.speed * dt
    self.y = self.y + self.vy * self.speed * dt
end

function Bullet:draw()
    love.graphics.circle("line", self.x, self.y, self.radius)
end

return Bullet