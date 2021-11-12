require("vector")
require("mover")
require("attractor")

function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    G = 0.4

    local location = Vector:create(width / 2 + 100, height / 2)
    attractor = Attractor:create(location, 20)
    
    movers = {}

    for i = 1, 10 do
        local moverLocation = Vector:create(width * math.random(), height * math.random())
        local moverVelocity = Vector:create(math.random(), math.random())
        mover = Mover:create(moverLocation, moverVelocity, 20)
        table.insert(movers, mover)
    end

    --local location2 = Vector:create(width / 3 - 50, height / 3)
    --attractor2 = Attractor:create(location2, 20)
    --local location = Vector:create(300, 350)
    --local velocity = Vector:create(0.1, 0.1)
    --local velocity = Vector:create(1, -1)
    --local velocity2 = Vector:create(1, 1)
    --mover = Mover:create(location, velocity, 20)
    --mover2 = Mover:create(location2, velocity2, 15)

    --movers = {}
    -- for i = 1, 10 do 
    --     local location = Vector:create(math.random(1, width),math.random(1, height))
    --     mover = Mover:create(location, velocity, 20)
    --     table.insert( movers, mover)
    -- end
    -- print(movers[1])
    --for i = 1, 10 do   
   --end
end

function love.update()
    attractor:attract(mover)

    for index1, mover1 in ipairs(movers) do
        for index2, mover2 in ipairs(movers) do
            if index1 ~= index2 then
                mover1:attract(mover2)
                mover1:checkMoverBoundaries(mover2)
            end
        end
        mover1:update()
        mover1:checkMoverBoundaries()
    end
    --attractor2:attract(mover)
    --mover:attract(mover2)
    --mover2:attract(mover)
    --mover:update()
    --mover:checkBoundaries()
    --mover2:update()
    --mover2:checkBoundaries()
end

function love.draw()
    attractor:draw()
    for index, mover in ipairs(movers) do
        mover:draw()
    end
    --attractor2:draw()
    --mover:draw()
    --mover2:draw()
end