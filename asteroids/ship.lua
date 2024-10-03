require "window"

local Ship = {}
Ship.__index = Ship

function Ship:new()
    --Ship object
    local self = setmetatable({}, Ship)

        --Ship's center (origin)
        self.cx = WINDOW_WIDTH / 2
        self.cy = WINDOW_HEIGHT / 2

        --vertices of triangle
        self.x1, self.y1 = 0,0
        self.x2, self.y2 = 0,0
        self.x3, self.y3 = 0,0

        --Ship velocity
        self.vx, self.vy = 0, 0

        --Ship rotation speed
        self.rspeed = 2.5

        self.angle = math.rad(270)

        self.speed = 5

        self.bullets = {}

    return self
end

        --Ship methods
        function Ship:update(dt)    

            --input and controls
           if love.keyboard.isDown("up") then
               self.vx = self.vx + math.cos(self.angle) * self.speed
               self.vy = self.vy + math.sin(self.angle) * self.speed 
           end
   
           if love.keyboard.isDown("left") then
               self.angle = self.angle - self.rspeed * dt
           end
   
           if love.keyboard.isDown("right") then
               self.angle = self.angle + self.rspeed * dt
           end

            function love.keypressed(key)
                if key == "space" then
                    local b = require "bullet"
                table.insert(self.bullets, b:new(self.cx, self.cy, math.cos(self.angle), math.sin(self.angle)))
                end
            end

            if self.cx < 0 then self.cx = WINDOW_WIDTH end
            if self.cx > WINDOW_WIDTH then self.cx = 0 end
            if self.cy < 0 then self.cy = WINDOW_HEIGHT end
            if self.cy > WINDOW_HEIGHT then self.cy = 0 end
        
   
           --calculate position of ship vertices
           self.x1, self.y1 = self.cx + 10, self.cy + 8
           self.x2, self.y2 = self.cx, self.cy - 15
           self.x3, self.y3 = self.cx - 10, self.cy + 8 
   
           -- apply forces
           self.cx = self.cx + self.vx * dt
           self.cy = self.cy + self.vy * dt
       end
   
       function Ship:draw()
           love.graphics.push() --put off all translations and rotations until pop
           love.graphics.translate(self.cx, self.cy) --move origin of coordinate plane to self center
           love.graphics.rotate(self.angle - math.rad(270)) --rotate entire coordinate plane
           love.graphics.translate(-self.cx, -self.cy) --move origin back
   
           --draw Ship
           love.graphics.polygon("line",
                                  self.x1,self.y1,
                                  self.x2,self.y2,
                                  self.x3,self.y3)
   
           love.graphics.pop() --apply all translations and rotations
       end

return Ship