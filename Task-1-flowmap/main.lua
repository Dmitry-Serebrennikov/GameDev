require("vector")
require("flowmap")
require("vehicle")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()

   map = FlowMap:create(30)
   map:init()

   vehicles = {}

   for i = 1, 50 do
      vehicles[i] = Vehicle:create(math.random(0, width), math.random(0, height))
      --vehicles[i].velocity = Vector:create(1, 1)
   end

end

function love.update(dt)
   for k,v in pairs(vehicles) do
      v:update()
      v:borders()
	   v:follow(map) 
   end
end

function love.draw()
   map:draw()
   for k,v in pairs(vehicles) do
      v:draw() 
   end
end
