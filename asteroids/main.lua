function love.load()

    love.window.setTitle("Asteroids")

    --screen
    WIDTH, HEIGHT = love.window.getMode( )

    --ship object
    ship = {}

    --ship's center (origin)
    ship.cx = WIDTH / 2
    ship.cy = HEIGHT / 2

    --vertices of triangle
    ship.x1, ship.y1 = 0,0
    ship.x2, ship.y2 = 0,0
    ship.x3, ship.y3 = 0,0

    --ship velocity
    ship.vx, ship.vy = 0, 0

    --ship rotation speed
    ship.rspeed = 2.5

    ship.angle = math.rad(270)

    ship.speed = 5
end

function love.update(dt) --dt: delta time, time in seconds since last frame

    --input and controls
    if love.keyboard.isDown("up") then
        ship.vx = ship.vx + math.cos(ship.angle) * ship.speed * dt
        ship.vy = ship.vy + math.sin(ship.angle) * ship.speed * dt
    end

    if love.keyboard.isDown("left") then
        ship.angle = ship.angle - ship.rspeed * dt
    end

    if love.keyboard.isDown("right") then
        ship.angle = ship.angle + ship.rspeed * dt
    end

    updateShip()

end

function updateShip()    
    ship.x1, ship.y1 = ship.cx + 10, ship.cy + 8
    ship.x2, ship.y2 = ship.cx, ship.cy - 15
    ship.x3, ship.y3 = ship.cx - 10, ship.cy + 8 

    ship.cx = ship.cx + ship.vx
    ship.cy = ship.cy + ship.vy   
end

function love.draw()

    drawShip()
    
end

function drawShip()
    love.graphics.push() --put off all translations and rotations until pop
    love.graphics.translate(ship.cx, ship.cy) --move origin of coordinate plane to ship center
    love.graphics.rotate(ship.angle - math.rad(270)) --rotate entire coordinate plane
    love.graphics.translate(-ship.cx, -ship.cy) --move origin back

    --draw ship
    love.graphics.polygon("line",
        ship.x1,ship.y1,
        ship.x2,ship.y2,
        ship.x3,ship.y3)

    love.graphics.pop() --apply all translations and rotations
end