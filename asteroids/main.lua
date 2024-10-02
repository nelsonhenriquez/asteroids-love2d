function love.load()
    local ship_class = require "ship"

    player = ship_class:new()
end

function love.update(dt) --dt: delta time, time in seconds since last frame
    bulletsToRemove = {}
    player:update(dt)

    for i, bullet in ipairs(player.bullets) do
       bullet:update(dt)

       if bullet.x > WINDOW_WIDTH or bullet.x < 0 or 
       bullet.y > WINDOW_HEIGHT or bullet.y < 0 then
            table.insert(bulletsToRemove, i)
       end
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
end

--[[
    to do:
    * learn how love object release works
    * implement shooting
    * implement spawning asteroids
    * implement screen wrapping]]