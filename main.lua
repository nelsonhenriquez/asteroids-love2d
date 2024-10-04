love = require "love"

function love.load() -- load: runs the code in here once when the program opens

    local ship_class = require "ship" -- load in code for ship class
    timer_class = require "timer"

    player = ship_class:new() -- create a player from the ship class code
    asteroid_timer = timer_class:new(0)
    asteroids = {} -- create an list of asteroids to track
end

function love.update(dt)
    local bulletsToRemove = {} -- make a list of bullets to remove

    player:update(dt) -- run the player's individual update code

    if not asteroid_timer:isExpired() then 
        asteroid_timer:update(dt) 
    else
        local asteroid_class = require "asteroid" --load the asteroid class code
        table.insert(asteroids, asteroid_class:new(400, 400)) -- make a new asteroid and throw it in the list
        asteroid_timer = timer_class:new(3)
    end

--[[
    this is a for loop, they're kinda weird but basically:

    i: index (an index is a place number assigned to an element in a list)
    bullet: just giving a name (reference) to the element we're grabbing from the table
    ipairs(): a standard function in lua, returns a list of index/value pairs in index numerical order: 
    player.bullets: a list of bullets in the player object

    for every i and bullet (track index and bullet) in the index/bullet list, run whatever code below.
--]]

    for i, bullet in ipairs(player.bullets) do
       bullet:update(dt) -- run bullet class update function

       
       if bullet.x > WINDOW_WIDTH or bullet.x < 0 or -- if bullet leaves the screen space
       bullet.y > WINDOW_HEIGHT or bullet.y < 0 then
            table.insert(bulletsToRemove, i) -- mark that bullet's index down so we can remove the bullet later
       end
    end

    for _, asteroid in ipairs(asteroids) do -- "_" is specifying that the index here is unused in any other code
        asteroid:update(dt)
     end

     for _, bullet in ipairs(player.bullets) do
        for i, asteroid in ipairs(asteroids) do
            if asteroid.x - asteroid.radius < bullet.x and bullet.x < asteroid.x + asteroid.radius and 
            asteroid.y - asteroid.radius < bullet.y and bullet.y < asteroid.y + asteroid.radius then
                table.remove(asteroids, i)
            end
        end
     end

    --[[
        this for loop says: i (index) = #bulletsToRemove (the length of that list)
        for as long as i is greater than or equal to 1,
        subtract 1 from the index every time this code runs.
    --]]

    for i = #bulletsToRemove, 1, -1 do
        table.remove(player.bullets, bulletsToRemove[i]) -- whatever index in bulletsToRemove, delete the element at that index 
    end

end

-- draw: for drawing to screen. runs every time after update
function love.draw()
    player:draw()

    for _, bullet in ipairs(player.bullets) do
        bullet:draw()
    end

    for _, asteroid in ipairs(asteroids) do
        asteroid:draw()
<<<<<<< HEAD

        -- code basically says, if the ships center is within the diameter of the asteroid's hitbox, we're hit.
        if asteroid.x - asteroid.radius < player.cx and player.cx < asteroid.x + asteroid.radius and 
           asteroid.y - asteroid.radius < player.cy and player.cy < asteroid.y + asteroid.radius then
            love.graphics.print("hit", 400,100,0,2,2)
        end
     end
     
=======
     end

>>>>>>> d6b5270a319725a513598b75f4113d71e558430a
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
<<<<<<< HEAD

    GAME LOOP

    game starts with a long asteroid spawn timer, that gets shorter inversely related to how many points the player has.
    the player has 3 lives and when they run out, the game ends.
=======
>>>>>>> d6b5270a319725a513598b75f4113d71e558430a
--]]