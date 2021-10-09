require("vector")
require("mover")
require("stableblock")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    love.graphics.setBackgroundColor(128 / 255, 128 / 255, 128 / 255)
    
    location = Vector:create(width/2, height/2)
    
    velocity = Vector:create(0, 0)
    velocity2 = Vector:create(0, 0)

    location2 = Vector:create(width/2, height/3)

    mover = Mover:create(location, velocity, 20, 1)
    wmover = Mover:create(location2, velocity, 50, 5)
    
    --recBlue = Stateblock:create(width/3, height/3, width/4, height/4)
    recBlue = Stableblock:create(50, 20, 100, 80)
    --recRed = Stateblock:create()

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
    mover:applyForce(gravity)
    wmover:applyForce(gravity)

    --mover:applyForce(wind)
    --wmover:applyForce(wind)

    --friction = (mover.velocity * -1):norm()
    
    --if friction then
    --    friction:mul(0.005)
    --   mover:applyForce(friction)
    --    wmover:applyForce(friction)
    --end
    mover:update()
    mover:checkBoundaries()

    wmover:update()
    wmover:checkBoundaries()

end


function love.draw()
    mover:draw()
    wmover:draw()

    recBlue:draw()
    love.graphics.print(tostring(mover.velocity),  mover.location.x + mover.size, mover.location.y)
    love.graphics.print(tostring(wmover.velocity),  wmover.location.x + wmover.size, wmover.location.y)

    --love.graphics.rectangle("fill", width/3, height/3, width/20, height/20)
    --love.graphics.setColor(r, g, b, a)

    love.graphics.print(" w: " .. tostring(isWind) .. " g: " .. tostring(isGravity) .. " f: " .. tostring(isFloating))
    
    --local r, g, b, a = love.graphics.getColor()

    
    --love.graphics.setColor(0, 119/255, 190/255, 0.5)
    --love.graphics.rectangle("fill", width / 3, height / 3, width / 10, height / 10)
    --love.graphics.setColor(r, g, b, a)
    
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