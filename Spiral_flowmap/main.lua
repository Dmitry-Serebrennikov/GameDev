require("vector")
require("flowmap")
require("vehicle")


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    flow = FlowMap:create(40)
    flow:init()

    vehicle = Vehicle:create(width / 2, height / 2)
    vehicle.velocity.x = 0.1
    vehicle.velocity.y = 0.2
end

function love.update(dt)
    vehicle:borders()
    vehicle:update()
    vehicle:follow(flow)
end

function love.draw()
    flow:draw()
    vehicle:draw()
end
require("vector")
require("flowmap")
require("vehicle")


function love.load()
    width = love.graphics.getWidth()
    height = love.graphics.getHeight()
    
    flow = FlowMap:create(40)
    flow:init()

    vehicle = Vehicle:create(width / 2, height / 2)
    vehicle.velocity.x = 0.1
    vehicle.velocity.y = 0.2
end

function love.update(dt)
    vehicle:borders()
    vehicle:update()
    vehicle:follow(flow)
end

function love.draw()
    flow:draw()
    vehicle:draw()
end