function love.load()
    player = {}
    player.x, player.y, player.r = 20, 20, 60
end

function love.draw()
    love.graphics.print("Hello World", 400, 300)
    love.graphics.circle("line", player.x, player.y, player.r)
end

function love.update(dt)
   if love.keyboard.isDown("up") then
       player.y = player.y - 100 * dt -- this would increment num by 100 per second
   end

   if love.keyboard.isDown("down") then
       player.y = player.y + 100 * dt -- this would increment num by 100 per second
   end

   if love.keyboard.isDown("left") then
       player.x = player.x - 100 * dt -- this would increment num by 100 per second
   end

   if love.keyboard.isDown("right") then
       player.x = player.x + 100 * dt -- this would increment num by 100 per second
   end
end