function love.load()
    local ship_class = require "ship"

    player = ship_class:new()
    asteroids = {}
    --asteroid_class:new(200, 200)
end

function love.update(dt) --dt: delta time, time in seconds since last frame
    bulletsToRemove = {}
    player:update(dt)

    function love.mousepressed( x, y, button, istouch, presses)
        if button == 1 then
            local asteroid_class = require "asteroid"
            table.insert(asteroids, asteroid_class:new(x, y))
        end
    end

    for i, bullet in ipairs(player.bullets) do
       bullet:update(dt)

       if bullet.x > WINDOW_WIDTH or bullet.x < 0 or 
       bullet.y > WINDOW_HEIGHT or bullet.y < 0 then
            table.insert(bulletsToRemove, i)
       end
    end

    for _, asteroid in ipairs(asteroids) do
        asteroid:update(dt)
     end

    -- Remove bullets marked for deletion
    for i = #bulletsToRemove, 1, -1 do
        table.remove(player.bullets, bulletsToRemove[i])
    end
end

function love.draw()
    player:draw()

    for _, bullet in ipairs(player.bullets) do
        bullet:draw()
    end

    for _, asteroid in ipairs(asteroids) do
        asteroid:draw()
     end

end

--[[
    to do:
    
    * change asteroid to use big sprite and small sprite instead of love2d.circle()
    
    * player collision with asteroids (reset game state)

    * bullet collision with asteroids (asteroid splits into two smaller asteroids, that go off at an angle from the origial path)
    
    [finish asteroid logic]
        * asteroids should spawn around the margin and point toward the center of the screen on creation
        * spawn a couple asteroids on game start
        * without exceeding a hardcoded limit, (ex. only 12 roids on screen at once) 
          spawn a new asteroid every time a small asteroid is destroyed

    * add a score counter at top middle
--]]