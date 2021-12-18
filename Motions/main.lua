require("vector")
require("mover")
require("stableblock")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    love.graphics.setBackgroundColor(255 / 255, 255 / 255, 255 / 255)
    --love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255)
    --love.graphics.setBackgroundColor(153 / 255, 153 / 255, 255 / 255)
    --love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)

    location = Vector:create(2.75 * width / 10, height/2)
    
    velocity = Vector:create(0, 0)
    velocity2 = Vector:create(0, 0)

    location2 = Vector:create(6.87 * width / 10, height/3)

    goldMover = Mover:create(location, velocity, 20, 1, {255 / 255, 215 / 255, 0 / 255})
    silverMover = Mover:create(location2, velocity, 50, 5, {192 / 255, 192 / 255, 192 / 255})
    
    blueRec = Stableblock:create(2 * width / 10, height / 10, 150, 300, {30 / 255, 144 / 255, 255 / 255})
    redRec = Stableblock:create(6 * width / 10, height / 10, 150, 300, {220 / 255, 20 / 255, 60 / 255})

    gravity = Vector:create(0, 0.01)
    ------------Внешние силы-------------
    -- wind = Vector:create(0.01, 0)
    -- isWind = false
    -- gravity = Vector:create(0, 0.01)
    -- isGravity = false
    -- floating = Vector:create(0, -0.02)
    -- isFloating = false
    --------------------------------------
end

function love.update()
    goldMover:applyForce(gravity)
    silverMover:applyForce(gravity)
    ------------------does not working-----------------------
    -- if goldMover.location.x > blueRec.width and 
    --     goldMover.location.x < blueRec.width + blueRec.x and
    --     goldMover.location.y > blueRec.height and
    --     goldMover.location.y < blueRec.height + blueRec.y then
    --         goldMover.velocity = Vector:__mul(0)
    -- end 
    ---------------------------------------------------------
    --mover:applyForce(wind)
    --wmover:applyForce(wind)

    friction = (goldMover.velocity * -1):norm()
    
    if friction then
       friction:mul(0.005)
       goldMover:applyForce(friction)
       silverMover:applyForce(friction)
    end
    goldMover:update()
    goldMover:checkBoundaries()

    silverMover:update()
    silverMover:checkBoundaries()

end


function love.draw()
    blueRec:draw()
    redRec:draw()
    
    goldMover:draw()
    silverMover:draw()
    love.graphics.print(tostring(goldMover.velocity),  goldMover.location.x + goldMover.size, goldMover.location.y)
    love.graphics.print(tostring(silverMover.velocity),  silverMover.location.x + silverMover.size, silverMover.location.y)

    love.graphics.print(" w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating))
    
    
end
-----Управлять внешними силами-----
-- function love.keypressed(key)
--     if key == 'g' then
--         isGravity = not isGravity     
--     end

--     if key == 'f' then
--         isFloating = not isFloating     
--     end

--     if key == 'w' then
--         isWind = not isWind
--         if isWind then
--             wind = wind * -1    
--         end
--     end     
-- end
-----------------------------