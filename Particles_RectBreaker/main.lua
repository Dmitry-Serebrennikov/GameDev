require("vector")
require("particle")

function love.load()
   width = love.graphics.getWidth()
   height = love.graphics.getHeight()
   --particle = Particle:create(Vector:create(width / 2, height / 2))
   
   particles = {}
   for i = 1, 17 do 
      local location = Vector:create(math.random(1, width), math.random(1, height))
      particle = Particle:create(location)
      table.insert(particles, particle)
   end
   
   --system = ParticleSystem:create(Vector:create(width / 2, height / 2), 100)
   --gravity = Vector:create(0, 0.1)
end

function love.update(dt)
    --particle:update()
    --system:applyForce(gravity)
    --system:update()

   for index, particle in ipairs(particles) do
      particle:update()  
   end

end

function love.draw()
   --particle:draw()
   --system:draw()

   for index, particle in ipairs(particles) do
      particle:draw()  
   end
end

function love.mousepressed(x, y, button, istouch, presses)
   if button == 1 then
      for index, particle in ipairs(particles) do
         local x, y = love.mouse.getPosition()
         --if (x)  
      end
   end
end